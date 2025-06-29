// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:portfolio_flutter/widgets/spaces.dart';

import '../core/functions.dart';
import '../values/values.dart';

class SocialData {
  final IconData iconData;
  final String url;
  final String name;
  final Color? color;

  SocialData({
    required this.name,
    required this.iconData,
    required this.url,
    this.color,
  });
}

class Socials extends StatelessWidget {
  Socials({
    Key? key,
    required this.socialData,
    this.size = Sizes.ICON_SIZE_18,
    this.color,
    this.spacing = Sizes.SIZE_40,
    this.runSpacing = Sizes.SIZE_16,
    this.isHorizontal = true,
  }) : assert(socialData.isNotEmpty),
       super(key: key);

  final List<SocialData> socialData;
  final double size;
  final Color? color;
  final double spacing;
  final double runSpacing;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isHorizontal
          ? Wrap(
              spacing: spacing,
              runSpacing: runSpacing,
              children: _buildSocialIcons(socialData),
            )
          : Column(children: _buildSocialIcons(socialData)),
    );
  }

  List<Widget> _buildSocialIcons(List<SocialData> socialData) {
    List<Widget> items = [];

    for (int index = 0; index < socialData.length; index++) {
      items.add(
        InkWell(
          onTap: () => Functions.launchUrl(socialData[index].url),
          child: Icon(
            socialData[index].iconData,
            color: color ?? socialData[index].color ?? AppColors.accentColor,
            size: size,
          ),
        ),
      );

      // if it is vertical, add spaces
      if (!isHorizontal) {
        items.add(SpaceH30());
      }
    }

    return items;
  }
}
