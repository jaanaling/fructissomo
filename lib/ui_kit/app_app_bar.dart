import 'package:fructissimo/src/core/utils/app_icon.dart';
import 'package:fructissimo/src/core/utils/icon_provider.dart';
import 'package:fructissimo/src/core/utils/size_utils.dart';
import 'package:fructissimo/src/core/utils/text_with_border.dart';
import 'package:fructissimo/src/core/utils/animated_button.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppAppBar extends StatelessWidget {
  final String? title;

  const AppAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context, percent: 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform.rotate(
                  angle: 180 * 3.14 / 180,
                  child: AnimatedButton(
                      onPressed: () => context.pop(),
                      child: AppIcon(
                        asset: IconProvider.arrow.buildImageUrl(),
                        height: 60,
                        width: 60,
                      )),
                ),
              ),
            ),
            Spacer(),
            if (title != null)
              Expanded(
                  flex: 5,
                  child: TextWithBorder(
                    title!,
                    fontSize: 31,
                  )),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
