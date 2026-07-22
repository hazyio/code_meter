class Constraints {
  static const String appVersion = "1.0.0";
  static const double maxRewardPercent = 100;
  static const double minRewardPercent = 1;
  static const int defaultRewardPercent = 40;
  static const bool rollOverDefault = false;
  static const String wakaTimeApiHost = "api.wakatime.com";
  static const String wakaTimeApiStatToday =
      'https://${Constraints.wakaTimeApiHost}/api/v1/users/current/status_bar/today';
  static const String newMissingAppIssueUrl =
      'https://github.com/hazyio/code_meter/issues/new?template=missing_app.yml';
  static const String updateUrl =
      "https://api.github.com/repos/hazyio/code_meter/releases/latest/code_meter.apk";
}
