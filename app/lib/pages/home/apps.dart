import 'package:code_meter/components/error_box.dart';
import 'package:code_meter/components/padded_card.dart';
import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/theme/app_dimens.dart';
import 'package:code_meter/utils/constraints.dart';
import 'package:code_meter/utils/database.dart';
import 'package:code_meter/utils/from_theme.dart';
import 'package:code_meter/utils/misc.dart';
import 'package:code_meter/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppsSubPage extends StatefulWidget {
  AppsSubPage({super.key, required this.database});
  DatabaseHelper database = DatabaseHelper();

  @override
  State<AppsSubPage> createState() => _AppsSubPageState();
}

enum AppType { allowed, notAllowed, all }

class _AppsSubPageState extends State<AppsSubPage> {
  bool _gettingApps = true;
  List<AppInfo> _cachedAppsList = [];
  List<AppInfo> _sortedAppsList = [];
  AppType _sortAppBy = AppType.all;
  String? _error;
  List<String> _allowedApps = [];

  @override
  void initState() {
    super.initState();
    _loadApps(); // runs exactly once, when this widget is first created
  }

  Future<void> _loadAllowedApps() async {
    if (!_gettingApps) {
      // set state to loading
      setState(() {
        _gettingApps = true;
      });
    }
    try {
      final allowedAppsList = await widget.database.getAllowedApps();
      setState(() {
        _allowedApps = allowedAppsList
            .map((e) => e['app_id'].toString())
            .toList();
        _gettingApps = false;
        _error = null;
      });
    } catch (e) {
      printIfDebug(e);
      setState(() {
        _error = t.errors.failedLoadAllowedList;
        _gettingApps = false;
      });
    }
  }

  Future<void> _loadApps() async {
    List<AppInfo> apps = await InstalledApps.getInstalledApps(
      excludeSystemApps: false,
      excludeNonLaunchableApps: true,
      withIcon: true,
    );
    if (!mounted) return;
    setState(() {
      _cachedAppsList = apps;
      _sortedAppsList = apps;
    });
    await _loadAllowedApps();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translation = t;
    if (_gettingApps) {
      return SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // keeps content centered, not stretched
            children: [
              CircularProgressIndicator(),
              SizedBox(height: AppSpacing.gutter),
              Text(translation.labels.gettingApps),
            ],
          ),
        ),
      );
    }
    if (_error != null) {
      return SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // keeps content centered, not stretched
            children: [
              ErrorBox(
                children: [
                  Text(_error!, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: AppSpacing.gutter),
                  TextButton(
                    onPressed: _loadAllowedApps,
                    child: Text(translation.labels.tryAgain),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.touchTargetMin),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.baseline),
            SegmentedButton<AppType>(
              segments: [
                ButtonSegment<AppType>(
                  value: AppType.all,
                  label: Text(translation.labels.all),
                  icon: Icon(Icons.widgets, size: 14),
                ),
                ButtonSegment<AppType>(
                  value: AppType.allowed,
                  label: Text(translation.labels.allowed),
                  icon: Icon(Icons.block, size: 14),
                ),
                ButtonSegment<AppType>(
                  value: AppType.notAllowed,
                  label: Text(translation.labels.notAllowed),
                  icon: Icon(Icons.check_circle, size: 14),
                ),
              ],
              selected: <AppType>{_sortAppBy},
              onSelectionChanged: (Set<AppType> newSelection) {
                setState(() {
                  _sortAppBy = newSelection.first;
                  switch (_sortAppBy) {
                    case AppType.all:
                      _sortedAppsList = _cachedAppsList;
                      break;
                    case AppType.notAllowed:
                      _sortedAppsList = _cachedAppsList
                          .where(
                            (app) => !_allowedApps.contains(app.packageName),
                          )
                          .toList();
                      break;
                    case AppType.allowed:
                      _sortedAppsList = _cachedAppsList
                          .where(
                            (app) => _allowedApps.contains(app.packageName),
                          )
                          .toList();
                      break;
                  }
                });
              },
            ),
            const SizedBox(height: AppSpacing.baseline),

            ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.marginMobile),
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // prevent independent scrolling
              itemCount: _sortedAppsList.length,
              itemBuilder: (context, index) {
                final app = _sortedAppsList[index];
                final allowed = _allowedApps.contains(app.packageName);
                return PaddedCard(
                  margin: const EdgeInsets.only(bottom: AppSpacing.baseline),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.small),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.small),
                        child: app.icon == null
                            ? Icon(Icons.android, size: 36)
                            : Image.memory(app.icon!, width: 36, height: 36),
                      ),
                      const SizedBox(width: AppSpacing.gutter),
                      Expanded(
                        child: Text(
                          app.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.gutter),

                      Icon(
                        allowed ? Icons.check_circle : Icons.block,
                        size: 24,
                        color: allowed
                            ? fromColorScheme(theme).onSurfaceVariant
                            : fromColorScheme(theme).error,
                      ),
                    ],
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {
                openUrl(context, Constraints.newMissingAppIssueUrl);
              },
              child: Text(translation.description.reportMissingApp),
            ),
            const SizedBox(height: AppSpacing.marginTablet),
          ],
        ),
      ),
    );
  }
}
