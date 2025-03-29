import 'dart:ui';

import 'package:fructissimo/src/core/utils/animated_button.dart';
import 'package:fructissimo/src/core/utils/app_icon.dart';
import 'package:fructissimo/src/core/utils/icon_provider.dart';
import 'package:fructissimo/src/core/utils/text_with_border.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/src/feature/main/model/ingredient.dart';
import 'package:fructissimo/ui_kit/app_app_bar.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:fructissimo/ui_kit/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }
        final items = state.dog.shoppingList;
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 22.0,
            sigmaY: 22.0,
          ),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  AppAppBar(title: "Shopping list"),
                  AppButton(
                    onPressed: () {
                      final name = TextEditingController();
                      final count = TextEditingController();
                      String? error;
                      showAdaptiveDialog(
                        context: context,
                        builder: (_) => StatefulBuilder(
                          builder: (context, setState) => Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 24,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                width: 314,
                                height: 300,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(IconProvider.dialog
                                            .buildImageUrl()),
                                        fit: BoxFit.fill)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: AnimatedButton(
                                            onPressed: () => context.pop(),
                                            child: AppIcon(
                                                asset: IconProvider.cross
                                                    .buildImageUrl()),
                                          )),
                                      AppTextField(
                                        width: 220,
                                        controller: name,
                                        title: "Name",

                                          keyboardType: TextInputType.text,
                                        backgrund: true,
                                      ),
                                      AppTextField(
                                        width: 220,
                                        controller: count,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        title: "Count",
                                        backgrund: true,
                                      ),
                                      TextWithBorder(error ?? ""),
                                      AppButton(
                                        onPressed: () {
                                          if (name.text.isEmpty ||
                                              count.text.isEmpty) {
                                            setState(() {
                                              error = "Fill in all fields";
                                            });
                                          } else {
                                            setState(() {
                                              error = null;
                                            });
                                          }
                                          if (error == null) {
                                            context.read<UserBloc>().add(
                                                  UserSaveShoppingData(
                                                    ingredient: Ingredient(
                                                      id: DateTime.now()
                                                          .millisecondsSinceEpoch,
                                                      name: name.text,
                                                      quantity: double.parse(
                                                          count.text),
                                                    ),
                                                  ),
                                                );
                                          }
                                          name.clear();
                                          count.clear();

                                          context.pop();
                                        },
                                        style: ButtonColors.yellow,
                                        text: "add",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    style: ButtonColors.green,
                    text: "add",
                  ),
                  const Gap(10),
                  if (items.isEmpty)
                    const Center(
                        child: TextWithBorder("No items in the shopping list"))
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => Gap(8),
                      itemBuilder: (context, index) {
                        final controller = TextEditingController(
                          text: items[index].ingredient.quantity.toString(),
                        );

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.28),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: TextWithBorder(items[index].ingredient.name)),
                                Row(
                                  spacing: 10,
                                  children: [
                                    AppTextField(
                                      backgrund: true,
                                      controller: controller,
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      onChanged: (value) {
                                        context.read<UserBloc>().add(
                                              UserUpdateShoppingData(
                                                id: items[index].id,
                                                shopping: items[index]
                                                    .ingredient
                                                    .copyWith(
                                                      quantity:
                                                          double.parse(value),
                                                    ),
                                              ),
                                            );
                                      },
                                    ),
                                    AppButton(
                                      width: 50,
                                      height: 50,
                                      style: ButtonColors.green,
                                      isRound: true,
                                      onPressed: () {
                                        context.read<UserBloc>().add(
                                              UserSaveStorageData(
                                                ingredient:
                                                    items[index].ingredient,
                                              ),
                                            );
                                      },
                                      text: "",
                                      child: AppIcon(
                                        asset:
                                            IconProvider.shop.buildImageUrl(),
                                      ),
                                    ),
                                    AnimatedButton(
                                      onPressed: () =>
                                          context.read<UserBloc>().add(
                                                UserDeleteShoppingData(
                                                    id: items[index].id),
                                              ),
                                      child: AppIcon(
                                        width: 50,
                                        height: 50,
                                        asset:
                                            IconProvider.delete.buildImageUrl(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
