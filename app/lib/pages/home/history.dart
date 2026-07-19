import 'package:code_meter/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class HistorySubPage extends StatelessWidget {
  const HistorySubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.gutter),
      child: Card(
        shadowColor: Colors.transparent,
        margin: const .all(8.0),
        child: SizedBox.expand(
          child: Center(
            child: Text('History', style: theme.textTheme.titleLarge),
          ),
        ),
      ),
    );
  }
}
