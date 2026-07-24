import 'package:code_meter/components/info_alert.dart';
import 'package:code_meter/components/loading_button.dart';
import 'package:code_meter/components/locales_selector.dart';
import 'package:code_meter/components/padded_card.dart';
import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/pages/settings/allowed_app_list.dart';
import 'package:code_meter/pages/settings/wakatime_api.dart';
import 'package:code_meter/theme/app_dimens.dart';
import 'package:code_meter/utils/api.dart';
import 'package:code_meter/utils/app_urls.dart';
import 'package:code_meter/utils/constraints.dart';
import 'package:code_meter/utils/database.dart';
import 'package:code_meter/utils/from_theme.dart';
import 'package:code_meter/utils/misc.dart';
import 'package:code_meter/utils/result.dart';
import 'package:code_meter/utils/settings_repository.dart';
import 'package:code_meter/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO: handle errors in initState()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _rewardPercentage = Constraints.defaultRewardPercent;
  bool _rollover = Constraints.rollOverDefault;
  bool _checkingAppUpdate = false;
  bool _checkingAllowedAppListUpdate = false;
  String _updateLastChecked = DateTime.now().toIso8601String();
  String _allowedAppListLastChecked = DateTime.now().toIso8601String();
  final DatabaseHelper _database = DatabaseHelper();
  int _allowedAppCount = 0;
  bool _clearingData = false;

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
    _database.getLastCheck(UpdateChecks.lastUpdate).then((value) {
      if (value != null) {
        setState(() {
          _updateLastChecked = value;
        });
      }
    });
    _database.getLastCheck(UpdateChecks.allowedApps).then((value) {
      if (value != null) {
        setState(() {
          _allowedAppListLastChecked = value;
        });
      }
    });
    _database.countAllowedApps().then((value) {
      if (value != null) {
        setState(() {
          _allowedAppCount = value;
        });
      }
    });
  }

  Future<void> _clearAllData() async {
    setState(() {
      _clearingData = true;
    });
    final clearDatabase = await _database.clearDatabase();
    if (!mounted) return;
    if (!clearDatabase) {
      showSnackBar(
        context,
        t.description.failedToClearData,
        actionLabel: t.labels.tryAgain,
        onPressed: _clearAllData,
      );
      return;
    }
    final clearStorage = await SettingsRepository().clearAll();
    if (!mounted) return;
    if (!clearStorage) {
      showSnackBar(
        context,
        t.description.failedToClearData,
        actionLabel: t.labels.tryAgain,
        onPressed: _clearAllData,
      );
      return;
    }

    await openRoute(context, Routes.welcome);
  }

  Future<void> _showClearDataPrompt() async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${t.labels.clearAppData}?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(t.description.clearAllData)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              child: Text(t.labels.yes),
              onPressed: () async {
                Navigator.of(context).pop();
                _clearAllData();
              },
            ),
            OutlinedButton(
              child: Text(t.labels.no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void checkAppUpdate() async {
    setState(() => _checkingAppUpdate = true);
    final result = await isLatestVersion();
    setState(() {
      _checkingAppUpdate = false;
      _updateLastChecked = DateTime.now().toIso8601String();
    });
    if (!mounted) return;
    if (result == null) {
      showSnackBar(
        context,
        t.errors.errorWhileCheckingUpdate(error: t.labels.unknown),
        actionLabel: t.labels.tryAgain,
        onPressed: checkAppUpdate,
      );
      return;
    }
    _database.updateLastCheck(UpdateChecks.lastUpdate);
    if (result) {
      showSnackBar(context, t.description.appIsUpToDate);
    } else {
      showSnackBar(
        context,
        t.labels.updateAvailable,
        actionLabel: t.labels.update,
        onPressed: () async {
          await openUrl(context, Constraints.updateUrl);
        },
      );
    }
  }

  void tryUpdateAllowedAppList() async {
    setState(() => _checkingAllowedAppListUpdate = true);
    final result = await updateAllowedAppList(_database);
    setState(() {
      _checkingAllowedAppListUpdate = false;
      _updateLastChecked = DateTime.now().toIso8601String();
    });
    if (!mounted) return;
    switch (result) {
      case Ok():
        {
          showSnackBar(context, t.description.allowedAppListUpdateSuccess);
        }
        break;
      case Err(error: final e):
        {
          showSnackBar(
            context,
            t.description.failedToUpdateAllowedApps(error: e),
            actionLabel: t.labels.tryAgain,
            onPressed: tryUpdateAllowedAppList,
          );
        }
        break;
    }
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
      appBar: AppBar(title: Text(translation.labels.settings)),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                thisCard(const LanguageSelector()),
                const SizedBox(height: AppSpacing.marginTablet),

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
                const SizedBox(height: AppSpacing.touchTargetMin),

                thisCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translation.labels.appUpdate,
                        style: fromTextTheme(theme).titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.margin),
                      Text(
                        translation.description.appUpdateLastChecked(
                          version: "V${Constraints.appVersion}",
                          datetime: DateTimeDiffData.from(
                            _updateLastChecked,
                          ).days,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.gutter),
                      LoadingButton(
                        isLoading: _checkingAppUpdate,
                        onPressed: checkAppUpdate,
                        child: Text(translation.labels.checkUpdate),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.marginTablet),
                thisCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translation.labels.allowedAppListUpdate,
                        style: fromTextTheme(theme).titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.margin),
                      Text(
                        translation.description.lastUpdated(
                          prefix: translation.labels.itemsCount(
                            count: _allowedAppCount,
                          ),
                          datetime: DateTimeDiffData.from(
                            _allowedAppListLastChecked,
                          ).days,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.gutter),
                      Row(
                        children: [
                          AllowedAppList(database: _database),
                          const SizedBox(width: AppSpacing.gutter),
                          Expanded(
                            child: LoadingButton(
                              isLoading: _checkingAllowedAppListUpdate,
                              onPressed: tryUpdateAllowedAppList,
                              child: Text(translation.labels.update),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.touchTargetMin),
                LoadingButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                  ),
                  isLoading: _clearingData,
                  onPressed: _showClearDataPrompt,
                  child: Text(translation.labels.clearAppData),
                ),

                const SizedBox(height: AppSpacing.marginTablet),

                TextButton(
                  onPressed: () {
                    openUrl(context, AppUrls.githubRepo);
                  },
                  child: Text(
                    translation.labels.openSourceOnGithub,
                    style: fromTextTheme(theme).bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
