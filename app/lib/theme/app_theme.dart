import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light({ColorScheme? dynamicScheme}) {
    final scheme =
        dynamicScheme ??
        const ColorScheme(
          brightness: Brightness.light,
          surface: AppColorsLight.surface,
          onSurface: AppColorsLight.onSurface,
          surfaceDim: AppColorsLight.surfaceDim,
          surfaceBright: AppColorsLight.surfaceBright,
          surfaceContainerLowest: AppColorsLight.surfaceContainerLowest,
          surfaceContainerLow: AppColorsLight.surfaceContainerLow,
          surfaceContainer: AppColorsLight.surfaceContainer,
          surfaceContainerHigh: AppColorsLight.surfaceContainerHigh,
          surfaceContainerHighest: AppColorsLight.surfaceContainerHighest,
          onSurfaceVariant: AppColorsLight.onSurfaceVariant,
          inverseSurface: AppColorsLight.inverseSurface,
          onInverseSurface: AppColorsLight.inverseOnSurface,
          outline: AppColorsLight.outline,
          outlineVariant: AppColorsLight.outlineVariant,
          surfaceTint: AppColorsLight.surfaceTint,
          primary: AppColorsLight.primary,
          onPrimary: AppColorsLight.onPrimary,
          primaryContainer: AppColorsLight.primaryContainer,
          onPrimaryContainer: AppColorsLight.onPrimaryContainer,
          primaryFixed: AppColorsLight.primaryFixed,
          primaryFixedDim: AppColorsLight.primaryFixedDim,
          onPrimaryFixed: AppColorsLight.onPrimaryFixed,
          onPrimaryFixedVariant: AppColorsLight.onPrimaryFixedVariant,
          inversePrimary: AppColorsLight.inversePrimary,
          secondary: AppColorsLight.secondary,
          onSecondary: AppColorsLight.onSecondary,
          secondaryContainer: AppColorsLight.secondaryContainer,
          onSecondaryContainer: AppColorsLight.onSecondaryContainer,
          secondaryFixed: AppColorsLight.secondaryFixed,
          secondaryFixedDim: AppColorsLight.secondaryFixedDim,
          onSecondaryFixed: AppColorsLight.onSecondaryFixed,
          onSecondaryFixedVariant: AppColorsLight.onSecondaryFixedVariant,
          tertiary: AppColorsLight.tertiary,
          onTertiary: AppColorsLight.onTertiary,
          tertiaryContainer: AppColorsLight.tertiaryContainer,
          onTertiaryContainer: AppColorsLight.onTertiaryContainer,
          tertiaryFixed: AppColorsLight.tertiaryFixed,
          tertiaryFixedDim: AppColorsLight.tertiaryFixedDim,
          onTertiaryFixed: AppColorsLight.onTertiaryFixed,
          onTertiaryFixedVariant: AppColorsLight.onTertiaryFixedVariant,
          error: AppColorsLight.error,
          onError: AppColorsLight.onError,
          errorContainer: AppColorsLight.errorContainer,
          onErrorContainer: AppColorsLight.onErrorContainer,
        );

    return _buildTheme(scheme);
  }

  static ThemeData dark({ColorScheme? dynamicScheme}) {
    final scheme =
        dynamicScheme ??
        const ColorScheme(
          brightness: Brightness.dark,
          surface: AppColorsDark.surface,
          onSurface: AppColorsDark.onSurface,
          surfaceDim: AppColorsDark.surfaceDim,
          surfaceBright: AppColorsDark.surfaceBright,
          surfaceContainerLowest: AppColorsDark.surfaceContainerLowest,
          surfaceContainerLow: AppColorsDark.surfaceContainerLow,
          surfaceContainer: AppColorsDark.surfaceContainer,
          surfaceContainerHigh: AppColorsDark.surfaceContainerHigh,
          surfaceContainerHighest: AppColorsDark.surfaceContainerHighest,
          onSurfaceVariant: AppColorsDark.onSurfaceVariant,
          inverseSurface: AppColorsDark.inverseSurface,
          onInverseSurface: AppColorsDark.inverseOnSurface,
          outline: AppColorsDark.outline,
          outlineVariant: AppColorsDark.outlineVariant,
          surfaceTint: AppColorsDark.surfaceTint,
          primary: AppColorsDark.primary,
          onPrimary: AppColorsDark.onPrimary,
          primaryContainer: AppColorsDark.primaryContainer,
          onPrimaryContainer: AppColorsDark.onPrimaryContainer,
          primaryFixed: AppColorsDark.primaryFixed,
          primaryFixedDim: AppColorsDark.primaryFixedDim,
          onPrimaryFixed: AppColorsDark.onPrimaryFixed,
          onPrimaryFixedVariant: AppColorsDark.onPrimaryFixedVariant,
          inversePrimary: AppColorsDark.inversePrimary,
          secondary: AppColorsDark.secondary,
          onSecondary: AppColorsDark.onSecondary,
          secondaryContainer: AppColorsDark.secondaryContainer,
          onSecondaryContainer: AppColorsDark.onSecondaryContainer,
          secondaryFixed: AppColorsDark.secondaryFixed,
          secondaryFixedDim: AppColorsDark.secondaryFixedDim,
          onSecondaryFixed: AppColorsDark.onSecondaryFixed,
          onSecondaryFixedVariant: AppColorsDark.onSecondaryFixedVariant,
          tertiary: AppColorsDark.tertiary,
          onTertiary: AppColorsDark.onTertiary,
          tertiaryContainer: AppColorsDark.tertiaryContainer,
          onTertiaryContainer: AppColorsDark.onTertiaryContainer,
          tertiaryFixed: AppColorsDark.tertiaryFixed,
          tertiaryFixedDim: AppColorsDark.tertiaryFixedDim,
          onTertiaryFixed: AppColorsDark.onTertiaryFixed,
          onTertiaryFixedVariant: AppColorsDark.onTertiaryFixedVariant,
          error: AppColorsDark.error,
          onError: AppColorsDark.onError,
          errorContainer: AppColorsDark.errorContainer,
          onErrorContainer: AppColorsDark.onErrorContainer,
        );

    return _buildTheme(scheme);
  }

  static ThemeData _buildTheme(ColorScheme scheme) {
    final textTheme = AppTypography.textTheme(scheme.onSurface);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      iconTheme: IconThemeData(color: scheme.onSurfaceVariant, size: 24),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.marginMobile,
            vertical: 12,
          ),
          minimumSize: const Size(64, AppSpacing.touchTargetMin),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          minimumSize: const Size(64, AppSpacing.touchTargetMin),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
          borderSide: BorderSide(color: scheme.outline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
      ),
    );
  }
}
