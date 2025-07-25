import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../core/adaptive.dart';
import '../core/functions.dart';
import '../values/values.dart';
import 'aerium_button.dart';
import 'animated_text_slide_box_transition.dart';
import 'empty.dart';
import 'nav_item.dart';
import 'spaces.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.selectedRouteTitle,
    required this.selectedRouteName,
    required this.controller,
    this.selectedRouteTitleStyle,
    this.onMenuTap,
    this.onNavItemWebTap,
    this.hasSideTitle = true,
    this.selectedTitleColor = AppColors.black,
    this.titleColor = AppColors.grey600,
    this.appLogoColor = AppColors.black,
  });

  final String selectedRouteTitle;
  final String selectedRouteName;
  final AnimationController controller;
  final TextStyle? selectedRouteTitleStyle;
  final GestureTapCallback? onMenuTap;
  final bool hasSideTitle;
  final Color titleColor;
  final Color selectedTitleColor;
  final Color appLogoColor;

  /// this handles navigation when on desktops
  final Function(String)? onNavItemWebTap;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double screenWidth = sizingInformation.screenSize.width;

        if (screenWidth <= RefinedBreakpoints().tabletNormal) {
          return mobileNavBar(context);
        } else {
          return webNavBar(context);
        }
      },
    );
  }

  Widget mobileNavBar(BuildContext context) {
    return Container(
      width: widthOfScreen(context),
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.PADDING_30,
        vertical: Sizes.PADDING_24,
      ),
      child: Row(
        children: [
          Spacer(),
          InkWell(
            onTap: onMenuTap,
            child: Icon(
              FeatherIcons.menu,
              size: Sizes.TEXT_SIZE_30,
              color: appLogoColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget webNavBar(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style =
        selectedRouteTitleStyle ??
        textTheme.bodyMedium?.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
          fontSize: Sizes.TEXT_SIZE_12,
        );
    return Container(
      width: widthOfScreen(context),
      height: heightOfScreen(context),
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.PADDING_40,
        vertical: Sizes.PADDING_24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Spacer(),
              ..._buildNavItems(context, menuList: Data.menuItems),
              AeriumButton(
                height: Sizes.HEIGHT_36,
                hasIcon: false,
                width: 80,
                buttonColor: AppColors.surface,
                borderColor: appLogoColor,
                onHoverColor: appLogoColor,
                title: StringConst.RESUME.toUpperCase(),
                onPressed: () {
                  Functions.launchUrl(DocumentPath.CV);
                },
              ),
            ],
          ),
          Spacer(),
          hasSideTitle
              ? RotatedBox(
                  quarterTurns: 3,
                  child: AnimatedTextSlideBoxTransition(
                    controller: controller,
                    text: selectedRouteTitle.toUpperCase(),
                    textStyle: style,
                    color: AppColors.surface,
                  ),
                )
              : Empty(),
          Spacer(),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems(
    BuildContext context, {
    required List<NavItemData> menuList,
  }) {
    List<Widget> items = [];
    for (int index = 0; index < menuList.length; index++) {
      items.add(
        NavItem(
          controller: controller,
          title: menuList[index].name,
          route: menuList[index].route,
          titleColor: titleColor,
          selectedColor: selectedTitleColor,
          index: index + 1,
          isSelected: menuList[index].route == selectedRouteName ? true : false,
          onTap: () {
            if (onNavItemWebTap != null) {
              onNavItemWebTap!(menuList[index].route);
            }
          },
        ),
      );
      items.add(SpaceW24());
    }
    return items;
  }
}
