import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../core/adaptive.dart';
import '../values/values.dart';
import 'animated_text_slide_box_transition.dart';
import 'content_area.dart';
import 'spaces.dart';

class AboutHeader extends StatelessWidget {
  const AboutHeader({super.key, required this.width, required this.controller});

  final double width;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    double spacing = responsiveSize(
      context,
      width * 0.10,
      width * 0.10,
      md: width * 0.05,
    );
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double screenWidth = sizingInformation.screenSize.width;
        if (screenWidth <= RefinedBreakpoints().tabletSmall) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AboutDescription(
                controller: controller,
                width: widthOfScreen(context),
              ),
              SpaceH30(),
              ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image.asset(
                  ImagePath.DEV,
                  fit: BoxFit.cover,
                  width: widthOfScreen(context),
                  height: assignHeight(context, 0.45),
                ),
              ),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ContentArea(
                width: width * 0.49,
                child: AboutDescription(
                  controller: controller,
                  width: width * 0.55,
                ),
              ),
              SizedBox(width: spacing),
              // Image encore plus grande
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: width * 0.5, // Passe à 50% de la largeur totale
                      minWidth: width * 0.40, // Largeur minimale plus grande
                      maxHeight: assignHeight(
                        context,
                        0.90,
                      ), // Hauteur max augmentée
                    ),
                    child: Image.asset(ImagePath.DEV, fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class AboutDescription extends StatelessWidget {
  const AboutDescription({
    super.key,
    required this.controller,
    required this.width,
  });

  final AnimationController controller;
  final double width;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyMedium?.copyWith(
      fontSize: responsiveSize(context, 20, 34, md: 24),
      height: 1.2,
      fontWeight: FontWeight.w200,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedTextSlideBoxTransition(
          controller: controller,
          text: StringConst.ABOUT_DEV_CATCH_LINE_1,
          width: width,
          maxLines: 3,
          textStyle: style,
          color: AppColors.background,
          textAlign: TextAlign.justify,
        ),
        SpaceH8(),
        AnimatedTextSlideBoxTransition(
          controller: controller,
          text: StringConst.ABOUT_DEV_CATCH_LINE_5,
          width: width,
          maxLines: 10,
          textStyle: style,
          color: AppColors.background,
          textAlign: TextAlign.justify,
        ),
        SpaceH8(),
        AnimatedTextSlideBoxTransition(
          controller: controller,
          text: StringConst.ABOUT_DEV_CATCH_LINE_4,
          width: width,
          maxLines: 10,
          textStyle: style,
          color: AppColors.background,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
