import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/ui_kit/app_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return Center(
            child: CupertinoActivityIndicator(color: Colors.white,),
          );
        }
        final articles = state.article;
        return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [AppButton(style: ButtonColors.green, text: "Aboba")],
            ),
          ),
        );
      },
    );
  }
}
