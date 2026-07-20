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
            selectedIcon: Icon(Icons.dashboard),
            icon: Icon(Icons.dashboard_outlined),
            label: translation.dashboard,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.apps_sharp),
            icon: Icon(Icons.apps_outlined),
            label: translation.apps,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.history_rounded),
            icon: Icon(Icons.history_outlined),
            label: translation.history,
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
