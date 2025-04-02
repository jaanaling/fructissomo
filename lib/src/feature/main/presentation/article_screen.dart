import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fructissimo/src/core/utils/size_utils.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/ui_kit/app_app_bar.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:fructissimo/ui_kit/back_container.dart';
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
        final articles = state.article
            .firstWhere((element) =>
                element.articles.any((element) => element.title == id))
            .articles
            .firstWhere((element) => element.title == id);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BackContainer(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    AppAppBar(
                      title: articles.title,
                    ),
                    const Gap(30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: getHeight(context, percent: 0.6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 8), // Смещение тени
                                color: Color(0x80000000), // Цвет тени с прозрачностью
                              ),
                            ],
                          ),
                          child:
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: SingleChildScrollView(child: Text(articles.content)),
                              )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
