import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffbfc1ff),
      surfaceTint: Color(0xffbfc1ff),
      onPrimary: Color(0xff282b60),
      primaryContainer: Color(0xff3e4178),
      onPrimaryContainer: Color(0xffe1e0ff),
      secondary: Color(0xffc0ce7d),
      onSecondary: Color(0xff2c3400),
      secondaryContainer: Color(0xff414b08),
      onSecondaryContainer: Color(0xffdcea97),
      tertiary: Color(0xffbbcf82),
      onTertiary: Color(0xff283500),
      tertiaryContainer: Color(0xff3d4c0d),
      onTertiaryContainer: Color(0xffd7eb9b),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff131318),
      onSurface: Color(0xffe4e1e9),
      onSurfaceVariant: Color(0xffc7c5d0),
      outline: Color(0xff918f9a),
      outlineVariant: Color(0xff46464f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1e9),
      inversePrimary: Color(0xff565992),
      primaryFixed: Color(0xffe1e0ff),
      onPrimaryFixed: Color(0xff12144b),
      primaryFixedDim: Color(0xffbfc1ff),
      onPrimaryFixedVariant: Color(0xff3e4178),
      secondaryFixed: Color(0xffdcea97),
      onSecondaryFixed: Color(0xff191e00),
      secondaryFixedDim: Color(0xffc0ce7d),
      onSecondaryFixedVariant: Color(0xff414b08),
      tertiaryFixed: Color(0xffd7eb9b),
      onTertiaryFixed: Color(0xff161f00),
      tertiaryFixedDim: Color(0xffbbcf82),
      onTertiaryFixedVariant: Color(0xff3d4c0d),
      surfaceDim: Color(0xff131318),
      surfaceBright: Color(0xff39383f),
      surfaceContainerLowest: Color(0xff0e0e13),
      surfaceContainerLow: Color(0xff1b1b21),
      surfaceContainer: Color(0xff1f1f25),
      surfaceContainerHigh: Color(0xff2a292f),
      surfaceContainerHighest: Color(0xff35343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd9d9ff),
      surfaceTint: Color(0xffbfc1ff),
      onPrimary: Color(0xff1c1f55),
      primaryContainer: Color(0xff898cc8),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd6e491),
      onSecondary: Color(0xff222900),
      secondaryContainer: Color(0xff8b974d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffd0e596),
      onTertiary: Color(0xff1f2900),
      tertiaryContainer: Color(0xff859851),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff010127),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdddbe6),
      outline: Color(0xffb3b1bb),
      outlineVariant: Color(0xff918f99),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1e9),
      inversePrimary: Color(0xff40437a),
      primaryFixed: Color(0xffe1e0ff),
      onPrimaryFixed: Color(0xff060741),
      primaryFixedDim: Color(0xffbfc1ff),
      onPrimaryFixedVariant: Color(0xff2e3167),
      secondaryFixed: Color(0xffdcea97),
      onSecondaryFixed: Color(0xff0f1300),
      secondaryFixedDim: Color(0xffc0ce7d),
      onSecondaryFixedVariant: Color(0xff313a00),
      tertiaryFixed: Color(0xffd7eb9b),
      onTertiaryFixed: Color(0xff0d1300),
      tertiaryFixedDim: Color(0xffbbcf82),
      onTertiaryFixedVariant: Color(0xff2d3b00),
      surfaceDim: Color(0xff131318),
      surfaceBright: Color(0xff44444a),
      surfaceContainerLowest: Color(0xff07070c),
      surfaceContainerLow: Color(0xff1d1d23),
      surfaceContainer: Color(0xff28272d),
      surfaceContainerHigh: Color(0xff323238),
      surfaceContainerHighest: Color(0xff3e3d43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff0eeff),
      surfaceTint: Color(0xffbfc1ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffbbbdfd),
      onPrimaryContainer: Color(0xff01003c),
      secondary: Color(0xffeaf8a3),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbdca7a),
      onSecondaryContainer: Color(0xff090d00),
      tertiary: Color(0xffe4f9a8),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffb7cb7e),
      onTertiaryContainer: Color(0xff080d00),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff131318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff1eefa),
      outlineVariant: Color(0xffc3c1cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1e9),
      inversePrimary: Color(0xff40437a),
      primaryFixed: Color(0xffe1e0ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffbfc1ff),
      onPrimaryFixedVariant: Color(0xff060741),
      secondaryFixed: Color(0xffdcea97),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc0ce7d),
      onSecondaryFixedVariant: Color(0xff0f1300),
      tertiaryFixed: Color(0xffd7eb9b),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffbbcf82),
      onTertiaryFixedVariant: Color(0xff0d1300),
      surfaceDim: Color(0xff131318),
      surfaceBright: Color(0xff504f56),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1f1f25),
      surfaceContainer: Color(0xff303036),
      surfaceContainerHigh: Color(0xff3b3b41),
      surfaceContainerHighest: Color(0xff47464c),
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
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
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

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  return Theme.of(context).textTheme.apply(fontFamily: "Montserrat");
}
