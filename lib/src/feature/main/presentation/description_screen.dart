import 'dart:ui' as ui;

import 'package:fructissimo/src/core/utils/text_with_border.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/ui_kit/app_app_bar.dart';
import 'package:fructissimo/ui_kit/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescriptionScreen extends StatelessWidget {
  final int id;
  const DescriptionScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }
        final item = state.food[id];

        return BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 22.0,
            sigmaY: 22.0,
          ),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  AppAppBar(title: item.name),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.28),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          spacing: 10,
                          children: [
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWithBorder("Calories: "),
                                  AppTextField(
                                    controller: TextEditingController(
                                      text: item.calories.toString(),
                                    ),
                                    isEdit: true,
                                    backgrund: true,
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWithBorder("Fat: "),
                                AppTextField(
                                  controller: TextEditingController(
                                    text: item.fat.toString(),
                                  ),
                                  isEdit: true,
                                  backgrund: true,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWithBorder("Protein: "),
                                AppTextField(
                                  controller: TextEditingController(
                                    text: item.protein.toString(),
                                  ),
                                  isEdit: true,
                                  backgrund: true,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWithBorder("Carbohydrates: "),
                                AppTextField(
                                  controller: TextEditingController(
                                    text: item.carbohydrates.toString(),
                                  ),
                                  isEdit: true,
                                  backgrund: true,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWithBorder(item.description),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
