import 'package:material_ui/material_ui.dart'
    show
        BuildContext,
        FocusNode,
        FormFieldValidator,
        InputDecoration,
        StatelessWidget,
        TextEditingController,
        TextFormField,
        TextInputAction,
        TextInputType,
        ValueChanged,
        Widget;

/// A labelled text field that participates in the nearest form.
///
/// Pass localised label and error text. Controllers and focus nodes supplied
/// by the caller remain caller-owned.
final class MileSoftTextField extends StatelessWidget {
  const MileSoftTextField({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.enabled = true,
    this.readOnly = false,
    this.validator,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool readOnly;
  final FormFieldValidator<String>? validator;

  /// When supplied, this error takes precedence over [validator].
  final String? errorText;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    focusNode: focusNode,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    enabled: enabled,
    readOnly: readOnly,
    validator: validator,
    forceErrorText: errorText,
    onChanged: onChanged,
    onFieldSubmitted: onSubmitted,
    decoration: InputDecoration(labelText: label),
  );
}
