import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackContainer extends StatelessWidget {
  final Widget child;
  const BackContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        color: const Color(0xCFFFE396),
        borderRadius: BorderRadius.all(Radius.circular(7)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8), // Смещение тени
            color: Color(0x80000000), // Цвет тени с прозрачностью
          ),
        ],
      ),
    );
  }
}
