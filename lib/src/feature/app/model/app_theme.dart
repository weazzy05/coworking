import 'package:coworking_mobile/src/core/constant/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// {@template app_theme}
/// An immutable class that holds properties needed
/// to build a [ThemeData] for the app.
/// {@endtemplate}

@immutable
final class AppTheme with Diagnosticable {
  /// {@macro app_theme}
  AppTheme({required this.mode, required this.seed})
      : darkTheme = ThemeData(
          colorSchemeSeed: seed,
          brightness: Brightness.dark,
          fontFamily: 'GTEestiProDisplay',
          useMaterial3: false,
          textTheme: _textTheme,
        ),
        lightTheme = ThemeData(
          colorSchemeSeed: seed,
          brightness: Brightness.light,
          fontFamily: 'GTEestiProDisplay',
          useMaterial3: false,
          textTheme: _textTheme,
        );

  /// The type of theme to use.
  final ThemeMode mode;

  /// The seed color to generate the [ColorScheme] from.
  final Color seed;

  /// The dark [ThemeData] for this [AppTheme].
  final ThemeData darkTheme;

  /// The light [ThemeData] for this [AppTheme].
  final ThemeData lightTheme;

  /// The default [AppTheme].
  static final defaultTheme = AppTheme(
    mode: ThemeMode.light,
    seed: AppColors.purple,
  );

  /// The [ThemeData] for this [AppTheme].
  /// This is computed based on the [mode].
  ThemeData computeTheme() {
    switch (mode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark
            ? darkTheme
            : lightTheme;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('seed', seed));
    properties.add(EnumProperty<ThemeMode>('type', mode));
    properties.add(DiagnosticsProperty<ThemeData>('lightTheme', lightTheme));
    properties.add(DiagnosticsProperty<ThemeData>('darkTheme', darkTheme));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme && seed == other.seed && mode == other.mode;

  @override
  int get hashCode => Object.hash(seed, mode);
}

// TODO(gamzat): implement theming
final _textTheme = TextTheme(
  titleLarge: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 28 / 24,
    color: AppColors.textColor,
  ),
  titleMedium: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 25.5 / 22,
    color: AppColors.white,
  ),
  titleSmall: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 23.2 / 20,
    color: AppColors.textColor,
  ),
  labelLarge: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 20.88 / 18,
    color: AppColors.white,
  ),
  labelMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 18 / 16,
    color: AppColors.white,
  ),
  labelSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.white,
  ),
);
