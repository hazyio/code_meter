/// Spacing tokens — mirrors ZenithSpacing from the Compose version.
class AppSpacing {
  AppSpacing._();

  static const double baseline = 4;
  static const double margin = 8;
  static const double marginMobile = 16;
  static const double marginTablet = 24;
  static const double gutter = 16;
  static const double touchTargetMin = 48;
  static const double cardPadding = 24; // "large internal paddings (24dp+)"
}

/// Corner radius tokens — mirrors ZenithShapes from the Compose version.
class AppRadius {
  AppRadius._();

  static const double extraSmall = 4;
  static const double small = 8;
  static const double medium = 12;
  static const double large = 28; // cards, bottom sheets
  static const double extraLarge = 28;
  static const double pill = 999; // fully rounded buttons
}
