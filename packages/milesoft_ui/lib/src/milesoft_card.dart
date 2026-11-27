import 'package:material_ui/material_ui.dart';

import 'tokens.dart';

enum MileSoftCardVariant { elevated, filled, outlined }

/// A themed surface for related content.
final class MileSoftCard extends StatelessWidget {
  const MileSoftCard({
    super.key,
    required this.child,
    this.variant = MileSoftCardVariant.elevated,
    this.semanticLabel,
  });

  final Widget child;
  final MileSoftCardVariant variant;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final card = switch (variant) {
      MileSoftCardVariant.elevated => Card(child: child),
      MileSoftCardVariant.filled => Card.filled(
        color: theme.colorScheme.surfaceContainerHighest,
        elevation: MileSoftTokens.elevation.flat,
        child: child,
      ),
      MileSoftCardVariant.outlined => Card.outlined(
        color: theme.colorScheme.surface,
        elevation: MileSoftTokens.elevation.flat,
        shape: _outlinedShape(theme),
        child: child,
      ),
    };

    return semanticLabel == null
        ? card
        : Semantics(label: semanticLabel, container: true, child: card);
  }

  OutlinedBorder _outlinedShape(ThemeData theme) {
    final shape = theme.cardTheme.shape;
    final outline = shape is OutlinedBorder
        ? shape
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MileSoftTokens.radius.medium),
          );
    return outline.copyWith(
      side: BorderSide(color: theme.colorScheme.outlineVariant),
    );
  }
}
