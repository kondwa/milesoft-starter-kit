import 'package:material_ui/material_ui.dart';
import 'package:milesoft_core/milesoft_core.dart';

import 'l10n/app_localizations.dart';

void main() => runApp(const ShowcaseApp());

class ShowcaseApp extends StatelessWidget {
  const ShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.showcaseLabel,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(useMaterial3: true),
      home: Builder(
        builder: (context) {
          final label = AppLocalizations.of(context)!.showcaseLabel;
          return _ShowcaseHome(label: normalizeLabel('  $label  '));
        },
      ),
    );
  }
}

class _ShowcaseHome extends StatelessWidget {
  const _ShowcaseHome({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
