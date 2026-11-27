import 'package:material_ui/material_ui.dart'
    show BuildContext, StatelessWidget, Text, Theme, Widget;

/// Text-only MileSoft attribution for placement on a themed surface.
///
/// Supply the localised equivalent of “Powered by MileSoft”.
final class PoweredByMileSoft extends StatelessWidget {
  const PoweredByMileSoft({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      label,
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}
