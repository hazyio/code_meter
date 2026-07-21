import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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

Future<Result<String, String>> saveSettings(
  String apiKey,
  int rewardPercent,
  bool allowRollover,
) async {
  // if (!await)
  return Result<String, String>.ok("ok");
}
