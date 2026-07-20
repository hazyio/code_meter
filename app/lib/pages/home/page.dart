import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/pages/home/apps.dart';
import 'package:code_meter/pages/home/history.dart';
import 'package:code_meter/pages/home/dashboard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final translation = t;

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60.0,

        labelBehavior: .onlyShowSelected,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.space_dashboard_rounded,
              semanticLabel: translation.labels.dashboard,
            ),
            icon: Icon(Icons.space_dashboard_outlined),
            label: translation.labels.dashboard,
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.apps,
              semanticLabel: translation.labels.apps,
            ),
            icon: Icon(Icons.apps_outlined),
            label: translation.labels.apps,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.history_toggle_off_rounded),
            icon: Icon(
              Icons.history_toggle_off_outlined,
              semanticLabel: translation.labels.history,
            ),
            label: translation.labels.history,
          ),
        ],
      ),
      body: <Widget>[
        DashBoardSubPage(),
        AppsSubPage(),
        HistorySubPage(),
      ][currentPageIndex],
    );
  }
}
