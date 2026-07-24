import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/pages/home/apps.dart';
import 'package:code_meter/pages/home/history.dart';
import 'package:code_meter/pages/home/dashboard.dart';
import 'package:code_meter/utils/database.dart';
import 'package:code_meter/utils/misc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  DatabaseHelper database = DatabaseHelper();
  bool updateAvailable = false;
  @override
  void initState() {
    super.initState();
    _doChecks();
  }

  Future<void> _doChecks() async {
    if (await updateCheckDue(database)) {
      final isLatest = await isLatestVersion();
      if (isLatest != null) {
        setState(() {
          updateAvailable = updateAvailable;
        });
        await database.updateLastCheck(UpdateChecks.lastUpdate);
      }
    }
    // remove, this could make internet bill go up.
    // if (await updateAllowedAppListDue(database)) {
    //   // silently fail, this is a background task
    //   await updateAllowedAppList(database);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final translation = t;

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60.0,

        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.dashboard_rounded,
              semanticLabel: translation.labels.dashboard,
            ),
            icon: Icon(Icons.dashboard_outlined),
            label: translation.labels.dashboard,
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.widgets,
              semanticLabel: translation.labels.apps,
            ),
            icon: Icon(Icons.widgets_outlined),
            label: translation.labels.apps,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.watch_later),
            icon: Icon(
              Icons.watch_later_outlined,
              semanticLabel: translation.labels.history,
            ),
            label: translation.labels.history,
          ),
        ],
      ),
      body: <Widget>[
        DashBoardSubPage(updateAvailable: updateAvailable),
        AppsSubPage(database: database),
        HistorySubPage(),
      ][currentPageIndex],
    );
  }
}
