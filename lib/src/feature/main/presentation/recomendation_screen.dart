import 'dart:ui';

import 'package:fructissimo/src/core/utils/icon_provider.dart';
import 'package:fructissimo/src/core/utils/text_with_border.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/ui_kit/app_app_bar.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RecomendationScreen extends StatefulWidget {
  const RecomendationScreen({super.key});

  @override
  State<RecomendationScreen> createState() => _RecomendationScreenState();
}

class _RecomendationScreenState extends State<RecomendationScreen> {
  int currentId = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }
        final dog = state.dog;
        final recomendations = dog.getDailyRecommendations();
        final tips = state.tips;

        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 22.0,
            sigmaY: 22.0,
          ),
          child: SafeArea(
            child: Column(
              children: [
                AppAppBar(title: "Recommendations"),
                TextWithBorder(
                  "Daily Calories: ${recomendations.dailyCalories.toStringAsFixed(2)}",
                ),
                TextWithBorder(
                  "Daily Fat: ${recomendations.dailyFat.toStringAsFixed(2)}",
                ),
                TextWithBorder(
                  "Daily Protein: ${recomendations.dailyProtein.toStringAsFixed(2)}",
                ),
                TextWithBorder(
                  "Daily Carbohydrates: ${recomendations.dailyCarbohydrates.toStringAsFixed(2)}",
                ),
                TextWithBorder("Meals Per Day: ${recomendations.mealsPerDay}"),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextWithBorder(tips[currentId].description),
                          ),
                          Gap(28),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AppButton(
                                onPressed: () => setState(() {
                                  if (currentId > 0) {
                                    currentId--;
                                  }
                                }),
                                style: ButtonColors.red,
                                text: "Back",
                              ),
                              AppButton(
                                onPressed: () => setState(() {
                                  if (currentId < tips.length - 1) {
                                    currentId++;
                                  }
                                }),
                                style: ButtonColors.green,
                                text: "Next",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        );
      },
    );
  }
}
