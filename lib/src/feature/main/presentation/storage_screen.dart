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

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }
        final items = state.dog.storage;

        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 22.0,
            sigmaY: 22.0,
          ),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const AppAppBar(title: "Storage"),
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
                                    image: AssetImage(
                                      IconProvider.dialog.buildImageUrl(),
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
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
                                                .buildImageUrl(),
                                          ),
                                        ),
                                      ),
                                      AppTextField(
                                        width: 220,
                                        controller: name,
                                        keyboardType: TextInputType.text,
                                        title: "Name",
                                        backgrund: true,
                                      ),
                                      AppTextField(
                                        width: 220,
                                        controller: count,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(
                                          decimal: true,
                                        ),
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
                                                  UserSaveStorageData(
                                                    ingredient: Ingredient(
                                                      id: DateTime.now()
                                                          .millisecondsSinceEpoch,
                                                      name: name.text,
                                                      quantity: double.parse(
                                                        count.text,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                            context.pop();
                                          }
                                        },
                                        style: ButtonColors.green,
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
                  const Gap(16),
                  if (items.isEmpty)
                    const Center(
                      child: TextWithBorder("No items in the storage"),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Gap(8),
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
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                      controller: controller,
                                      onChanged: (value) {
                                        context.read<UserBloc>().add(
                                              UserUpdateStorageData(
                                                id: items[index].id,
                                                storage: items[index]
                                                    .ingredient
                                                    .copyWith(
                                                      quantity:
                                                          double.parse(value),
                                                    ),
                                              ),
                                            );
                                      },
                                    ),
                                    AnimatedButton(
                                      onPressed: () =>
                                          context.read<UserBloc>().add(
                                                UserDeleteStorageData(
                                                  id: items[index].id,
                                                ),
                                              ),
                                      child: AppIcon(
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
