import 'package:code_meter/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class AppsSubPage extends StatelessWidget {
  const AppsSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.gutter),
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.marginMobile),
        itemCount: 30,
        itemBuilder: (context, index) {
          return Card.outlined(
            margin: const EdgeInsets.only(bottom: AppSpacing.gutter),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Test item ${index + 1}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    '${(index + 1) * 3}m',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
