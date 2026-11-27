import 'package:material_ui/material_ui.dart';
import 'package:milesoft_core/milesoft_core.dart';
import 'package:milesoft_ui/milesoft_ui.dart';

import 'catalogue.dart';
import 'l10n/app_localizations.dart';

void main() => runApp(const ShowcaseApp());

class ShowcaseApp extends StatefulWidget {
  const ShowcaseApp({super.key});

  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  final _light = MileSoftTheme.build();
  final _dark = MileSoftTheme.build(brightness: Brightness.dark);
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) => MaterialApp(
    onGenerateTitle: (context) => AppLocalizations.of(context)!.showcaseLabel,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      ...GlobalMaterialLocalizations.delegates,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    theme: _light,
    darkTheme: _dark,
    themeMode: _themeMode,
    home: Builder(
      builder: (context) {
        final copy = AppLocalizations.of(context)!;
        final label = normalizeLabel('  ${copy.showcaseLabel}  ');
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(MileSoftTokens.spacing.large),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: MileSoftTokens.spacing.medium),
                    MileSoftButton(
                      label: copy.browseCatalogue,
                      onPressed: () => Navigator.of(context).push<void>(
                        MaterialPageRoute(
                          builder: (context) => ShowcaseCatalogue(
                            themeMode: _themeMode,
                            onThemeChanged: (mode) {
                              setState(() => _themeMode = mode);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
