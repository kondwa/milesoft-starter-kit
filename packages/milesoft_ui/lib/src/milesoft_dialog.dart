import 'package:material_ui/material_ui.dart';

/// A scrollable, labelled Material dialog with caller-supplied actions.
final class MileSoftDialog extends StatelessWidget {
  const MileSoftDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
    this.semanticLabel,
  });

  final String title;
  final Widget content;
  final List<Widget> actions;
  final String? semanticLabel;

  /// Opens a modal dialog and returns the value supplied by its closing action.
  ///
  /// With the default [dismissible] false, provide a visible action that closes
  /// the dialog. Outside taps and platform back requests do not dismiss it.
  static Future<T?> show<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    bool dismissible = false,
  }) => showDialog<T>(
    context: context,
    barrierDismissible: dismissible,
    requestFocus: true,
    builder: (context) =>
        PopScope<T>(canPop: dismissible, child: builder(context)),
  );

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(title),
    content: content,
    actions: actions,
    semanticLabel: semanticLabel,
    scrollable: true,
  );
}
