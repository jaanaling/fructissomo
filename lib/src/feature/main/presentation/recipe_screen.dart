import 'dart:ui';

import 'package:fructissimo/src/core/utils/animated_button.dart';
import 'package:fructissimo/src/core/utils/app_icon.dart';
import 'package:fructissimo/src/core/utils/cupertino_snack_bar.dart';
import 'package:fructissimo/src/core/utils/icon_provider.dart';
import 'package:fructissimo/src/core/utils/size_utils.dart';
import 'package:fructissimo/src/core/utils/text_with_border.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/src/feature/main/presentation/main_screen.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:fructissimo/ui_kit/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class RecipeScreen extends StatefulWidget {
  final int id;

  const RecipeScreen({super.key, required this.id});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final GlobalKey shareButtonKey = GlobalKey();
  final GlobalKey shareButtonKey2 = GlobalKey();
  int currentStep = 0;

  void _goToNextStep(UserLoaded state) {
    final recipe =
        state.recipe.firstWhere((element) => element.id == widget.id);
    final item = recipe;
    bool isFavorite = state.dog.favoriteRecipes.contains(item.id);
    

    if (currentStep < recipe.steps.length - 1) {
      setState(() {
        currentStep++;
      });
    } else {
      showAdaptiveDialog(
        context: context,
        builder: (_) => StatefulBuilder(
          builder: (context, setState) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 2,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: 314,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(IconProvider.dialog.buildImageUrl()),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 15,
                      children: [
                        AnimatedButton(
                          onPressed: () {
                            context
                                .read<UserBloc>()
                                .add(UserToggleFavoriteData(id: item.id));
                                isFavorite = !isFavorite;
                            setState(() {});
                          },
                          child: AppIcon(
                            asset: isFavorite
                                ? IconProvider.favorites.buildImageUrl()
                                : IconProvider.unfavorite.buildImageUrl(),
                            width: 45,
                            height: 45,
                          ),
                        ),
                        AnimatedButton(
                          key: shareButtonKey2,
                          onPressed: () {
                            _shareRecipe(shareButtonKey2, item.name);
                          },
                          child: AppIcon(
                            asset: IconProvider.share.buildImageUrl(),
                            width: 45,
                            height: 45,
                          ),
                        ),
                        Gap(8)
                      ],
                    ),
                    const TextWithBorder(
                      'Woof-Woof! It`s so tasty!',
                      fontSize: 23,
                      textAlign: TextAlign.center,
                    ),
                    AppIcon(
                      asset: IconProvider.masq.buildImageUrl(),
                      height: 200,
                    ),
                    AppButton(
                      onPressed: () => context
                        ..pop()
                        ..pop(),
                      style: ButtonColors.yellow,
                      text: "back",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void _shareRecipe(GlobalKey shareButtonKey, String text) {
    Share.share(
      '🐶 Whipping up a tasty treat for my pup! Homemade, healthy, and full of love! ❤️🍖 Give it a try in "Doggie Chef"! 👇: ${text}',
      subject: 'Give it a try! 👇',
      sharePositionOrigin: shareButtonRect(shareButtonKey),
    );
  }

  Rect? shareButtonRect(GlobalKey shareButtonKey) {
    RenderBox? renderBox =
        shareButtonKey.currentContext!.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    Size size = renderBox.size;
    Offset position = renderBox.localToGlobal(Offset.zero);

    return Rect.fromCenter(
      center: position + Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }

        final item =
            state.recipe.where((element) => element.id == widget.id).first;

        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 22.0,
            sigmaY: 22.0,
          ),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: getWidth(context, percent: 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 17,
                      ),
                      child: Row(
                        children: [
                          AnimatedButton(
                            onPressed: () => context.pop(),
                            child: AppIcon(
                              asset: IconProvider.back.buildImageUrl(),
                              width: 66,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: getWidth(context, percent: 1) - 215,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: TextWithBorder(
                                isIpad(context)
                                    ? item.name
                                    : insertLineBreaks(item.name),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              AnimatedButton(
                                onPressed: () {
                                  context
                                      .read<UserBloc>()
                                      .add(UserToggleFavoriteData(id: item.id));
                                },
                                child: AppIcon(
                                  asset: state.dog.favoriteRecipes
                                          .contains(item.id)
                                      ? IconProvider.favorites.buildImageUrl()
                                      : IconProvider.unfavorite.buildImageUrl(),
                                  width: 37,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Gap(10),
                              AppButton(

                                style: ButtonColors.green,
                                isRound: true,
                                width: 63,
                                height: 63,
                                onPressed: () {
                                  _shareRecipe(shareButtonKey, item.name);
                                },
                                key: shareButtonKey,
                                text: '',
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: AppIcon(
                                    asset: IconProvider.share.buildImageUrl(),
                                    width: 32,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(15),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getWidth(context, baseSize: 36),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.28),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: getWidth(context, baseSize: 170),
                                  child: TextWithBorder("Calories: "),
                                ),
                                Spacer(),
                                AppTextField(
                                  verticalPadding: 10,
                                  width: getWidth(context, baseSize: 91),
                                  backgrund: true,
                                  controller: TextEditingController(
                                    text: item.calories.toString(),
                                  ),
                                  isEdit: true,
                                ),
                              ],
                            ),
                            Gap(4),
                            Row(
                              children: [
                                SizedBox(
                                  width: getWidth(context, baseSize: 170),
                                  child: TextWithBorder("Fat: "),
                                ),
                                Spacer(),
                                AppTextField(
                                  verticalPadding: 10,
                                  width: getWidth(context, baseSize: 91),
                                  backgrund: true,
                                  controller: TextEditingController(
                                    text: item.fat.toString(),
                                  ),
                                  isEdit: true,
                                ),
                              ],
                            ),
                            Gap(4),
                            Row(
                              children: [
                                SizedBox(
                                  width: getWidth(context, baseSize: 170),
                                  child: TextWithBorder("Protein: "),
                                ),
                                Spacer(),
                                AppTextField(
                                  verticalPadding: 10,
                                  width: getWidth(context, baseSize: 91),
                                  backgrund: true,
                                  controller: TextEditingController(
                                    text: item.protein.toString(),
                                  ),
                                  isEdit: true,
                                ),
                              ],
                            ),
                            Gap(4),
                            Row(
                              children: [
                                SizedBox(
                                  width: getWidth(context, baseSize: 170),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: TextWithBorder("Carbohydrates: "),
                                  ),
                                ),
                                Spacer(),
                                AppTextField(
                                  verticalPadding: 10,
                                  width: getWidth(context, baseSize: 91),
                                  backgrund: true,
                                  controller: TextEditingController(
                                    text: item.carbohydrates.toString(),
                                  ),
                                  isEdit: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.28),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: TextWithBorder(
                          item.description,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Gap(15),
                  SizedBox(
                    height: 212,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: item.ingredients.length,
                      separatorBuilder: (_, __) => Gap(8),
                      itemBuilder: (context, index) => DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.28),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 85,
                                height: 73,
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: TextWithBorder(
                                      item.ingredients[index].name
                                          .replaceAll(' ', '\n'),
                                    ),
                                  ),
                                ),
                              ),
                              Gap(15),
                              AppTextField(
                                width: 85,
                                backgrund: true,
                                controller: TextEditingController(
                                  text: item.ingredients[index].quantity
                                      .toString(),
                                ),
                                isEdit: true,
                              ),
                              Gap(15),
                              AppButton(
                                style: ButtonColors.green,
                                isRound: true,
                                onPressed: () {
                                  showCupertinoSnackBar(context, "+${item.ingredients[index].name} in shop list!");
                                  context.read<UserBloc>().add(
                                        UserSaveShoppingData(
                                          ingredient: item.ingredients[index],
                                        ),
                                      );
                                },
                                text: "",
                                child: AppIcon(
                                  asset: IconProvider.shop.buildImageUrl(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextWithBorder("Steps:"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage(IconProvider.button.buildImageUrl()),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            TextWithBorder(
                              "Step ${currentStep + 1} of ${item.steps.length}",
                            ),
                            TextWithBorder(item.steps[currentStep].description),
                            AppButton(
                              onPressed: () => _goToNextStep(state),
                              style: ButtonColors.green,
                              text: "Next",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(25),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
