import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fructissimo/src/core/utils/size_utils.dart';
import 'package:fructissimo/ui_kit/app_button.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.width = 0.2,
    this.verticalPadding = 6,
  });

  final TextEditingController? controller;

  final double width;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context, percent: width),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
              width: getWidth(context, percent: width),
              child: AppButton(
                style: ButtonColors.green,
                text: '',
              )),
          CupertinoTextField(
            controller: controller,
            keyboardType: TextInputType.number,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
            ),
            decoration: BoxDecoration(color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}
