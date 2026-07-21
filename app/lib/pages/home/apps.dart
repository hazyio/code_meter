import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/theme/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppsSubPage extends StatefulWidget {
  const AppsSubPage({super.key});

  @override
  State<AppsSubPage> createState() => _AppsSubPageState();
}

enum AppType { installed, system, all }

class _AppsSubPageState extends State<AppsSubPage> {
  bool _gettingApps = true;
  List<AppInfo> _cachedAppsList = [];
  List<AppInfo> _sortedAppsList = [];
  AppType _sortAppBy = AppType.all;

  @override
  void initState() {
    super.initState();
    _loadApps(); // runs exactly once, when this widget is first created
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
      _gettingApps = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  value: AppType.system,
                  label: Text(translation.labels.system),
                  icon: Icon(Icons.computer, size: 14),
                ),
                ButtonSegment<AppType>(
                  value: AppType.installed,
                  label: Text(translation.labels.installed),
                  icon: Icon(Icons.download, size: 14),
                ),
              ],
              selected: <AppType>{_sortAppBy},
              onSelectionChanged: (Set<AppType> newSelection) {
                setState(() {
                  _sortAppBy = newSelection.first;
                  switch (_sortAppBy) {
                    case AppType.all:
                      break;
                    case AppType.system:
                      _sortedAppsList = _cachedAppsList
                          .where((app) => app.isSystemApp)
                          .toList();
                      break;
                    case AppType.installed:
                      _sortedAppsList = _cachedAppsList
                          .where((app) => !app.isSystemApp)
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
                return Card.outlined(
                  margin: const EdgeInsets.only(bottom: AppSpacing.gutter),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.cardPadding),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.small),
                          child: app.icon == null
                              ? Icon(Icons.android, size: 32)
                              : Image.memory(app.icon!, width: 32, height: 32),
                        ),
                        const SizedBox(width: AppSpacing.gutter),
                        Expanded(
                          child: Text(
                            app.name,
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
