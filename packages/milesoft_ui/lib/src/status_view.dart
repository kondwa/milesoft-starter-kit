import 'package:material_ui/material_ui.dart';

import 'milesoft_button.dart';
import 'tokens.dart';

/// The state presented by a [MileSoftStatusView].
enum MileSoftStatus { loading, empty, success, error }

/// Presents a localised status with an optional action, such as retry.
///
/// Use a title that identifies the current state. Supply safe display copy
/// for errors. The view scrolls when its content exceeds the available height.
final class MileSoftStatusView extends StatelessWidget {
  const MileSoftStatusView({
    super.key,
    required this.status,
    required this.title,
    this.message,
    this.action,
  });

  final MileSoftStatus status;
  final String title;
  final String? message;
  final ({String label, VoidCallback onPressed})? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final indicator = switch (status) {
      MileSoftStatus.loading => SizedBox.square(
        dimension: MileSoftTokens.spacing.xLarge,
        child: const CircularProgressIndicator(),
      ),
      MileSoftStatus.empty => Icon(
        Icons.inbox_outlined,
        color: colors.onSurfaceVariant,
        size: MileSoftTokens.spacing.xLarge,
      ),
      MileSoftStatus.success => Icon(
        Icons.check_circle_outline,
        color: colors.primary,
        size: MileSoftTokens.spacing.xLarge,
      ),
      MileSoftStatus.error => Icon(
        Icons.error_outline,
        color: colors.error,
        size: MileSoftTokens.spacing.xLarge,
      ),
    };

    return SingleChildScrollView(
      primary: false,
      padding: EdgeInsets.all(MileSoftTokens.spacing.medium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Semantics(
            container: true,
            liveRegion: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ExcludeSemantics(child: indicator),
                SizedBox(height: MileSoftTokens.spacing.small),
                Semantics(
                  header: true,
                  child: Text(
                    title,
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (message case final detail?) ...[
                  SizedBox(height: MileSoftTokens.spacing.small),
                  Text(
                    detail,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
          if (action case final action?) ...[
            SizedBox(height: MileSoftTokens.spacing.medium),
            MileSoftButton(label: action.label, onPressed: action.onPressed),
          ],
        ],
      ),
    );
  }
}
