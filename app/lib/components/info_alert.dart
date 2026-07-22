import 'package:code_meter/theme/app_dimens.dart';
import 'package:code_meter/utils/from_theme.dart';
import 'package:flutter/material.dart';

class InfoAlert extends StatelessWidget {
  const InfoAlert({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.gutter),
      decoration: BoxDecoration(
        color: fromColorScheme(theme).secondaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Row(children: children),
    );
  }
}
