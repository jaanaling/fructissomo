import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fructissimo/src/core/utils/animated_button.dart';


class AppButton extends StatelessWidget {
  final ButtonColors style;
  final VoidCallback? onPressed;
  final Widget? child;
  final String text;
  final Color textColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const AppButton({
    super.key,
    required this.style,
    this.onPressed,
    this.child,
    required this.text,
    this.textColor = Colors.white,
    this.fontSize = 25,
    this.padding =
        const EdgeInsets.symmetric(vertical: 11.34, horizontal: 24.59),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Color(0xFF0C4407),
        ),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: style.borderColor, width: 4),
                gradient: LinearGradient(
                  colors: style.gradientColors,
                  stops: const [0.14, 0.83, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: padding,
                child: child ??
                    Text(
                      text,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 1),
                            blurRadius: 3.1,
                          ),
                        ],
                      ),
                    ),
              ),
            ),
          ),
        ),
      );
  }
}

enum ButtonColors {
  green(
    borderColor: Color(0xFF22C2D3),
    gradientColors: [
      Color(0xFF21FFDA),
      Color(0xFF37B940),
      Color(0xFF1DC772),
    ],
  ),
  purple(
    borderColor: Color(0xFFD322C2),
    gradientColors: [
      Color(0xFF6913B5),
      Color(0xFFA337B9),
      Color(0xFFC71D9C),
    ],
  ),
  red(
    borderColor: Color(0xFFD3223A),
    gradientColors: [
      Color(0xFFFF2125),
      Color(0xFFB93758),
      Color(0xFFC71D53),
    ],
  ),
  orange(
    borderColor: Color(0xFFD32822),
    gradientColors: [
      Color(0xFFFF7D21),
      Color(0xFFB95637),
      Color(0xFFC7641D),
    ],
  );

  final Color borderColor;
  final List<Color> gradientColors;

  const ButtonColors({required this.borderColor, required this.gradientColors});
}
