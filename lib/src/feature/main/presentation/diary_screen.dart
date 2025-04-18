import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fructissimo/routes/route_value.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/ui_kit/app_app_bar.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

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
                  shrinkWrap: true,        padding: const EdgeInsets.symmetric(horizontal: 12),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  separatorBuilder: (context, index) {
                    return Gap(30);
                  },
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return AppButton(
                      style: ButtonColors.green,   textColor: const Color(0xFF004B19),
                      text: article.category,
                      onPressed: () => context.push(
                          '${RouteValue.home.path}/${RouteValue.diary.path}/${RouteValue.articles.path}',
                          extra: article.category),
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
