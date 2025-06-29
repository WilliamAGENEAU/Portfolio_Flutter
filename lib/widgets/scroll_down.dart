import 'package:flutter/material.dart';

import '../values/values.dart';
import 'spaces.dart';

class ScrollDownButton extends StatelessWidget {
  const ScrollDownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RotatedBox(
          quarterTurns: 1,
          child: Text(
            StringConst.SCROLL_DOWN.toUpperCase(),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 12, letterSpacing: 1.7),
          ),
        ),
        SpaceH16(),
        Image.asset(ImagePath.ARROW_DOWN, height: 24),
      ],
    );
  }
}
