import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../core/adaptive.dart';
import '../core/functions.dart';
import '../values/values.dart';
import 'social.dart';
import 'spaces.dart';

class SimpleFooter extends StatelessWidget {
  const SimpleFooter({
    super.key,
    this.height,
    this.width,
    this.backgroundColor = AppColors.black,
  });

  final double? width;
  final double? height;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? widthOfScreen(context),
      height: height ?? assignHeight(context, 0.2),
      color: backgroundColor,
      child: Center(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.isMobile) {
              return Column(
                children: [Spacer(flex: 2), SimpleFooterSm(), Spacer()],
              );
            } else {
              return Column(children: [Spacer(), SimpleFooterLg(), SpaceH20()]);
            }
          },
        ),
      ),
    );
  }
}

class SimpleFooterSm extends StatelessWidget {
  const SimpleFooterSm({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyMedium?.copyWith(
      color: AppColors.accentColor,
      fontSize: Sizes.TEXT_SIZE_14,
    );
    return Column(
      children: [
        Socials(socialData: Data.socialData),
        SpaceH30(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(StringConst.COPYRIGHT, style: style)],
        ),
        SpaceH12(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Functions.launchUrl(StringConst.DESIGN_LINK);
              },
              child: Text(StringConst.DESIGNED_BY),
            ),
          ],
        ),
        SpaceH8(),
        BuiltWithFlutter(),
      ],
    );
  }
}

class SimpleFooterLg extends StatelessWidget {
  const SimpleFooterLg({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyMedium?.copyWith(
      color: Colors.white,
      fontSize: Sizes.TEXT_SIZE_14,
    );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Socials(socialData: Data.socialData)],
        ),
        SpaceH20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(StringConst.COPYRIGHT, style: style),
            SpaceW8(),
            InkWell(
              onTap: () {
                Functions.launchUrl(StringConst.DESIGN_LINK);
              },
              child: Text(
                StringConst.DESIGNED_BY,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        SpaceH8(),
        BuiltWithFlutter(),
      ],
    );
  }
}

class BuiltWithFlutter extends StatelessWidget {
  const BuiltWithFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyMedium?.copyWith(
      color: AppColors.accentColor,
      fontSize: Sizes.TEXT_SIZE_14,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(StringConst.BUILT_WITH_FLUTTER, style: style),
        FlutterLogo(size: 14),
      ],
    );
  }
}
