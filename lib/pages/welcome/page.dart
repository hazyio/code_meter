import 'package:code_meter/components/full_width.dart';
import 'package:code_meter/theme/app_dimens.dart';
import 'package:code_meter/utils/api.dart';
import 'package:code_meter/utils/app_urls.dart';
import 'package:code_meter/utils/misc.dart';
import 'package:code_meter/utils/result.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _wakaTimeApiController;
  String? _apiKeyError;
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
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              'Connect your WakaTime account and decide how coding hours convert into device usage.',
              style: Theme.of(context).textTheme.titleMedium,
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
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _wakaTimeApiController,
                        decoration: InputDecoration(errorText: _apiKeyError),
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
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              // padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft,
                            ),
                            onPressed: () {
                              openUrl(context, AppUrls.wakaTimeApiPage);
                            },
                            child: Text(
                              'api page.',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
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
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
