import 'dart:convert';
import 'dart:io';

// Verification cases for the resolved workspace graph:
// - showcase -> milesoft_core with a pure Dart core: exit 0.
// - showcase lacks a direct dependency on milesoft_core: exit 1.
// - milesoft_core -> adapter -> Flutter or Firebase: exit 1.
// - workspace packages form a dependency cycle: exit 1.
// - a shared package depends on showcase: exit 1.

void main() {
  final result = Process.runSync(Platform.resolvedExecutable, [
    'pub',
    'deps',
    '--json',
  ]);
  if (result.exitCode != 0) {
    stderr.writeln('Could not inspect the resolved workspace dependencies.');
    stderr.write(result.stderr);
    exitCode = 1;
    return;
  }

  final graph = jsonDecode(result.stdout as String) as Map<String, dynamic>;
  final problems = checkWorkspaceDependencies(graph);
  if (problems.isEmpty) {
    stdout.writeln('Workspace dependency boundaries passed.');
    return;
  }
  for (final problem in problems) {
    stderr.writeln(problem);
  }
  exitCode = 1;
}

List<String> checkWorkspaceDependencies(Map<String, dynamic> graph) {
  const core = 'milesoft_core';
  const showcase = 'showcase';
  final packages = {
    for (final package
        in (graph['packages'] as List).cast<Map<String, dynamic>>())
      package['name'] as String: package,
  };
  final workspace = {
    for (final entry in packages.entries)
      if (entry.value['kind'] == 'root') entry.key,
  };
  if (!workspace.containsAll({core, showcase})) {
    return ['Expected milesoft_core and showcase in the resolved workspace.'];
  }

  final edges = {
    for (final entry in packages.entries)
      entry.key: (entry.value['dependencies'] as List).cast<String>(),
  };
  final problems = <String>[];
  final showcaseDependencies =
      (packages[showcase]!['directDependencies'] as List).cast<String>();
  if (!showcaseDependencies.contains(core)) {
    problems.add(
      'showcase must declare milesoft_core as a runtime dependency.',
    );
  }

  for (final name in _reachable(core, edges)) {
    if (packages[name]?['source'] == 'sdk' ||
        name.startsWith('flutter_') ||
        name == 'firebase' ||
        name.startsWith('firebase_') ||
        name == 'cloud_firestore' ||
        name == 'cloud_functions' ||
        name == 'in_app_purchase' ||
        name.startsWith('in_app_purchase_') ||
        name == 'stripe') {
      problems.add('milesoft_core reaches prohibited dependency $name.');
    }
  }

  for (final name in workspace.difference({showcase, graph['root']})) {
    if (_reachable(name, edges).contains(showcase)) {
      problems.add('Shared workspace package $name depends on showcase.');
    }
  }

  for (final name in workspace) {
    if (_reachable(name, edges).contains(name)) {
      problems.add('Dependency cycle involving workspace package $name.');
    }
  }
  return problems;
}

Set<String> _reachable(String root, Map<String, List<String>> edges) {
  final reached = <String>{};
  final pending = [...?edges[root]];
  while (pending.isNotEmpty) {
    final name = pending.removeLast();
    if (reached.add(name)) {
      pending.addAll(edges[name] ?? const []);
    }
  }
  return reached;
}
