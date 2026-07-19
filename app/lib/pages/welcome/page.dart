import 'package:code_meter/components/full_width.dart';
import 'package:code_meter/components/loading_button.dart';
import 'package:code_meter/components/locales_selector.dart';
import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/theme/app_dimens.dart';
import 'package:code_meter/utils/api.dart';
import 'package:code_meter/utils/app_urls.dart';
import 'package:code_meter/utils/constraints.dart';
import 'package:code_meter/utils/from_theme.dart';
import 'package:code_meter/utils/misc.dart';
import 'package:code_meter/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final translation = t;

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _wakaTimeApiController;
  String? _apiKeyError;
  bool _isVisible = false;
  int _rewardPercentage = Constraints.defaultRewardPercent;
  bool _rollover = false;
  bool _isProcessing = false;
  @override
  void initState() {
    super.initState();
    _wakaTimeApiController = TextEditingController();
  }

  @override
  void dispose() {
    _wakaTimeApiController.dispose();
    super.dispose();
  }

  Future<void> _saveSettings() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isProcessing = true);
      final result = await validateApiKeyRemote(_wakaTimeApiController.text);
      setState(() => _isProcessing = false);
      if (!mounted) return;
      switch (result) {
        case Ok():
          {
            showSnackBar(context, "message");
          }
        case Err(error: final e):
          {
            showSnackBar(
              context,
              e,
              actionLabel: translation.tryAgain,
              onPressed: () async {
                await _saveSettings();
              },
            );
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.marginTablet),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              Text(
                translation.welcomeTitle,
                style: fromTextTheme(theme).headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                translation.welcomeDescription,
                style: fromTextTheme(theme).titleMedium?.copyWith(
                  color: fromColorScheme(theme).secondaryFixedDim,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.cardPadding),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translation.wakaApiKey,
                          style: fromTextTheme(theme).labelLarge,
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _wakaTimeApiController,
                          obscureText: !_isVisible,
                          enabled: !_isProcessing,
                          decoration: InputDecoration(
                            errorText: _apiKeyError,
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.content_paste,
                                    size: 20,
                                  ),
                                  onPressed: () async {
                                    final clipboardData =
                                        await Clipboard.getData('text/plain');
                                    if (clipboardData?.text != null) {
                                      _wakaTimeApiController.text =
                                          clipboardData!.text!;
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    _isVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 20,
                                  ),
                                  onPressed: () =>
                                      setState(() => _isVisible = !_isVisible),
                                ),
                              ],
                            ),
                          ),
                          validator: (value) {
                            final keyCheck = validateApiKeyLocal(value ?? '');
                            switch (keyCheck) {
                              case Ok():
                                return null;
                              case Err(error: final e):
                                return e;
                            }
                          },
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                openUrl(context, AppUrls.wakaTimeApiPage);
                              },
                              child: Text(
                                translation.openWakaTimeApiPage,
                                style: fromTextTheme(theme).bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                translation.rewardPercentage,
                                style: fromTextTheme(theme).labelLarge,
                              ),
                            ),

                            Text(
                              "$_rewardPercentage%",
                              style: fromTextTheme(theme).labelSmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Slider(
                          value: _rewardPercentage.toDouble(),
                          min: Constraints.minRewardPercent,
                          max: Constraints.maxRewardPercent,
                          divisions: Constraints.maxRewardPercent.toInt(),
                          onChanged: _isProcessing
                              ? null
                              : (value) {
                                  setState(() {
                                    _rewardPercentage = value.toInt();
                                  });
                                },
                        ),
                        const SizedBox(height: 15),

                        Container(
                          padding: const EdgeInsets.all(AppSpacing.gutter),
                          decoration: BoxDecoration(
                            color: fromColorScheme(theme).secondaryContainer,
                            borderRadius: BorderRadius.circular(
                              AppRadius.medium,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: fromColorScheme(
                                  theme,
                                ).onSecondaryContainer,
                                size: 15,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  t.codingTime(
                                    convert: percentToTimeString(
                                      _rewardPercentage,
                                      3600,
                                    ),
                                  ),
                                  style: fromTextTheme(theme).bodySmall
                                      ?.copyWith(
                                        color: fromColorScheme(
                                          theme,
                                        ).onSecondaryContainer,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Divider(height: 20),
                        const SizedBox(height: 15),
                        // RollOver
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    translation.allowRollover,
                                    style: fromTextTheme(theme).titleMedium,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    translation.allowRolloverDescription,
                                    style: fromTextTheme(theme).bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: _rollover,

                              onChanged: _isProcessing
                                  ? null
                                  : (bool value) {
                                      setState(() {
                                        _rollover = value;
                                      });
                                    },
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Divider(height: 20),

                        LanguageSelector(),
                        const SizedBox(height: 50),

                        LoadingButton(
                          isLoading: _isProcessing,
                          onPressed: _saveSettings,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(translation.save),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  openUrl(context, AppUrls.githubRepo);
                },
                child: Text(
                  translation.openSourceOnGithub,
                  style: fromTextTheme(theme).bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
