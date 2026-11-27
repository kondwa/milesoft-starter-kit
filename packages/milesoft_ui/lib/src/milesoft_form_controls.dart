import 'package:material_ui/material_ui.dart';

/// A labelled checkbox that participates in the nearest [Form].
final class MileSoftCheckbox extends StatelessWidget {
  const MileSoftCheckbox({
    super.key,
    required this.label,
    this.initialValue = false,
    this.enabled = true,
    this.validator,
    this.onChanged,
  });

  final String label;
  final bool initialValue;
  final bool enabled;
  final FormFieldValidator<bool>? validator;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) => _toggleField(
    initialValue: initialValue,
    enabled: enabled,
    validator: validator,
    onChanged: onChanged,
    buildTile: (value, change) => CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: change == null ? null : (value) => change(value!),
    ),
  );
}

/// A labelled switch that participates in the nearest [Form].
final class MileSoftSwitch extends StatelessWidget {
  const MileSoftSwitch({
    super.key,
    required this.label,
    this.initialValue = false,
    this.enabled = true,
    this.validator,
    this.onChanged,
  });

  final String label;
  final bool initialValue;
  final bool enabled;
  final FormFieldValidator<bool>? validator;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) => _toggleField(
    initialValue: initialValue,
    enabled: enabled,
    validator: validator,
    onChanged: onChanged,
    buildTile: (value, change) =>
        SwitchListTile(title: Text(label), value: value, onChanged: change),
  );
}

/// A selectable value and its caller-localised display label.
typedef MileSoftFormOption<T extends Object> = ({T value, String label});

/// A labelled, single-selection radio group in the nearest [Form].
///
/// Options must have unique values. [initialValue], when supplied, identifies
/// one of the options.
final class MileSoftRadioGroup<T extends Object> extends StatelessWidget {
  const MileSoftRadioGroup({
    super.key,
    required this.label,
    required this.options,
    this.initialValue,
    this.enabled = true,
    this.validator,
    this.onChanged,
  });

  final String label;
  final List<MileSoftFormOption<T>> options;
  final T? initialValue;
  final bool enabled;
  final FormFieldValidator<T>? validator;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) => FormField<T>(
    initialValue: initialValue,
    enabled: enabled,
    validator: validator,
    builder: (field) => InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        errorText: field.errorText,
        enabled: enabled,
      ),
      isEmpty: false,
      child: RadioGroup<T>(
        groupValue: field.value,
        onChanged: (value) {
          if (!enabled) return;
          field.didChange(value);
          onChanged?.call(value);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final option in options)
              RadioListTile<T>(
                value: option.value,
                title: Text(option.label),
                enabled: enabled,
              ),
          ],
        ),
      ),
    ),
  );
}

/// A labelled, single-selection dropdown in the nearest [Form].
///
/// Options must have unique values. [initialValue], when supplied, identifies
/// one of the options.
final class MileSoftDropdown<T extends Object> extends StatelessWidget {
  const MileSoftDropdown({
    super.key,
    required this.label,
    required this.options,
    this.initialValue,
    this.enabled = true,
    this.validator,
    this.onChanged,
  });

  final String label;
  final List<MileSoftFormOption<T>> options;
  final T? initialValue;
  final bool enabled;
  final FormFieldValidator<T>? validator;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T>(
    initialValue: initialValue,
    enabled: enabled,
    isExpanded: true,
    decoration: InputDecoration(labelText: label),
    items: [
      for (final option in options)
        DropdownMenuItem<T>(value: option.value, child: Text(option.label)),
    ],
    validator: validator,
    onChanged: enabled ? (value) => onChanged?.call(value) : null,
  );
}

Widget _toggleField({
  required bool initialValue,
  required bool enabled,
  required FormFieldValidator<bool>? validator,
  required ValueChanged<bool>? onChanged,
  required Widget Function(bool value, ValueChanged<bool>? onChanged) buildTile,
}) => FormField<bool>(
  initialValue: initialValue,
  enabled: enabled,
  validator: validator,
  builder: (field) => InputDecorator(
    decoration: InputDecoration(
      errorText: field.errorText,
      enabled: enabled,
      border: InputBorder.none,
      contentPadding: EdgeInsets.zero,
    ),
    child: buildTile(
      field.value ?? initialValue,
      enabled
          ? (value) {
              field.didChange(value);
              onChanged?.call(value);
            }
          : null,
    ),
  ),
);
