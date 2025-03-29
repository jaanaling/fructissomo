import 'package:fructissimo/routes/route_value.dart';
import 'package:fructissimo/src/core/utils/animated_button.dart';
import 'package:fructissimo/src/core/utils/app_icon.dart';
import 'package:fructissimo/src/core/utils/icon_provider.dart';
import 'package:fructissimo/src/core/utils/size_utils.dart';
import 'package:fructissimo/src/core/utils/text_with_border.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:fructissimo/ui_kit/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController controller = TextEditingController();
  bool isRecomended = false;
  bool isFavorite = false;
  String selectedCategory = '';
  List<String> categories = [
    'Puppy',
    'Adult',
    'Senior',
    'Grain-Free',
    'Weight\nManagement',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const SizedBox();
        }
        final recipes = state.recipe;
        final recomendedRecipes = state.dog.recomendationRecipes;
        final favorites = state.dog.favoriteRecipes;

        final filtredRecipes = recipes.where((recipe) {
          final name = recipe.name.toLowerCase();
          final query = controller.text.toLowerCase();
          final category = recipe.category;
          final isNameMatch = name.contains(query);
          final isCategoryMatch =
              selectedCategory.isEmpty || category == selectedCategory;
          final isRecomendedMatch =
              !isRecomended || recomendedRecipes.contains(recipe.id);
          final isFavoriteMatch = !isFavorite || favorites.contains(recipe.id);
          return isNameMatch &&
              isCategoryMatch &&
              isRecomendedMatch &&
              isFavoriteMatch;
        }).toList();

        return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    spacing: 10,
                    children: [
                      AnimatedButton(
                        onPressed: () {
                          context.push(
                            '${RouteValue.home.path}/${RouteValue.create.path}',
                          );
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2
                            ),
                            borderRadius: BorderRadius.circular(73),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0x30000000),
                                  offset: Offset(0, 3))
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: ClipOval(
                              child: AppIcon(
                                asset: state.dog.image ??
                                    IconProvider.addphoto.buildImageUrl(),
                                width: 73,
                                height: 73,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      AppButton(
                        isRound: true,
                        style: ButtonColors.yellow,
                        text: '',
                        child: AppIcon(asset: IconProvider.box.buildImageUrl()),
                        onPressed: () {
                          context.push(
                            '${RouteValue.home.path}/${RouteValue.storage.path}',
                          );
                        },
                      ),
                      AppButton(
                        isRound: true,
                        style: ButtonColors.green,
                        text: '',
                        child:
                            AppIcon(asset: IconProvider.help.buildImageUrl()),
                        onPressed: () {
                          context.push(
                            '${RouteValue.home.path}/${RouteValue.recommendation.path}',
                          );
                        },
                      ),
                      AppButton(
                        isRound: true,
                        style: ButtonColors.yellow,
                        text: '',
                        child: AppIcon(
                            asset: IconProvider.database.buildImageUrl()),
                        onPressed: () {
                          context.push(
                            '${RouteValue.home.path}/${RouteValue.base.path}',
                          );
                        },
                      ),
                      AppButton(
                        isRound: true,
                        style: ButtonColors.green,
                        text: '',
                        child:
                            AppIcon(asset: IconProvider.shop.buildImageUrl()),
                        onPressed: () {
                          context.push(
                            '${RouteValue.home.path}/${RouteValue.shop.path}',
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          AppIcon(
                            asset: IconProvider.search.buildImageUrl(),
                            height: getHeight(context, baseSize: 75),
                            width: getWidth(context, baseSize: 220),
                          ),
                          AppTextField(
                            keyboardType: TextInputType.text,
                            controller: controller,
                            width: getWidth(context, baseSize: 150),
                            maxLines: 1,
                          ),
                        ],
                      ),
                      Gap(10),
                      AppButton(
                        isRound: true,
                        style: isRecomended
                            ? ButtonColors.green
                            : ButtonColors.yellow,
                        text: '',
                        child: AppIcon(
                          asset: IconProvider.recommended.buildImageUrl(),
                        ),
                        onPressed: () {
                          setState(() {
                            state.dog.updateRecommendations(state.recipe);
                            isRecomended = !isRecomended;
                          });
                        },
                      ),
                      Gap(10),
                      AnimatedButton(
                        child: AppIcon(
                          width: 48,
                          asset: isFavorite
                              ? IconProvider.favorites.buildImageUrl()
                              : IconProvider.unfavorite.buildImageUrl(),
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context, baseSize: 43),
                  child: ListView.separated(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Gap(0),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: AppButton(
                          verticalPadding: 0,
                          fontSize: 20,
                          style: selectedCategory == category
                              ? ButtonColors.yellow
                              : ButtonColors.purple,
                          onPressed: () {
                            setState(() {
                              selectedCategory =
                                  selectedCategory == category ? '' : category;
                            });
                          },
                          text: category,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: SizedBox(
                              width: 100,
                              height: 33,
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: TextWithBorder(
                                    category,
                                    fontSize: 23,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Gap(11),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filtredRecipes.length,
                    separatorBuilder: (context, index) => const Gap(16),
                    itemBuilder: (context, index) {
                      final recipe = filtredRecipes[index];
                      final isFavoriteRes =
                          state.dog.favoriteRecipes.contains(recipe.id);
                      return AnimatedButton(
                        onPressed: () {
                          context.push(
                            '${RouteValue.home.path}/${RouteValue.recipe.path}',
                            extra: recipe.id,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  IconProvider.button.buildImageUrl()),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 9,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppIcon(
                                  asset: recipe.image,
                                  width: 113,
                                ),
                                SizedBox(
                                  width: getWidth(context, baseSize: 130),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWithBorder(isIpad(context)
                                            ? recipe.name
                                            : insertLineBreaks(recipe.name)),
                                        Text(
                                          'Calories: ${recipe.calories}',
                                          style: const TextStyle(
                                            color: Color(0xFF894406),
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Carbohydrates: ${recipe.carbohydrates}',
                                          style: const TextStyle(
                                            color: Color(0xFF894406),
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Fat: ${recipe.fat}',
                                          style: const TextStyle(
                                            color: Color(0xFF894406),
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Protein: ${recipe.protein}',
                                          style: const TextStyle(
                                            color: Color(0xFF894406),
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                AnimatedButton(
                                  onPressed: () {
                                    setState(() {
                                  

                                      context.read<UserBloc>().add(
                                            UserToggleFavoriteData(
                                              id: recipe.id,
                                            ),
                                          );
                                    });
                                  },
                                  child: AppIcon(
                                    asset: isFavoriteRes
                                        ? IconProvider.favorites.buildImageUrl()
                                        : IconProvider.unfavorite
                                            .buildImageUrl(),
                                    width: 37,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Gap(15)
              ],
            ),
          ),
        );
      },
    );
  }
}

String insertLineBreaks(String text, {int maxLineLength = 10}) {
  List<String> words = text.split(' ');
  StringBuffer result = StringBuffer();
  int currentLineLength = 0;

  for (int i = 0; i < words.length; i++) {
    String word = words[i];

    if (currentLineLength + word.length > maxLineLength) {
      result.write('\n');
      currentLineLength = 0;
    } else if (i != 0) {
      result.write(' ');
      currentLineLength += 1;
    }

    result.write(word);
    currentLineLength += word.length;
  }

  return result.toString().trim();
}
