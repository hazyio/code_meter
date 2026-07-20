import 'package:code_meter/components/full_width.dart';
import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class DashBoardSubPage extends StatelessWidget {
  const DashBoardSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translation = t;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: AppSpacing.marginMobile,
            left: AppSpacing.gutter,
            right: AppSpacing.gutter,
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/analytics');
                },
                icon: Icon(
                  Icons.analytics,
                  semanticLabel: translation.labels.settings,
                ),
              ),
              Expanded(child: SizedBox.fromSize()),

              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
                icon: Icon(
                  Icons.settings,
                  semanticLabel: translation.labels.settings,
                ),
              ),
            ],
          ),
        ),
        FullWidth(
          child: Card(
            child: Column(
              children: [
                CircularProgressIndicator(
                  value: 0.5,
                  // color: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Card(
            shadowColor: Colors.transparent,
            margin: const .all(8.0),
            child: SizedBox.expand(
              child: Center(
                child: Text('Home', style: theme.textTheme.titleLarge),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
