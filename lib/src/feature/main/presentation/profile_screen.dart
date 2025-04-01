import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fructissimo/src/core/utils/app_icon.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/ui_kit/app_button.dart';

import '../../../core/utils/icon_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Center(
            child: CupertinoActivityIndicator(
              color: Colors.white,
            ),
          );
        }
        final articles = state.article;
        return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    AppButton(
                      style: ButtonColors.purple,
                      text: '',
                      padding: EdgeInsets.zero,
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Center(
                          child: AppIcon(
                            asset: IconProvider.diary.buildImageUrl(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AppButton(style: ButtonColors.green, text: 'Aboba')
              ],
            ),
          ),
        );
      },
    );
  }
}
