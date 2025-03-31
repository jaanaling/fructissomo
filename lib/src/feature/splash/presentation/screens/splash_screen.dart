import 'package:flutter/cupertino.dart';
import 'package:fructissimo/src/core/utils/app_icon.dart';
import 'package:fructissimo/src/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../routes/route_value.dart';
import '../../../../core/utils/icon_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startLoading(context);
  }

  Future<void> startLoading(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    context.go(RouteValue.home.path);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(IconProvider.background.buildImageUrl()),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: isIpad(context) ? null : -122,
          bottom: getHeight(context, baseSize: 90),
          child: AppIcon(
            asset: IconProvider.logo.buildImageUrl(),
            width: 465,
            fit: BoxFit.fitWidth,
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 50),
            child: CupertinoActivityIndicator(color: Colors.white)),
      ],
    );
  }
}
