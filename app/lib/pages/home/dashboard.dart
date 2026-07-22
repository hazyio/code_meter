import 'package:code_meter/components/full_width.dart';
import 'package:code_meter/components/loading_button.dart';
import 'package:code_meter/components/padded_card.dart';
import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/theme/app_dimens.dart';
import 'package:code_meter/utils/constraints.dart';
import 'package:code_meter/utils/from_theme.dart';
import 'package:code_meter/utils/misc.dart';
import 'package:flutter/material.dart';

class DashBoardSubPage extends StatefulWidget {
  const DashBoardSubPage({
    super.key,
    required this.updateAvailable,
  });
  final bool updateAvailable;

  @override
  State<DashBoardSubPage> createState() => _DashBoardSubPageState();
}

class _DashBoardSubPageState extends State<DashBoardSubPage> {
  final bool _syncing = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translation = t;
    List<Widget> buildUpdateCard() {
      if (!widget.updateAvailable) return [];
      return [
        FullWidth(
          child: PaddedCard(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.small),
            ),
            padding: const EdgeInsets.all(AppSpacing.margin),
            child: Row(
              children: [
                Expanded(child: Text(translation.description.newUpdate)),
                TextButton(
                  onPressed: () {
                    openUrl(context, Constraints.updateUrl);
                  },
                  child: Text(translation.labels.download),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.marginMobile),
      ];
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.baseline),
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.marginTablet,
              left: AppSpacing.gutter,
              right: AppSpacing.gutter,
            ),
            child: Row(
              children: [
                Text(
                  translation.labels.appName,
                  style: fromTextTheme(theme).titleLarge,
                ),
                Expanded(child: SizedBox.fromSize()),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/analytics');
                  },
                  icon: Icon(
                    Icons.analytics,
                    semanticLabel: translation.labels.settings,
                  ),
                ),

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
          const SizedBox(height: AppSpacing.baseline),

          Padding(
            padding: const .all(AppSpacing.marginMobile),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...buildUpdateCard(),
                PaddedCard(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.small),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translation.labels.timeRemaining,
                        style: fromTextTheme(theme).bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        translation.labels.timeCount(hour: 1, minutes: 23),
                        style: fromTextTheme(theme).headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        minHeight: 6,
                        value: 0.5,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.marginMobile),

                Row(
                  children: [
                    Expanded(
                      child: PaddedCard(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.medium),
                        ),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.timelapse, size: 16),
                                const SizedBox(width: AppSpacing.baseline),
                                Text(translation.labels.earned),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.margin),
                            Text(
                              translation.labels.timeCount(
                                hour: 2,
                                minutes: 33,
                              ),
                              style: fromTextTheme(theme).bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.gutter),
                    Expanded(
                      child: PaddedCard(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.medium),
                        ),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.history_outlined, size: 16),
                                const SizedBox(width: AppSpacing.baseline),
                                Text(translation.labels.used),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.margin),
                            Text(
                              translation.labels.timeCount(
                                hour: 2,
                                minutes: 33,
                              ),
                              style: fromTextTheme(theme).bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.marginTablet),
                LoadingButton(
                  isLoading: _syncing,
                  onPressed: () {},
                  child: Text(translation.labels.syncWithWakaTime),
                ),
                Center(
                  child: Text(
                    translation.labels.lastSynced(datetime: "Today, 3:42 PM"),
                    style: fromTextTheme(theme).bodySmall?.copyWith(
                      color: fromColorScheme(theme).secondaryFixedDim,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.marginTablet),
                Text(
                  translation.labels.topUsedApps,
                  style: fromTextTheme(theme).titleLarge,
                ),
                const SizedBox(height: AppSpacing.marginMobile),
                PaddedCard(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.marginMobile),
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // prevent independent scrolling
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return PaddedCard(
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
