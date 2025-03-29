import 'package:fructissimo/src/core/utils/animated_button.dart';
import 'package:fructissimo/src/core/utils/app_icon.dart';
import 'package:fructissimo/src/core/utils/icon_provider.dart';
import 'package:gap/gap.dart';
import 'package:fructissimo/src/core/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fructissimo/src/core/utils/text_with_border.dart';
import 'package:fructissimo/ui_kit/app_button.dart';

class CountTextField extends StatelessWidget {
  const CountTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.setState,
    required this.width,
    this.isDouble = false,
  });

  final TextEditingController controller;
  final String title;
  final VoidCallback setState;
  final double width;
  final bool isDouble;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedButton(
                    onPressed: () {
                      if (isDouble) {
                        if (controller.text.isNotEmpty) {
                          controller.text =
                              (double.parse(controller.text) - 0.1)
                                  .toStringAsFixed(1);
                        } else {
                          controller.text = "0.0";
                        }
                      }
                      if (!isDouble) {
                        if (controller.text.isNotEmpty) {
                          controller.text =
                              (int.parse(controller.text) - 1).toString();
                        } else {
                          controller.text = "0";
                        }
                      }
                      setState();
                    },
                    child: AppIcon(
                      asset: IconProvider.minus.buildImageUrl(),
                      width: 42,
                      height: 42,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.35,
                    child: AppTextField(
                      controller: controller,
                    ),
                  ),
                  AnimatedButton(
                    onPressed: () {
                      if (isDouble) {
                        if (controller.text.isNotEmpty) {
                          controller.text =
                              (double.parse(controller.text) + 0.1)
                                  .toStringAsFixed(1);
                        } else {
                          controller.text = "0.1";
                        }
                      }

                      if (!isDouble) {
                        if (controller.text.isNotEmpty) {
                          controller.text =
                              (int.parse(controller.text) + 1).toString();
                        } else {
                          controller.text = "1";
                        }
                      }
                      setState();
                    },
                    child: AppIcon(
                      asset: IconProvider.plus.buildImageUrl(),
                      width: 42,
                      height: 42,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.number,
    this.title,
    this.backgrund = false,
    this.maxLines,
    this.flex = 0,
    this.isEdit = false,
    this.width = 75,
    this.verticalPadding = 6,
    this.onChanged,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? title;
  final bool backgrund;
  final int? maxLines;
  final int flex;
  final bool isEdit;
  final double width;
  final double verticalPadding;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null)
          Expanded(flex: flex, child: TextWithBorder(title!, fontSize: 23)),
        if (title != null) const Gap(10),
        Expanded(
          flex: flex,
          child: SizedBox(
            width: width,
            child: CupertinoTextField(
              controller: controller,
              keyboardType: keyboardType,
              onChanged: onChanged,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              style: const TextStyle(
                color: Color(0xFF894406),
                fontSize: 17,
              ),
              readOnly: isEdit,
              maxLines: maxLines,
              textAlign: TextAlign.center,
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding,
              ),
              decoration: !backgrund
                  ? null
                  : const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
            ),
          ),
        ),
      ],
    );
  }
}
