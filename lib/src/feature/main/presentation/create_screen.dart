import 'dart:ui';

import 'package:fructissimo/src/core/utils/animated_button.dart';
import 'package:fructissimo/src/core/utils/app_icon.dart';
import 'package:fructissimo/src/core/utils/icon_provider.dart';
import 'package:fructissimo/src/core/utils/size_utils.dart';
import 'package:fructissimo/src/core/utils/text_with_border.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/src/feature/main/model/dog.dart';
import 'package:fructissimo/ui_kit/app_app_bar.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:fructissimo/ui_kit/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final List<String> selectedAlergens = [];
  final ageTextField = TextEditingController();
  final weightTextField = TextEditingController();
  bool isLoad = false;

  String? image;
  final name = TextEditingController();

  int activity = 1;
  String? selectedBreed;
  String? error;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedFile?.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }

        final dog = state.dog;
        if (!isLoad) {
          name.text = dog.name;
          ageTextField.text = dog.age.toString();
          weightTextField.text = dog.weight.toString();
          selectedBreed = dog.breed;
          activity = dog.activity;
          selectedAlergens.addAll(dog.alergens);
          image = dog.image;
          isLoad = true;
        }

        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 22.0,
            sigmaY: 22.0,
          ),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                spacing: 10,
                children: [
                  AppAppBar(title: "Profile"),
                  AnimatedButton(
                    onPressed: () => pickImage(),
                    
                    child: AppIcon(
                      width: 300,
                      height: 300,
                      asset: image ?? IconProvider.addphoto.buildImageUrl(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CountTextField(
                        width: 165,
                        controller: ageTextField,
                        title: "age",
                        setState: () => setState(() {}),
                      ),
                      CountTextField(
                        isDouble: true,
                        width: 165,
                        controller: weightTextField,
                        title: "weight",
                        setState: () => setState(() {}),
                      ),
                    ],
                  ),
                  AppTextField(
                    width: getWidth(context, baseSize: 284),
                    backgrund: true,
                    controller: name,
                    title: "name",
                  ),
                  AppButton(
                    width: getWidth(context, baseSize: 284),
                    height: getHeight(context, baseSize: 81),
                    style: ButtonColors.yellow,
                    text: selectedBreed ?? "breed",
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SafeArea(
                            top: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 250,
                                  child: CupertinoPicker(
                                    itemExtent: 50,
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        selectedBreed = dogBreeds[index];
                                      });
                                    },
                                    children: List.generate(
                                      dogBreeds.length,
                                      (index) => TextWithBorder(
                                        dogBreeds[index],
                                      ),
                                    ),
                                  ),
                                ),
                                AppButton(
                                  style: ButtonColors.green,
                                  onPressed: () => context.pop(),
                                  text: "OK",
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      color: Colors.black.withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(13),
                      child: Column(
                        children: [
                          Text(
                            "activity",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Font',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Slider(
                            value: activity.toDouble(),
                            thumbColor: const Color(0xFFBDDE00),
                            activeColor: const Color(0xFFBDDE00),
                            inactiveColor: Colors.white,
                            min: 1,
                            max: 5,
                            divisions: 4,
                            onChanged: (value) => setState(() {
                              activity = value.toInt();
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (error != null) TextWithBorder(error!),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: List.generate(
                      commonDogAllergens.length,
                      (int index) => AppButton(
                        width: 130,
                        fontSize: 18,
                        style:
                            selectedAlergens.contains(commonDogAllergens[index])
                                ? ButtonColors.yellow
                                : ButtonColors.purple,
                        onPressed: () {
                          setState(() {
                            if (selectedAlergens
                                .contains(commonDogAllergens[index])) {
                              selectedAlergens.remove(commonDogAllergens[index]);
                            } else {
                              selectedAlergens.add(commonDogAllergens[index]);
                            }
                          });
                        },
                        text: commonDogAllergens[index],
                      ),
                    ),
                  ),
                  AppButton(
                    width: getWidth(context, baseSize: 284),
                    height: 81,
                    onPressed: () {
                      if (name.text.isEmpty ||
                          selectedBreed == null ||
                          weightTextField.text.isEmpty ||
                          ageTextField.text.isEmpty) {
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
                              UserUpdateData(
                                name: name.text,
                                breed: selectedBreed,
                                age: int.parse(ageTextField.text),
                                weight: double.parse(weightTextField.text),
                                gender: dog.gender,
                                activity: activity,
                                alergens: selectedAlergens,
                                image: image,
                              ),
                            );
                           
                        context.pop();
                      }
                    },
                    style: ButtonColors.green,
                    text: "save",
                  ),
                  Gap(30)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
