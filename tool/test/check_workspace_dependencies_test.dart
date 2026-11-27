import 'dart:io';

import '../check_workspace_dependencies.dart';

Map<String, dynamic> _package(
  String name,
  List<String> dependencies, {
  bool workspace = true,
  String? source,
}) => {
  'name': name,
  'kind': workspace ? 'root' : 'transitive',
  'source': source ?? (workspace ? 'root' : 'hosted'),
  'dependencies': dependencies,
  'directDependencies': dependencies,
};

List<String> _graph({
  List<String> core = const [],
  List<String> ui = const ['flutter', 'material_ui'],
  List<String> showcase = const ['milesoft_core', 'milesoft_ui'],
  List<Map<String, dynamic>> extra = const [],
}) => checkWorkspaceDependencies({
  'root': 'milesoft_starter_kit',
  'packages': [
    _package('milesoft_starter_kit', []),
    _package('milesoft_core', core),
    _package('milesoft_ui', ui),
    _package('showcase', showcase),
    _package('flutter', [], workspace: false, source: 'sdk'),
    _package('material_ui', ['flutter'], workspace: false),
    ...extra,
  ],
});

void _expectContains(List<String> problems, String fragment) {
  if (!problems.any((problem) => problem.contains(fragment))) {
    throw StateError('Expected "$fragment". Found: $problems');
  }
}

void main() {
  final cases = <String, void Function()>{
    'approved graph and public import': () {
      final issues = [
        ..._graph(),
        ...checkWorkspaceImports({
          'apps/showcase/lib/main.dart':
              "import 'package:milesoft_ui/milesoft_ui.dart';",
        }),
      ];
      if (issues.isNotEmpty) throw StateError(issues.toString());
    },
    'showcase needs both direct shared dependencies': () {
      final issues = _graph(showcase: []);
      _expectContains(issues, 'declare milesoft_core');
      _expectContains(issues, 'declare milesoft_ui');
    },
    'core stays pure Dart through adapters': () {
      _expectContains(
        _graph(
          core: ['adapter'],
          extra: [
            _package('adapter', ['material_ui'], workspace: false),
          ],
        ),
        'milesoft_core reaches prohibited dependency flutter',
      );
    },
    'UI cannot directly depend on core': () {
      _expectContains(
        _graph(ui: ['flutter', 'material_ui', 'milesoft_core']),
        'milesoft_ui directly depends on unapproved package milesoft_core',
      );
    },
    'UI cannot reach Firebase through an allowed dependency': () {
      _expectContains(
        _graph(
          extra: [
            _package('material_ui', ['firebase_auth'], workspace: false),
            _package('firebase_auth', [], workspace: false),
          ],
        ),
        'milesoft_ui reaches prohibited dependency firebase_auth',
      );
    },
    'workspace cycles and product coupling': () {
      final issues = _graph(core: ['showcase']);
      _expectContains(issues, 'depends on showcase');
      _expectContains(issues, 'Dependency cycle');
    },
    'consumer package and relative private imports are rejected': () {
      final issues = checkWorkspaceImports({
        'apps/showcase/lib/main.dart': """
import 'package:milesoft_core/src/result.dart';
export '../../../packages/milesoft_ui/lib/src/tokens.dart';
""",
      });
      _expectContains(issues, 'package:milesoft_core/src/result.dart');
      _expectContains(
        issues,
        '../../../packages/milesoft_ui/lib/src/tokens.dart',
      );
    },
    'conditional forbidden import is rejected': () {
      _expectContains(
        checkWorkspaceImports({
          'packages/milesoft_core/lib/src/example.dart':
              "import 'stub.dart' if (dart.library.ui) 'dart:ui';",
        }),
        'dart:ui',
      );
    },
  };
  var failures = 0;
  for (final entry in cases.entries) {
    try {
      entry.value();
      stdout.writeln('PASS ${entry.key}');
    } catch (error) {
      failures++;
      stderr.writeln('FAIL ${entry.key}: $error');
    }
  }
  if (failures != 0) exitCode = 1;
}
