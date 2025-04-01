import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextWithBorder extends StatelessWidget {
  final String text;
  final Color? borderColor;
  final Color? color;
  final double? fontSize;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final String? fontFamily;
  final TextOverflow? overflow;

  const TextWithBorder(
    this.text, {
    super.key,
    this.borderColor,
    this.fontSize = 35,
    this.letterSpacing,
    this.textAlign,
    this.fontFamily,
    this.color,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: textAlign,
          overflow: overflow,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            letterSpacing: letterSpacing,
            fontFamily: fontFamily ?? 'CHIBOLD',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = borderColor ?? const Color(0xFF4F3D09),
          ),
        ),
        Text(
          text,
          textAlign: textAlign,
          overflow: overflow,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            letterSpacing: letterSpacing,
            fontFamily: fontFamily ?? 'CHIBOLD',
            color: color ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
