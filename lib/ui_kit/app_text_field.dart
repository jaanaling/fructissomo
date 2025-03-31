import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fructissimo/ui_kit/app_button.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.number,
    this.maxLines,
    this.flex = 0,
    this.width = 75,
    this.verticalPadding = 6,
    this.onChanged,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int flex;
  final double width;
  final double verticalPadding;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppButton(style: ButtonColors.green, text: ""),
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
                color: Colors.white,
                fontSize: 25,
              ),
              maxLines: maxLines,
              textAlign: TextAlign.center,
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
