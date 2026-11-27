import 'dart:convert';
import 'dart:io';

const _core = 'milesoft_core';
const _ui = 'milesoft_ui';
const _showcase = 'showcase';
const _sourceRoots = {
  _core: 'packages/milesoft_core/lib/',
  _ui: 'packages/milesoft_ui/lib/',
  _showcase: 'apps/showcase/lib/',
};

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
  final problems = [
    ...checkWorkspaceDependencies(graph),
    ...checkWorkspaceImports({
      for (final root in _sourceRoots.values)
        for (final entry in Directory(root).listSync(recursive: true))
          if (entry is File && entry.path.endsWith('.dart'))
            entry.path.replaceAll('\\', '/'): entry.readAsStringSync(),
    }),
  ];
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
  final packages = {
    for (final package
        in (graph['packages'] as List).cast<Map<String, dynamic>>())
      package['name'] as String: package,
  };
  final workspace = {
    for (final entry in packages.entries)
      if (entry.value['kind'] == 'root') entry.key,
  };
  if (!workspace.containsAll({_core, _ui, _showcase})) {
    return [
      'Expected milesoft_core, milesoft_ui and showcase in the workspace.',
    ];
  }

  final edges = {
    for (final entry in packages.entries)
      entry.key: (entry.value['dependencies'] as List).cast<String>(),
  };
  final problems = <String>[];
  final showcaseDependencies =
      (packages[_showcase]!['directDependencies'] as List).cast<String>();
  for (final name in {_core, _ui}) {
    if (!showcaseDependencies.contains(name)) {
      problems.add('showcase must declare $name as a runtime dependency.');
    }
  }

  const uiRuntime = {'flutter', 'material_ui'};
  final uiDependencies = (packages[_ui]!['directDependencies'] as List)
      .cast<String>()
      .toSet();
  for (final name in uiDependencies.difference(uiRuntime)) {
    problems.add('milesoft_ui directly depends on unapproved package $name.');
  }
  for (final name in uiRuntime.difference(uiDependencies)) {
    problems.add('milesoft_ui must declare $name as a runtime dependency.');
  }

  for (final name in _reachable(_core, edges)) {
    if (packages[name]?['source'] == 'sdk' ||
        name.startsWith('flutter_') ||
        name == _ui ||
        name == 'material_ui' ||
        name == 'cupertino_ui' ||
        _isServicePackage(name)) {
      problems.add('milesoft_core reaches prohibited dependency $name.');
    }
  }
  for (final name in _reachable(_ui, edges)) {
    if (name == _core || _isServicePackage(name)) {
      problems.add('milesoft_ui reaches prohibited dependency $name.');
    }
  }

  for (final name in workspace.difference({_showcase, graph['root']})) {
    if (_reachable(name, edges).contains(_showcase)) {
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

bool _isServicePackage(String name) =>
    name == 'firebase' ||
    name.startsWith('firebase_') ||
    name == 'cloud_firestore' ||
    name == 'cloud_functions' ||
    name == 'in_app_purchase' ||
    name.startsWith('in_app_purchase_') ||
    name == 'stripe' ||
    name.startsWith('flutter_stripe');

final _directive = RegExp(r'^\s*(?:import|export)\s+([^;]+);', multiLine: true);
final _uriLiteral = RegExp('''['"]([^'"]+)['"]''');

/// Checks import and export directives in workspace library sources.
List<String> checkWorkspaceImports(Map<String, String> sources) {
  final problems = <String>[];
  for (final entry in sources.entries) {
    final owner = _sourceRoots.entries
        .firstWhere((package) => entry.key.startsWith(package.value))
        .key;
    for (final directive in _directive.allMatches(entry.value)) {
      for (final match in _uriLiteral.allMatches(directive[1]!)) {
        final reference = match[1]!;
        final uri = Uri.parse(reference);
        if (uri.scheme == 'package') {
          final target = uri.pathSegments.first;
          final service = _isServicePackage(target);
          final forbidden = switch (owner) {
            _core =>
              target == _ui ||
                  target == 'flutter' ||
                  target.startsWith('flutter_') ||
                  target == 'material_ui' ||
                  target == 'cupertino_ui' ||
                  service,
            _ui => target == _core || service,
            _ => false,
          };
          final sharedPrivate =
              (target == _core || target == _ui) &&
              target != owner &&
              uri.path != '$target/$target.dart';
          if (forbidden ||
              sharedPrivate ||
              (owner != _showcase && target == _showcase)) {
            problems.add('${entry.key} uses prohibited reference $reference.');
          }
        } else if (uri.scheme == 'dart') {
          if (owner == _core && uri.path == 'ui') {
            problems.add('${entry.key} uses prohibited reference $reference.');
          }
        } else {
          final resolved = Uri.parse('file:///${entry.key}').resolveUri(uri);
          if (!resolved.path.startsWith('/${_sourceRoots[owner]}')) {
            problems.add(
              '${entry.key} uses reference outside its library: $reference.',
            );
          }
        }
      }
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
