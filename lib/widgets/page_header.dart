// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../core/adaptive.dart';
import '../values/values.dart';
import 'animated_slide_transtion.dart';
import 'animated_text_slide_box_transition.dart';

class PageHeader extends StatefulWidget {
  const PageHeader({
    super.key,
    required this.headingText,
    required this.headingTextController,
  });

  final String headingText;
  final AnimationController headingTextController;

  @override
  _PageHeaderState createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat();

    animation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset(0, -0.5),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? headingStyle = textTheme.bodyLarge?.copyWith(
      color: AppColors.black,
      fontSize: responsiveSize(context, Sizes.TEXT_SIZE_40, Sizes.TEXT_SIZE_60),
    );
    return SizedBox(
      width: widthOfScreen(context),
      height: heightOfScreen(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Lottie.asset(
              ImagePath.shape,
              fit: BoxFit
                  .contain, // Change BoxFit.cover -> BoxFit.contain pour éviter le débordement
              width:
                  widthOfScreen(context) *
                  0.7, // Réduit la largeur à 50% de l'écran
              height:
                  heightOfScreen(context) *
                  0.7, // Réduit la hauteur à 50% de l'écran
              repeat: true,
              animate: true,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedTextSlideBoxTransition(
              controller: widget.headingTextController,
              text: widget.headingText,
              textStyle: headingStyle,
              color: AppColors.surface,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: Sizes.MARGIN_40),
              child: AnimatedSlideTranstion(
                controller: controller,
                position: animation,
                child: Image.asset(ImagePath.ARROW_DOWN_IOS),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
