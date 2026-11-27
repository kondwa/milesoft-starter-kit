import 'package:material_ui/material_ui.dart';

import 'tokens.dart';

enum MileSoftButtonVariant { filled, tonal, outlined, text }

/// A themed button with caller-controlled loading and enabled states.
final class MileSoftButton extends StatelessWidget {
  const MileSoftButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = MileSoftButtonVariant.filled,
    this.loading = false,
    this.loadingLabel,
    this.semanticLabel,
    this.focusNode,
  });

  final String label;
  final VoidCallback? onPressed;
  final MileSoftButtonVariant variant;
  final bool loading;

  /// Optional localised progress announcement.
  final String? loadingLabel;

  /// Optional accessible name when more context than [label] is needed.
  final String? semanticLabel;

  /// Remains owned by the caller when supplied.
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final action = loading ? null : onPressed;
    final text = semanticLabel == null
        ? Text(label)
        : Semantics(
            label: semanticLabel,
            excludeSemantics: true,
            child: Text(label),
          );
    final child = loading
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox.square(
                dimension: MileSoftTokens.spacing.medium,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  semanticsLabel: loadingLabel,
                ),
              ),
              SizedBox(width: MileSoftTokens.spacing.small),
              Flexible(child: text),
            ],
          )
        : text;

    final button = switch (variant) {
      MileSoftButtonVariant.filled => FilledButton(
        onPressed: action,
        focusNode: focusNode,
        child: child,
      ),
      MileSoftButtonVariant.tonal => FilledButton.tonal(
        onPressed: action,
        focusNode: focusNode,
        child: child,
      ),
      MileSoftButtonVariant.outlined => OutlinedButton(
        onPressed: action,
        focusNode: focusNode,
        child: child,
      ),
      MileSoftButtonVariant.text => TextButton(
        onPressed: action,
        focusNode: focusNode,
        child: child,
      ),
    };

    return loading ? Semantics(liveRegion: true, child: button) : button;
  }
}
