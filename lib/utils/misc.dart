import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  String actionLabel = "Ok",
  VoidCallback? onPressed,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: actionLabel,
        onPressed: () {
          onPressed?.call();
        },
      ),
    ),
  );
}

Future<void> openUrl(BuildContext context, final String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showSnackBar(context, 'Could not launch $url');
  }
}
