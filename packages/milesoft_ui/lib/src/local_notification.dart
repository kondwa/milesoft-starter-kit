import 'package:material_ui/material_ui.dart';

/// Transient in-app feedback presented through the nearest ScaffoldMessenger.
abstract final class MileSoftNotification {
  /// Shows caller-localised [message] using Material's SnackBar semantics.
  static void show(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
