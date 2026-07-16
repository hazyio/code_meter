import 'package:code_meter/components/full_width.dart';
import 'package:code_meter/theme/app_dimens.dart';
import 'package:code_meter/utils/api.dart';
import 'package:code_meter/utils/app_urls.dart';
import 'package:code_meter/utils/from_theme.dart';
import 'package:code_meter/utils/misc.dart';
import 'package:code_meter/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  int _rewardPercentage = 30;
  bool _rollover = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.marginTablet),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Earn Screen Time by Coding',
              style: fromTextTheme(context).headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              'Connect your WakaTime account and decide how coding hours convert into device usage.',
              style: fromTextTheme(context).titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
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
                        'Wakatime API Key',
                        style: fromTextTheme(context).labelLarge,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _wakaTimeApiController,
                        obscureText: !_isVisible,
                        decoration: InputDecoration(
                          errorText: _apiKeyError,
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.content_paste, size: 20),
                                onPressed: () async {
                                  final clipboardData = await Clipboard.getData(
                                    'text/plain',
                                  );
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
                          final keyCheck = validateApiKey(value ?? '');
                          switch (keyCheck) {
                            case Ok():
                              return null;
                            case Err(error: final e):
                              return e;
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Found in your WakaTime",
                            style: fromTextTheme(context).bodySmall?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceBright,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft,
                            ),
                            onPressed: () {
                              openUrl(context, AppUrls.wakaTimeApiPage);
                            },
                            child: Text(
                              'API page.',
                              style: fromTextTheme(context).bodySmall?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceTint,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Reward Percentage",
                              style: fromTextTheme(context).labelLarge,
                            ),
                          ),

                          Badge(
                            label: Text(
                              "Beta",
                              style: fromTextTheme(context).labelSmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                            ),
                          ),
                          Text(
                            "$_rewardPercentage%",
                            style: fromTextTheme(context).labelSmall,
                          ),
                        ],
                      ),

                      Slider(
                        value: _rewardPercentage.toDouble(),
                        min: 0,
                        max: 200,
                        divisions: 200,
                        // label: "$_rewardPercentage%",
                        onChanged: (value) {
                          setState(() {
                            _rewardPercentage = value.toInt();
                          });
                        },
                      ),
                      Divider(
                        height: 20,
                        color: Theme.of(context).colorScheme.surfaceBright,
                      ),
                      Switch(
                        value: _rollover,
                        onChanged: (bool value) {
                          setState(() {
                            _rollover = value;
                          });
                        },
                      ),
                      FullWidth(
                        child: FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // all validators passed — proceed
                            }
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Connect'),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
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
                'Open Source On Github',
                style: fromTextTheme(context).bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
