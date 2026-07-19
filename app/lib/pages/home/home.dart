import 'package:code_meter/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class HomeSubPage extends StatelessWidget {
  const HomeSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // void goToSettingsPage() {
    //   Navigator.pushNamed(context, '/settings');
    // }
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.gutter),
      child: Column(
        children: [
          Expanded(
            // <-- gives Card a bounded height to expand into
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
      ),
    );
  }
}
