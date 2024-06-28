import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 26,fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
    displaySmall: TextStyle(fontSize: 16),
    bodyLarge: TextStyle(fontSize: 26),
    bodyMedium: TextStyle(fontSize: 22),
    bodySmall: TextStyle(fontSize: 18),
    titleLarge: TextStyle(fontSize: 26),
    titleMedium: TextStyle(fontSize: 20),
    titleSmall: TextStyle(fontSize: 14),
    labelLarge: TextStyle(fontSize: 24),
    labelMedium: TextStyle(fontSize: 20),
    labelSmall: TextStyle(fontSize: 16),
    headlineLarge: TextStyle(fontSize: 26),
    headlineMedium: TextStyle(fontSize: 18),
    headlineSmall: TextStyle(fontSize: 14)
  );

  const MaterialTheme();

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff33618d),
      surfaceTint: Color(0xff33618d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd0e4ff),
      onPrimaryContainer: Color(0xff001d35),
      secondary: Color(0xff526070),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd6e4f7),
      onSecondaryContainer: Color(0xff0f1d2a),
      tertiary: Color(0xff6a5779),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xfff1dbff),
      onTertiaryContainer: Color(0xff241532),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff8f9ff),
      onSurface: Color(0xff191c20),
      onSurfaceVariant: Color(0xff42474e),
      outline: Color(0xff73777f),
      outlineVariant: Color(0xffc2c7cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff9ecafc),
      onBackground: Color(0xffd8dae0),
      background: Color(0xfff8f9ff),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0f4570),
      surfaceTint: Color(0xff33618d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4b78a5),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff374453),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff687687),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4d3c5c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff816d90),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8f9ff),
      onSurface: Color(0xff191c20),
      onSurfaceVariant: Color(0xff3e434a),
      outline: Color(0xff5b5f67),
      outlineVariant: Color(0xff767b82),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff9ecafc),
      onBackground: Color(0xffd8dae0),
      background: Color(0xfff8f9ff),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00243f),
      surfaceTint: Color(0xff33618d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff0f4570),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff162331),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff374453),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2b1b39),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4d3c5c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1f242a),
      outline: Color(0xff3e434a),
      outlineVariant: Color(0xff3e434a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xffe1edff),
      onBackground: Color(0xffd8dae0),
      background: Color(0xfff8f9ff),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9ecafc),
      surfaceTint: Color(0xff9ecafc),
      onPrimary: Color(0xff003256),
      primaryContainer: Color(0xff154974),
      onPrimaryContainer: Color(0xffd0e4ff),
      secondary: Color(0xffbac8db),
      onSecondary: Color(0xff243140),
      secondaryContainer: Color(0xff3b4857),
      onSecondaryContainer: Color(0xffd6e4f7),
      tertiary: Color(0xffd5bee5),
      onTertiary: Color(0xff3a2a48),
      tertiaryContainer: Color(0xff514060),
      onTertiaryContainer: Color(0xfff1dbff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101418),
      onSurface: Color(0xffe0e2e8),
      onSurfaceVariant: Color(0xffc2c7cf),
      outline: Color(0xff8c9199),
      outlineVariant: Color(0xff42474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff33618d),
      onBackground: Color(0xff31323e),
      background: Color(0xff36393e),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa4ceff),
      surfaceTint: Color(0xff9ecafc),
      onPrimary: Color(0xff00172c),
      primaryContainer: Color(0xff6894c3),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffbeccdf),
      onSecondary: Color(0xff091725),
      secondaryContainer: Color(0xff8492a4),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffdac2e9),
      onTertiary: Color(0xff1f0f2c),
      tertiaryContainer: Color(0xff9e89ad),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101418),
      onSurface: Color(0xfffafaff),
      onSurfaceVariant: Color(0xffc7cbd3),
      outline: Color(0xff9fa3ab),
      outlineVariant: Color(0xff7f838b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff174b75),
      onBackground: Color(0xff101418),
      background: Color(0xff36393e),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffafaff),
      surfaceTint: Color(0xff9ecafc),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa4ceff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffafaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbeccdf),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9fb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffdac2e9),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101418),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffafaff),
      outline: Color(0xffc7cbd3),
      outlineVariant: Color(0xffc7cbd3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff002c4c),
      onBackground: Color(0xff101418),
      background: Color(0xff36393e),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
