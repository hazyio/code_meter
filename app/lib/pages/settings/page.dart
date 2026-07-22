import 'package:code_meter/components/info_alert.dart';
import 'package:code_meter/components/padded_card.dart';
import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/pages/settings/wakatime_api.dart';
import 'package:code_meter/theme/app_dimens.dart';
import 'package:code_meter/utils/api.dart';
import 'package:code_meter/utils/constraints.dart';
import 'package:code_meter/utils/from_theme.dart';
import 'package:code_meter/utils/misc.dart';
import 'package:code_meter/utils/result.dart';
import 'package:code_meter/utils/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _rewardPercentage = Constraints.defaultRewardPercent;
  bool _rollover = false;

  @override
  void initState() {
    super.initState();
    SettingsRepository().getRewardPercentage().then((value) {
      if (value != null) {
        setState(() {
          _rewardPercentage = value;
        });
      }
    });
    SettingsRepository().getAllowRollover().then((value) {
      if (value != null) {
        setState(() {
          _rollover = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final translation = t;
    final theme = Theme.of(context);

    Widget thisCard(Widget child) {
      return PaddedCard(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(translation.labels.settings),
        // actions: [IconButton(icon: Icon(Icons.home), onPressed: _goToHomePage)],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                thisCard(WakatimeApi()),
                const SizedBox(height: AppSpacing.marginTablet),
                thisCard(
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              translation.labels.rewardPercentage,
                              style: fromTextTheme(theme).labelLarge,
                            ),
                          ),

                          Text(
                            "$_rewardPercentage%",
                            style: fromTextTheme(theme).labelSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.margin),
                      Slider(
                        value: _rewardPercentage.toDouble(),
                        min: Constraints.minRewardPercent,
                        max: Constraints.maxRewardPercent,
                        divisions: Constraints.maxRewardPercent.toInt(),
                        onChanged: (value) async {
                          SettingsRepository()
                              .saveRewardPercentage(value.toInt())
                              .then((saved) {
                                if (saved) {
                                  setState(() {
                                    _rewardPercentage = value.toInt();
                                  });
                                } else {
                                  if (!mounted) return;
                                  showSnackBar(
                                    context,
                                    translation.settings.failedToSave(
                                      error: translation.labels.unExpectedError,
                                    ),
                                    actionLabel: translation.labels.tryAgain,
                                  );
                                }
                              });
                        },
                      ),
                      const SizedBox(height: AppSpacing.margin),
                      InfoAlert(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: fromColorScheme(theme).onSecondaryContainer,
                            size: 15,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              t.labels.codingTime(
                                convert: percentToTimeString(
                                  _rewardPercentage,
                                  3600,
                                ),
                              ),
                              style: fromTextTheme(theme).bodySmall?.copyWith(
                                color: fromColorScheme(
                                  theme,
                                ).onSecondaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.marginTablet),
                thisCard(
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translation.labels.allowRollover,
                              style: fromTextTheme(theme).titleMedium,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              translation.description.allowRollover,
                              style: fromTextTheme(theme).bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _rollover,

                        onChanged: (bool value) {
                          SettingsRepository().saveAllowRollover(value).then((
                            saved,
                          ) {
                            if (saved) {
                              setState(() {
                                _rollover = value;
                              });
                            } else {
                              if (!mounted) return;
                              showSnackBar(
                                context,
                                translation.settings.failedToSave(
                                  error: translation.labels.unExpectedError,
                                ),
                                actionLabel: translation.labels.tryAgain,
                              );
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
