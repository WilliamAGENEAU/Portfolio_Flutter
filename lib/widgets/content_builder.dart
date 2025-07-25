import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../core/adaptive.dart';
import '../values/values.dart';
import 'animated_text_slide_box_transition.dart';
import 'empty.dart';
import 'spaces.dart';

class ContentBuilder extends StatelessWidget {
  const ContentBuilder({
    super.key,
    required this.width,
    required this.number,
    required this.section,
    required this.body,
    required this.controller,
    this.title = '',
    this.numberStyle,
    this.sectionStyle,
    this.titleStyle,
    this.heading,
    this.footer,
  });

  final double width;
  final AnimationController controller;
  final String number;
  final String section;
  final String? title;
  final TextStyle? numberStyle;
  final TextStyle? sectionStyle;
  final TextStyle? titleStyle;
  final Widget? heading;
  final Widget body;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    // Augmente la taille pour number et title, et les rend identiques
    TextStyle? defaultNumberStyle = textTheme.bodyLarge?.copyWith(
      fontSize: responsiveSize(context, Sizes.TEXT_SIZE_16, Sizes.TEXT_SIZE_24),
      color: AppColors.black,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 2,
    );
    TextStyle? defaultSectionStyle = defaultNumberStyle?.copyWith(
      color: AppColors.primaryColor,
    );
    TextStyle? defaultTitleStyle = textTheme.bodyLarge?.copyWith(
      fontSize: responsiveSize(context, Sizes.TEXT_SIZE_16, Sizes.TEXT_SIZE_24),
      color: AppColors.black,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 2,
    );
    return SizedBox(
      width: width,
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          double screenWidth = sizingInformation.screenSize.width;

          if (screenWidth <= RefinedBreakpoints().tabletNormal) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedTextSlideBoxTransition(
                      controller: controller,
                      text: number,
                      textStyle: numberStyle ?? defaultNumberStyle,
                      color: AppColors.background,
                    ),
                    SpaceW8(),
                    AnimatedTextSlideBoxTransition(
                      controller: controller,
                      text: section,
                      textStyle: sectionStyle ?? defaultSectionStyle,
                      color: AppColors.background,
                    ),
                  ],
                ),
                SpaceH16(),
                heading ??
                    AnimatedTextSlideBoxTransition(
                      controller: controller,
                      text: title!,
                      textStyle: titleStyle ?? defaultTitleStyle,
                      color: AppColors.background,
                    ),
                SpaceH30(),
                body,
                footer ?? Empty(),
              ],
            );
          } else {
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedTextSlideBoxTransition(
                        controller: controller,
                        text: number,
                        textStyle: numberStyle ?? defaultNumberStyle,
                        color: AppColors.background,
                      ),
                      SpaceW16(),
                      Expanded(
                        child: AnimatedTextSlideBoxTransition(
                          controller: controller,
                          text: section,
                          textStyle: sectionStyle ?? defaultSectionStyle,
                          color: AppColors.background,
                        ),
                      ),
                    ],
                  ),
                ),
                SpaceW40(),
                SizedBox(
                  width: width * 0.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading ??
                          AnimatedTextSlideBoxTransition(
                            controller: controller,
                            text: title!,
                            textStyle: titleStyle ?? defaultTitleStyle,
                            color: AppColors.background,
                          ),
                      SpaceH20(),
                      body,
                      footer ?? Empty(),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
