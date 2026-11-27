import 'package:material_ui/material_ui.dart';
import 'package:milesoft_ui/milesoft_ui.dart';

import 'catalogue_core.dart';
import 'l10n/app_localizations.dart';

class ShowcaseCatalogue extends StatelessWidget {
  const ShowcaseCatalogue({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context)!;
    final destinations = <({String title, Widget child})>[
      (title: copy.coreSection, child: const CoreCatalogue()),
      (title: copy.formsSection, child: const _FormsExample()),
      (title: copy.controlsSection, child: const _ControlsExample()),
      (title: copy.statusSection, child: const _StatusExample()),
      (title: copy.layoutSection, child: const _LayoutExample()),
    ];

    return _CataloguePage(
      title: copy.catalogueTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MileSoftDropdown<ThemeMode>(
            label: copy.themePreference,
            initialValue: themeMode,
            options: [
              (value: ThemeMode.system, label: copy.systemTheme),
              (value: ThemeMode.light, label: copy.lightTheme),
              (value: ThemeMode.dark, label: copy.darkTheme),
            ],
            onChanged: (mode) {
              if (mode != null) onThemeChanged(mode);
            },
          ),
          SizedBox(height: MileSoftTokens.spacing.medium),
          for (final destination in destinations)
            ListTile(
              title: Text(destination.title),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => _CataloguePage(
                    title: destination.title,
                    child: destination.child,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CataloguePage extends StatelessWidget {
  const _CataloguePage({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(MileSoftTokens.spacing.medium),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: SizedBox(width: double.infinity, child: child),
          ),
        ),
      ),
    ),
  );
}

class _FormsExample extends StatelessWidget {
  const _FormsExample();

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context)!;
    return Form(
      child: Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: MileSoftTokens.spacing.medium,
          children: [
            MileSoftTextField(
              label: copy.nameField,
              validator: (value) => value == null || value.trim().isEmpty
                  ? copy.nameRequired
                  : null,
            ),
            MileSoftTextField(label: copy.disabledField, enabled: false),
            MileSoftTextField(label: copy.readOnlyField, readOnly: true),
            MileSoftCheckbox(
              label: copy.agreementField,
              validator: (checked) =>
                  checked == true ? null : copy.agreementRequired,
            ),
            MileSoftSwitch(label: copy.previewField),
            MileSoftRadioGroup<String>(
              label: copy.channelField,
              options: [
                (value: 'email', label: copy.emailOption),
                (value: 'sms', label: copy.smsOption),
              ],
              validator: (value) => value == null ? copy.optionRequired : null,
            ),
            MileSoftDropdown<String>(
              label: copy.frequencyField,
              options: [
                (value: 'daily', label: copy.dailyOption),
                (value: 'weekly', label: copy.weeklyOption),
              ],
              validator: (value) => value == null ? copy.optionRequired : null,
            ),
            MileSoftButton(
              label: copy.validateForm,
              onPressed: () {
                if (Form.of(context).validate()) {
                  MileSoftNotification.show(context, message: copy.formValid);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlsExample extends StatelessWidget {
  const _ControlsExample();

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context)!;
    void activate() =>
        MileSoftNotification.show(context, message: copy.buttonActivated);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: MileSoftTokens.spacing.medium,
      children: [
        Wrap(
          spacing: MileSoftTokens.spacing.small,
          runSpacing: MileSoftTokens.spacing.small,
          children: [
            MileSoftButton(label: copy.filledButton, onPressed: activate),
            MileSoftButton(
              label: copy.tonalButton,
              variant: MileSoftButtonVariant.tonal,
              onPressed: activate,
            ),
            MileSoftButton(
              label: copy.outlinedButton,
              variant: MileSoftButtonVariant.outlined,
              onPressed: activate,
            ),
            MileSoftButton(
              label: copy.textButton,
              variant: MileSoftButtonVariant.text,
              onPressed: activate,
            ),
            MileSoftButton(label: copy.disabledButton, onPressed: null),
            MileSoftButton(
              label: copy.loadingButton,
              loading: true,
              onPressed: activate,
            ),
          ],
        ),
        for (final (variant, title) in [
          (MileSoftCardVariant.elevated, copy.elevatedCard),
          (MileSoftCardVariant.filled, copy.filledCard),
          (MileSoftCardVariant.outlined, copy.outlinedCard),
        ])
          MileSoftCard(
            variant: variant,
            child: Padding(
              padding: EdgeInsets.all(MileSoftTokens.spacing.medium),
              child: Text(title),
            ),
          ),
        MileSoftButton(
          label: copy.openDialog,
          onPressed: () async {
            final confirmed = await MileSoftDialog.show<bool>(
              context,
              builder: (dialogContext) => MileSoftDialog(
                title: copy.dialogTitle,
                content: Text(copy.dialogBody),
                actions: [
                  MileSoftButton(
                    label: copy.cancelAction,
                    variant: MileSoftButtonVariant.text,
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                  ),
                  MileSoftButton(
                    label: copy.confirmAction,
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                  ),
                ],
              ),
            );
            if (confirmed == true && context.mounted) {
              MileSoftNotification.show(context, message: copy.confirmedNotice);
            }
          },
        ),
        MileSoftButton(
          label: copy.showNotification,
          variant: MileSoftButtonVariant.outlined,
          onPressed: () => MileSoftNotification.show(
            context,
            message: copy.notificationMessage,
          ),
        ),
      ],
    );
  }
}

class _StatusExample extends StatelessWidget {
  const _StatusExample();

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MileSoftStatusView(
          status: MileSoftStatus.loading,
          title: copy.loadingTitle,
          message: copy.loadingMessage,
        ),
        MileSoftStatusView(
          status: MileSoftStatus.empty,
          title: copy.emptyTitle,
          message: copy.emptyMessage,
        ),
        MileSoftStatusView(
          status: MileSoftStatus.success,
          title: copy.successTitle,
        ),
        MileSoftStatusView(
          status: MileSoftStatus.error,
          title: copy.errorTitle,
          message: copy.errorMessage,
          action: (
            label: copy.retryAction,
            onPressed: () =>
                MileSoftNotification.show(context, message: copy.retryNotice),
          ),
        ),
      ],
    );
  }
}

class _LayoutExample extends StatelessWidget {
  const _LayoutExample();

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: MileSoftTokens.spacing.large,
      children: [
        MileSoftResponsiveLayout(
          wideMinWidth: 720,
          primary: _Pane(
            title: copy.layoutPrimary,
            detail: copy.layoutPrimaryDetail,
          ),
          secondary: _Pane(
            title: copy.layoutSecondary,
            detail: copy.layoutSecondaryDetail,
          ),
        ),
        PoweredByMileSoft(label: copy.attributionLabel),
      ],
    );
  }
}

class _Pane extends StatelessWidget {
  const _Pane({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) => MileSoftCard(
    child: Padding(
      padding: EdgeInsets.all(MileSoftTokens.spacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: MileSoftTokens.spacing.small,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          Text(detail),
        ],
      ),
    ),
  );
}
