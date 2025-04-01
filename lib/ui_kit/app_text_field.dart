import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fructissimo/src/core/utils/size_utils.dart';
import 'package:fructissimo/ui_kit/app_button.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.number,

    this.flex = 0,
    this.width = 75,
    this.verticalPadding = 6,
    this.onChanged,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;

  final int flex;
  final double width;
  final double verticalPadding;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context, percent: 0.2),
      child: Stack(
        children: [
          SizedBox(      width: getWidth(context, percent: 0.2),child: AppButton(style: ButtonColors.green, text: '',)),
          CupertinoTextField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
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
