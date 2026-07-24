import 'dart:developer' as developer;

import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/utils/api.dart';
import 'package:code_meter/utils/constraints.dart';
import 'package:code_meter/utils/database.dart';
import 'package:code_meter/utils/result.dart';
import 'package:code_meter/utils/time.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

enum Routes { home, analytics, settings, welcome }

Future<void> openRoute(BuildContext context, final Routes route) async {
  switch (route) {
    case Routes.welcome:
      {
        await Navigator.pushNamed(context, '/welcome');
      }
    case Routes.home:
      {
        await Navigator.pushNamed(context, '/home');
      }
      break;
    case Routes.analytics:
      {
        await Navigator.pushNamed(context, '/analytics');
      }
      break;
    case Routes.settings:
      {
        await Navigator.pushNamed(context, '/settings');
      }
      break;
  }
}

void printIfDebug(Object? object) {
  if (kDebugMode) {
    developer.log('', name: 'CodeMeter', error: object);
  }
}

void showSnackBar(
  BuildContext context,
  String message, {
  String actionLabel = "",
  VoidCallback? onPressed,
  int duration = 4,
}) {
  if (actionLabel == "") {
    actionLabel = t.labels.ok;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: duration),
      dismissDirection: DismissDirection.horizontal,
      action: SnackBarAction(
        label: actionLabel,
        onPressed: () {
          onPressed?.call();
        },
      ),
    ),
  );
}

int percentOfSeconds(int percentage, int totalSeconds) {
  final seconds = (percentage / 100) * totalSeconds;
  return seconds.toInt();
}

String formatDuration(int totalSeconds) {
  final hours = totalSeconds ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;

  return '$hours hour${hours == 1 ? '' : 's'} '
      '$minutes minute${minutes == 1 ? '' : 's'} and '
      '$seconds second${seconds == 1 ? '' : 's'}';
}

String percentToTimeString(int percentage, int totalSeconds) {
  if (percentage == 0) {
    return "0 minutes";
  }
  return formatDuration(percentOfSeconds(percentage, totalSeconds));
}

Future<void> openUrl(BuildContext context, final String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showSnackBar(context, 'Could not launch $url');
  }
}

Future<void> copyToClipboard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  showSnackBar(context, 'Copied to clipboard');
}

Future<bool> updateCheckDue(DatabaseHelper database) async {
  printIfDebug("Checking last update data");

  final lastUpdateCheck = await database.getLastCheck(UpdateChecks.lastUpdate);

  if (lastUpdateCheck == null) {
    return true;
  }

  if (DateTimeDiffData.from(lastUpdateCheck).days > 7) {
    return true;
  }
  return false;
}

Future<bool> updateAllowedAppListDue(DatabaseHelper database) async {
  printIfDebug("Checking essential apps last update data");
  final lastUpdateCheck = await database.getLastCheck(UpdateChecks.allowedApps);
  if (lastUpdateCheck == null) {
    return true;
  }

  if (DateTimeDiffData.from(lastUpdateCheck).days > 7) {
    return true;
  }
  return false;
}

Future<Result<String, String>> updateAllowedAppList(
  DatabaseHelper database,
) async {
  printIfDebug("Updating essential apps");
  final fetchList = await getAllowedApps();
  switch (fetchList) {
    case Ok(value: final list):
      {
        if (list.isEmpty) {
          return Err(
            t.description.failedToUpdateAllowedApps(error: t.labels.emptyList),
          );
        }
        if (await database.insertAllowedApps(list)) {
          await database.updateLastCheck(UpdateChecks.allowedApps);
          return Ok(t.labels.ok);
        }
        return Err(
          t.description.failedToUpdateAllowedApps(
            error: t.labels.databaseError(error: t.labels.unknown),
          ),
        );
      }
    case Err(error: final error):
      {
        if (kDebugMode) {
          print(t.description.failedToUpdateAllowedApps(error: error));
        }
        return Err(t.description.failedToUpdateAllowedApps(error: error));
      }
  }
}

/// Returns negative if v1 < v2, positive if v1 > v2, zero if equal.
int compareVersions(String v1, String v2) {
  printIfDebug("comparing versions $v1 and $v2");
  final parts1 = v1.split('.').map(int.parse).toList();
  final parts2 = v2.split('.').map(int.parse).toList();

  for (var i = 0; i < 3; i++) {
    final p1 = i < parts1.length ? parts1[i] : 0;
    final p2 = i < parts2.length ? parts2[i] : 0;
    if (p1 != p2) return p1 - p2;
  }
  printIfDebug("Versions are equal");
  return 0;
}

Future<bool?> isLatestVersion() async {
  final remoteVersion = await fetchLatestAppVersion();
  if (remoteVersion == null) {
    return null;
  }
  return compareVersions(Constraints.appVersion, remoteVersion) == 0;
}
