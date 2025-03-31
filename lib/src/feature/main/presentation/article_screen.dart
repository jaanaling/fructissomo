import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/ui_kit/app_app_bar.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:gap/gap.dart';

class ArticleScreen extends StatelessWidget {
  final String id;
  const ArticleScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
       return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }
        final articles = state.article;
        return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                AppAppBar(
                  title: "Diary",
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  separatorBuilder: (context, index) {
                    return Gap(30);
                  },
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return AppButton(
                      style: ButtonColors.green,
                      text: article.category,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}