import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static Color cream = const Color(0xFFFFF6EB);
  static Color creamLight = const Color(0xFFF9EFE2);
  static Color creamDark = const Color(0xFFF3E7D9);
  static Color beige = const Color(0xFFE8D8C3);
  static Color brown = const Color(0xFFD6C3A9);
  static Color taupe = const Color(0xFFB8A78F);
  static Color grey = const Color(0xFF4A4743);
  static Color black = const Color(0xFF181818);
  static Color darkGrey = const Color(0xFF232323);
  static Color white = Colors.white;

  static ColorScheme creamBlackScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: cream,
      onPrimary: black,
      primaryContainer: creamLight,
      onPrimaryContainer: black,
      secondary: creamDark,
      onSecondary: black,
      secondaryContainer: beige,
      onSecondaryContainer: black,
      tertiary: brown,
      onTertiary: black,
      tertiaryContainer: taupe,
      onTertiaryContainer: black,
      error: Colors.red.shade700,
      onError: white,
      errorContainer: Colors.red.shade900,
      onErrorContainer: white,
      surface: cream,
      onSurface: black,
      onSurfaceVariant: darkGrey,
      outline: grey,
      outlineVariant: darkGrey,
      shadow: black,
      scrim: black,
      inverseSurface: black,
      inversePrimary: cream,
      primaryFixed: cream,
      onPrimaryFixed: black,
      primaryFixedDim: creamLight,
      onPrimaryFixedVariant: black,
      secondaryFixed: creamDark,
      onSecondaryFixed: black,
      secondaryFixedDim: beige,
      onSecondaryFixedVariant: black,
      tertiaryFixed: brown,
      onTertiaryFixed: black,
      tertiaryFixedDim: taupe,
      onTertiaryFixedVariant: black,
      surfaceDim: darkGrey,
      surfaceBright: creamLight,
      surfaceContainerLowest: cream,
      surfaceContainerLow: creamLight,
      surfaceContainer: creamDark,
      surfaceContainerHigh: beige,
      surfaceContainerHighest: taupe,
    );
  }

  ThemeData dark() {
    return theme(creamBlackScheme());
  }

  ThemeData light() {
    return theme(creamBlackScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
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
