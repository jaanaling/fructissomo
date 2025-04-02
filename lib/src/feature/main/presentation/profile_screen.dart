import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fructissimo/routes/route_value.dart';
import 'package:fructissimo/src/core/utils/animated_button.dart';
import 'package:fructissimo/src/core/utils/app_icon.dart';
import 'package:fructissimo/src/core/utils/cupertino_snack_bar.dart';
import 'package:fructissimo/src/core/utils/size_utils.dart';
import 'package:fructissimo/src/core/utils/text_with_border.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/src/feature/main/model/tree.dart';
import 'package:fructissimo/ui_kit/app_app_bar.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:fructissimo/src/feature/main/model/fertilizer.dart';
import 'package:fructissimo/src/feature/main/model/fertilizer_recommendation.dart';
import 'package:fructissimo/src/feature/main/model/pest.dart';
import 'package:fructissimo/src/feature/main/model/tree.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:fructissimo/ui_kit/app_text_field.dart';
import 'package:fructissimo/ui_kit/back_container.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/icon_provider.dart';

int _currentIndex = 0;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Center(
            child: CupertinoActivityIndicator(
              color: Colors.white,
            ),
          );
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                          onPressed: () {
                            context.push('/home/${RouteValue.diary.path}');
                          },
                          style: ButtonColors.purple,
                          text: '',
                          padding: EdgeInsets.zero,
                          child: SizedBox(
                            width: 60,
                            height: 60,
                            child: Center(
                              child: AppIcon(
                                asset: IconProvider.diary.buildImageUrl(),
                              ),
                            ),
                          ),
                        ),
                        const Gap(25),
                        AppButton(
                          onPressed: () {
                            if (state.trees.length > _currentIndex) {
                              context.push(
                                '/home/${RouteValue.statistic.path}',
                                extra: state.trees[_currentIndex].id,
                              );
                            } else {
                              showCupertinoSnackBar(
                                context,
                                'You need to add tree',
                              );
                            }
                          },
                          style: ButtonColors.purple,
                          text: '',
                          padding: EdgeInsets.zero,
                          child: SizedBox(
                            width: 60,
                            height: 60,
                            child: Center(
                              child: AppIcon(
                                asset: IconProvider.stat.buildImageUrl(),
                              ),
                            ),
                          ),
                        ),
                        const Gap(25),
                        AppButton(
                          onPressed: () {
                            if (state.trees.length > _currentIndex) {
                              addPersentPopup(
                                  context, state.trees[_currentIndex]);
                            } else {
                              showCupertinoSnackBar(
                                context,
                                'You need to add tree',
                              );
                            }
                          },
                          style: ButtonColors.purple,
                          text: '',
                          padding: EdgeInsets.zero,
                          child: SizedBox(
                            width: 60,
                            height: 60,
                            child: Center(
                              child: AppIcon(
                                asset: IconProvider.calc.buildImageUrl(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CarouselWithInfo(
                      items: state.trees,
                      settState: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
                if (state.trees.length > _currentIndex)
                Positioned(
                  right: 7,
                  top: 70,
                  child: Visibility(
                    visible: state.trees.length > _currentIndex,
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(186, 247, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Column(
                          children: [
                            AnimatedButton(
                              onPressed: () => saveWatteringInfo(
                                context,
                                state.trees[_currentIndex],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
                                children: [
                                  AppIcon(
                                    asset:
                                        IconProvider.waterSvg.buildImageUrl(),
                               
                                    width: 35,
                                  ),
                                  const Gap(5),
                                  AppButton(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 11.34, horizontal: 11.34),
                                    style: ButtonColors.purple,
                                    text: '',
                                    child:
                                        state.trees[_currentIndex].isCheckWater
                                            ? AppIcon(
                                                asset: IconProvider.mark
                                                    .buildImageUrl(),
                                              )
                                            : AppIcon(
                                                asset: IconProvider.mark
                                                    .buildImageUrl(),
                                                color: Colors.transparent,
                                              ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            AnimatedButton(
                              onPressed: () => saveFertilizeInfo(
                                context,
                                state.trees[_currentIndex],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
                                children: [
                                  AppIcon(
                                    asset: IconProvider.freq.buildImageUrl(),
                               
                                    width: 35,
                                  ),
                                  const Gap(5),
                                  AppButton(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 11.34, horizontal: 11.34),
                                    style: ButtonColors.purple,
                                    text: '',
                                    child: state.trees[_currentIndex]
                                            .isCheckFertilize
                                        ? AppIcon(
                                            asset: IconProvider.mark
                                                .buildImageUrl(),
                                          )
                                        : AppIcon(
                                            asset: IconProvider.mark
                                                .buildImageUrl(),
                                            color: Colors.transparent,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            AnimatedButton(
                              onPressed: () => saveProtectInfo(
                                context,
                                state.trees[_currentIndex],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
                                children: [
                                  AppIcon(
                                    asset: IconProvider.protect.buildImageUrl(),
                                 
                                    width: 35,
                                  ),
                                  const Gap(5),
                                  AppButton(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 11.34, horizontal: 11.34),
                                    style: ButtonColors.purple,
                                    text: '',
                                    child: state
                                            .trees[_currentIndex].isCheckProtect
                                        ? AppIcon(
                                            asset: IconProvider.mark
                                                .buildImageUrl(),
                                          )
                                        : AppIcon(
                                            asset: IconProvider.mark
                                                .buildImageUrl(),
                                            color: Colors.transparent,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            AnimatedButton(
                              onPressed: () => saveProductivityInfo(
                                context,
                                state.trees[_currentIndex],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
                                children: [
                                  AppIcon(
                                    asset: IconProvider.prod.buildImageUrl(),
                              
                                    width: 35,
                                  ),
                                  const Gap(5),
                                  AppButton(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 11.34, horizontal: 11.34),
                                    style: ButtonColors.purple,
                                    text: '',
                                    child: state.trees[_currentIndex]
                                            .isCheckProductivity
                                        ? AppIcon(
                                            asset: IconProvider.mark
                                                .buildImageUrl(),
                                          )
                                        : AppIcon(
                                            asset: IconProvider.mark
                                                .buildImageUrl(),
                                            color: Colors.transparent,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            AnimatedButton(
                              onPressed: () => saveTemperatureInfo(
                                context,
                                state.trees[_currentIndex],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AppIcon(
                                    asset: IconProvider.temp.buildImageUrl(),
                          
                                    width: 25,
                                  ),
                                  const Gap(5),
                                  AppButton(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 11.34, horizontal: 11.34),
                                    style: ButtonColors.purple,
                                    text: '',
                                    child: state.trees[_currentIndex]
                                            .isCheckTemperature
                                        ? AppIcon(
                                            asset: IconProvider.mark
                                                .buildImageUrl(),
                                          )
                                        : AppIcon(
                                            asset: IconProvider.mark
                                                .buildImageUrl(),
                                            color: Colors.transparent,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void saveWatteringInfo(BuildContext context, TreeProfile tree) {
    double values = tree.moisture;
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).removeViewInsets(removeBottom: true),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, StateSetter setState) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 350,
                  child: BackContainer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Soil moisture',
                            style: TextStyle(fontSize: 35, fontFamily: 'Font'),  textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            values.toInt().toString(),
                            style: const TextStyle(
                              fontSize: 65,
                              fontFamily: 'Font',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Slider(
                            value: values,
                            max: 100,
                            onChanged: (id) => setState(
                              () {
                                values = id;
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 12,
                            children: [
                              AppButton(
                                text: 'Cancel',
                                style: ButtonColors.red,
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                              AppButton(
                                text: 'Save',
                                style: ButtonColors.green,
                                onPressed: () {
                                  tree.wateringRecords.add(
                                    WateringRecord(
                                      date: DateTime.now(),
                                      amount: values.toInt().toDouble(),
                                    ),
                                  );
                                  tree.moisture = values.toInt().toDouble();
                                  tree.isCheckWater = true;
                                  context
                                      .read<UserBloc>()
                                      .add(UserUpdateTree(tree));
                                  context.pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void saveFertilizeInfo(BuildContext context, TreeProfile tree) {
    final TextEditingController values = TextEditingController();
    String fertilization = tree.fertilizer.fertilizer;
    String error = '';
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).removeViewInsets(removeBottom: true),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, StateSetter setState) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 350,
                  child: BackContainer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            const Text(
                            'Fertilizer (pounds)',
                            style: TextStyle(fontSize: 35, fontFamily: 'Font'),  textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          AppButton(
                            text: fertilization,
                            style: ButtonColors.green,
                            onPressed: () {
                              addStatusPopup(
                                context,
                                fertilizers.map((e) => e.fertilizer).toList(),
                                (id) {
                                  setState(() {
                                    fertilization = fertilizers
                                        .map((e) => e.fertilizer)
                                        .toList()[id];
                                  });
                                },
                              );
                            },
                          ),
                          AppTextField(controller: values),
                          if (error.isNotEmpty)
                            Text(
                              error,
                              style: const TextStyle(color: Colors.red),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 12,
                            children: [
                              AppButton(
                                text: 'Cancel',
                                style: ButtonColors.red,
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                              AppButton(
                                text: 'Save',
                                style: ButtonColors.green,
                                onPressed: () {
                                  if (values.text.isEmpty ||
                                      fertilization.isEmpty) {
                                    setState(() {
                                      error = 'Need fill all fields';
                                    });
                                    return;
                                  }
                                  tree.fertilizationRecords.add(
                                    FertilizationRecord(
                                      date: DateTime.now(),
                                      amount: double.parse(values.text),
                                      fertilizerName: fertilization,
                                    ),
                                  );
                                  tree.isCheckFertilize = true;
                                  context
                                      .read<UserBloc>()
                                      .add(UserUpdateTree(tree));
                                  context.pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void saveProtectInfo(BuildContext context, TreeProfile tree) {
    String protection = tree.protection;
    String error = '';
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).removeViewInsets(removeBottom: true),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, StateSetter setState) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 350,
                  child: BackContainer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            const Text(
                            'Protection',
                            style: TextStyle(fontSize: 35, fontFamily: 'Font'),  textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          AppButton(
                            text: protection,
                            style: ButtonColors.green,
                            onPressed: () {
                              addStatusPopup(
                                context,
                                protections,
                                (id) {
                                  setState(() {
                                    protection = protections[id];
                                  });
                                },
                              );
                            },
                          ),
                          if (error.isNotEmpty)
                            Text(
                              error,
                              style: const TextStyle(color: Colors.red),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 12,
                            children: [
                              AppButton(
                                text: 'Cancel',
                                style: ButtonColors.red,
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                              AppButton(
                                text: 'Save',
                                style: ButtonColors.green,
                                onPressed: () {
                                  if (protection.isEmpty) {
                                    setState(() {
                                      error = 'Need fill all fields';
                                    });
                                    return;
                                  }
                                  tree.protectionRecords.add(
                                    ProtectionRecord(
                                      date: DateTime.now(),
                                      protectionName: protection,
                                    ),
                                  );
                                  tree.isCheckProtect = true;
                                  context
                                      .read<UserBloc>()
                                      .add(UserUpdateTree(tree));
                                  context.pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void addStatusPopup(BuildContext context, List list, Function(int) submit) {
    int selectedItem = 0;
    void onSelectedItemChanged(int index) {
      selectedItem = index;
    }

    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).removeViewInsets(removeBottom: true),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, StateSetter setState) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 1,
                  ),
                  SizedBox(
                    height: 350,
                    child: BackContainer(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 250,
                              child: CupertinoPicker.builder(
                                childCount: list.length,
                                backgroundColor: Colors.transparent,
                                scrollController: FixedExtentScrollController(
                                  initialItem: selectedItem,
                                ),
                                itemExtent: 45,
                                onSelectedItemChanged: onSelectedItemChanged,
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: Text(
                                      list[index] as String,
                                      style: const TextStyle(
                                        color: Color(0xFF280035),
                                        fontSize: 32,
                                        fontFamily: 'Font',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 12,
                              children: [
                                AppButton(
                                  text: 'Cancel',
                                  style: ButtonColors.red,
                                  onPressed: () {
                                    context.pop();
                                  },
                                ),
                                AppButton(
                                  text: 'Save',
                                  style: ButtonColors.green,
                                  onPressed: () {
                                    submit(selectedItem);
                                    context.pop();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void saveTemperatureInfo(BuildContext context, TreeProfile tree) {
    final TextEditingController values =
        TextEditingController(text: tree.temperature.toString());
    String error = '';
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).removeViewInsets(removeBottom: true),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, StateSetter setState) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 350,
                  child: BackContainer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            const Text(
                            'Temperature (Farenheit)',
                            style: TextStyle(fontSize: 35, fontFamily: 'Font'),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          AppTextField(controller: values),
                          if (error.isNotEmpty)
                            Text(
                              error,
                              style: const TextStyle(color: Colors.red),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 12,
                            children: [
                              AppButton(
                                text: 'Cancel',
                                style: ButtonColors.red,
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                              AppButton(
                                text: 'Save',
                                style: ButtonColors.green,
                                onPressed: () {
                                  if (values.text.isEmpty) {
                                    setState(() {
                                      error = 'Need fill all fields';
                                    });
                                    return;
                                  }
                                  tree.temperatureRecords.add(
                                    TemperatureRecord(
                                      date: DateTime.now(),
                                      temperature: double.parse(values.text),
                                    ),
                                  );
                                  tree.isCheckTemperature = true;
                                  context
                                      .read<UserBloc>()
                                      .add(UserUpdateTree(tree));
                                  context.pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void saveProductivityInfo(BuildContext context, TreeProfile tree) {
    final TextEditingController values =
        TextEditingController(text: tree.productivity.toString());

    String error = '';
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).removeViewInsets(removeBottom: true),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, StateSetter setState) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 250,
                  child: BackContainer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            const Text(
                            'Productivity (pound)',
                            style: TextStyle(fontSize: 35, fontFamily: 'Font'),
                          ),
                          const SizedBox(height: 10),
                          AppTextField(controller: values),
                          if (error.isNotEmpty)
                            Text(
                              error,
                              style: const TextStyle(color: Colors.red),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 12,
                            children: [
                              AppButton(
                                text: 'Cancel',
                                style: ButtonColors.red,
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                              AppButton(
                                text: 'Save',
                                style: ButtonColors.green,
                                onPressed: () {
                                  if (values.text.isEmpty) {
                                    setState(() {
                                      error = 'Need fill all fields';
                                    });
                                    return;
                                  }
                                  tree.harvestRecords.add(
                                    HarvestRecord(
                                      date: DateTime.now(),
                                      amount: double.parse(values.text),
                                    ),
                                  );
                                  tree.isCheckProductivity = true;
                                  tree.productivity = double.parse(values.text);
                                  context
                                      .read<UserBloc>()
                                      .add(UserUpdateTree(tree));
                                  context.pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void addPersentPopup(BuildContext context, TreeProfile tree) {
    String? purpose;
    String? vegetationType;
    String error = '';
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).removeViewInsets(removeBottom: true),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, StateSetter setState) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 350,
                  child: BackContainer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                      child: Column(
                        children: [
                          if (error.isNotEmpty)
                            Text(
                              error,
                              style: const TextStyle(color: Colors.red),
                            ),
                          const SizedBox(height: 10),
                          AppButton(
                            text: purpose ?? 'Purpose',
                            style: ButtonColors.green,
                            onPressed: () {
                              addStatusPopup(
                                context,
                                fertilizerUsesForTrees,
                                (id) {
                                  setState(() {
                                    purpose = fertilizerUsesForTrees[id];
                                  });
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          AppButton(
                            text: vegetationType ?? 'Vegetation type',
                            style: ButtonColors.green,
                            onPressed: () {
                              addStatusPopup(
                                context,
                                treeVegetationTypes,
                                (id) {
                                  setState(() {
                                    vegetationType = treeVegetationTypes[id];
                                  });
                                },
                              );
                            },
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 12,
                            children: [
                              AppButton(
                                text: 'Cancel',
                                style: ButtonColors.red,
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                              AppButton(
                                text: 'Calculate',
                                style: ButtonColors.green,
                                onPressed: () {
                                  if (purpose == null ||
                                      vegetationType == null) {
                                    setState(() {
                                      error = 'Need fill all fields';
                                    });
                                    return;
                                  }
                                  context.pop();
                                  addCalculatedPopup(
                                    context,
                                    tree,
                                    purpose!,
                                    vegetationType!,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void addCalculatedPopup(
    BuildContext context,
    TreeProfile tree,
    String purpose,
    String vegetationType,
  ) {
    final recomended = calculateFertilizer(tree, purpose, vegetationType);
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).removeViewInsets(removeBottom: true),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, StateSetter setState) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 450,
                  child: BackContainer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Gap(5),
                          Text(
                            'Fertilizer: ${recomended.fertilizerType}',
                            style: const TextStyle(
                              color: Color(0xFF280035),
                              fontSize: 32,
                              fontFamily: 'Font',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Amount: ${recomended.amountInPounds} lbs',
                            style: const TextStyle(
                              color: Color(0xFF280035),
                              fontSize: 32,
                              fontFamily: 'Font',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Indrouctions: ${recomended.applicationMethod} ',
                            style: const TextStyle(
                              color: Color(0xFF280035),
                              fontSize: 32,
                              fontFamily: 'Font',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Frequency: ${recomended.frequencyInDays} days',
                            style: const TextStyle(
                              color: Color(0xFF280035),
                              fontSize: 32,
                              fontFamily: 'Font',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          AppButton(
                            text: 'Close',
                            style: ButtonColors.green,
                            onPressed: () {
                              context.pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CarouselWithInfo extends StatefulWidget {
  final List<TreeProfile> items;
  final VoidCallback settState;

  const CarouselWithInfo({super.key, required this.items, required this.settState});

  @override
  _CarouselWithInfoState createState() => _CarouselWithInfoState();
}

class _CarouselWithInfoState extends State<CarouselWithInfo> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    // Создаем список элементов карусели, добавляя плюс в конец
    final carouselItems = [
      ...widget.items.map((item) => _buildItemWidget(item)),
      _buildPlusIconWidget(),
    ];

    final columnWidth = (getWidth(context, percent: 1) - 96) / 3;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 374,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider(
                items: carouselItems,
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 374,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                      widget.settState();
                    });
                  },
                ),
              ),
              Positioned(
                bottom: 15,
                left: 30,
                child: Visibility(
                  visible: carouselItems.length > 1 && _currentIndex > 0,
                  child: AnimatedButton(
                    onPressed: () => _carouselController.previousPage(),
                    child: Transform.rotate(
                      angle: 180 * 3.14 / 180,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Color(0xFF38D100),
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          width: 44,
                          height: 44,
                          child: Center(
                            child: AppIcon(
                              asset: IconProvider.arrow.buildImageUrl(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWithBorder(
                      _currentIndex < widget.items.length
                          ? widget.items[_currentIndex].type
                          : 'Create\nnew tree',
                      textAlign: TextAlign.center,
                    ),
                    if (_currentIndex < widget.items.length)
                      TextWithBorder(
                        widget.items[_currentIndex].subtype,
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
              Positioned(
                bottom: 15,
                right: 30,
                child: Visibility(
                  visible: carouselItems.length > 1 &&
                      _currentIndex < carouselItems.length - 1,
                  child: AnimatedButton(
                    onPressed: () => _carouselController.nextPage(),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color(0xFF38D100),
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox(
                        width: 44,
                        height: 44,
                        child: Center(
                          child: AppIcon(
                            asset: IconProvider.arrow.buildImageUrl(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(15),
        Opacity(
          opacity: _currentIndex < widget.items.length ? 1 : 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: BackContainer(
              child: SizedBox(
                height: 149,
                child: _currentIndex < widget.items.length
                    ? Padding(
                        padding: const EdgeInsets.all(13),
                        child: Row(
                          children: [
                            SizedBox(
                              width: columnWidth + 18 + 5,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 61,
                                    child: Row(
                                      children: [
                                        AppIcon(
                                          asset: IconProvider.water
                                              .buildImageUrl(),
                                          width: 35,
                                          height: 51,
                                        ),
                                        const Gap(6),
                                        SizedBox(
                                          width: columnWidth - 32 + 5,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '${widget.items[_currentIndex].moisture}%',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        const Gap(6),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 61,
                                    child: Row(
                                      children: [
                                        AppIcon(
                                          asset: widget
                                              .items[_currentIndex].sunlight,
                                          width: 47,
                                          height: 46,
                                        ),
                                        const Gap(6),
                                        SizedBox(
                                          width: columnWidth - 43 + 5,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              getWeatherConditionName(
                                                widget.items[_currentIndex]
                                                    .sunlight,
                                              ),
                                              style:
                                                  const TextStyle(fontSize: 25),
                                            ),
                                          ),
                                        ),
                                        const Gap(6),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: columnWidth - 11.5,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 61,
                                    child: Row(
                                      children: [
                                        AppIcon(
                                          asset: IconProvider.thermometer
                                              .buildImageUrl(),
                                          width: 13,
                                          height: 51,
                                        ),
                                        const Gap(6),
                                        SizedBox(
                                          width: columnWidth - 11.5 - 13 - 12,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '${widget.items[_currentIndex].temperature} F',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        const Gap(6),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 61,
                                    child: Row(
                                      children: [
                                        AppIcon(
                                          asset:
                                              IconProvider.list.buildImageUrl(),
                                          height: 60,
                                        ),
                                        const Gap(6),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: widget
                                                .items[_currentIndex].foliage,
                                            shape: BoxShape.circle,
                                            border: Border.all(),
                                          ),
                                        ),
                                        const Gap(6),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: columnWidth - 11.5,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 61,
                                    child: Row(
                                      children: [
                                        AppIcon(
                                          asset: IconProvider.growth
                                              .buildImageUrl(),
                                          width: 17,
                                          height: 38,
                                        ),
                                        const Gap(6),
                                        SizedBox(
                                          width: columnWidth - 11.5 - 17 - 6,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '${widget.items[_currentIndex].growthStage} %',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 61,
                                    child: Row(
                                      children: [
                                        AppIcon(
                                          asset: IconProvider.heart
                                              .buildImageUrl(),
                                          height: 41,
                                          width: 37,
                                        ),
                                        const Gap(6),
                                        SizedBox(
                                          width: columnWidth - 11.5 - 37 - 6,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '${widget.items[_currentIndex].health}%',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
        const Gap(10),
        if (_currentIndex < widget.items.length)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                style: ButtonColors.orange,
                text: 'Detailed',
                textColor: const Color(0xFF4B1400),
                onPressed: () {
                  addDetailedPopup(context, widget.items[_currentIndex]);
                },
              ),
              const Gap(20),
              AppButton(
                style: ButtonColors.green,
                text: 'Edit',
                textColor: const Color(0xFF004B19),
                onPressed: () {
                  context.push(
                    '/home/edit',
                    extra: widget.items[_currentIndex].id,
                  );
                },
              ),
            ],
          )
        else
          const Gap(68),
        const Gap(30),
      ],
    );
  }

  Widget _buildItemWidget(TreeProfile item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEA36D2), width: 8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AppIcon(
            asset: _getImageByPercent(item.growthStage),
            width: 283,
            height: 283,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildPlusIconWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: AnimatedButton(
        onPressed: () {
          context.push('/home/edit');
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFD322C2), width: 9),
            boxShadow: const [
              BoxShadow(color: Color(0xFF0C4407), offset: Offset(0, 2)),
            ],
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6913B5),
                Color(0xFFA337B9),
                Color(0xFFC71D9C),
              ],
              stops: [0.14, 0.83, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SizedBox(
            width: 245,
            height: 245,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: AppIcon(
                  asset: IconProvider.plus.buildImageUrl(),
                  width: 110,
                  height: 110,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addBugPopup(
    BuildContext context,
    TreeProfile tree,
  ) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).removeViewInsets(removeBottom: true),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, StateSetter setState) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 450,
                  child: BackContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppTextField(
                                controller: controller,
                                width: 0.5,
                              ),
                              const Gap(16),
                              AppButton(
                                text: '',
                                style: ButtonColors.purple,
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    setState(() {
                                      final pest = Pest(
                                        id: UniqueKey().toString(),
                                        name: controller.text,
                                        date: DateTime.now(),
                                        isKilled: false,
                                      );
                                      tree.pests.add(pest);
                                      tree.pestRecords.add(
                                        PestRecord(
                                          date: DateTime.now(),
                                          pestName: pest.name,
                                        ),
                                      );

                                      controller.clear();
                                    });
                                  }
                                },
                                child: AppIcon(
                                  asset: IconProvider.plus.buildImageUrl(),
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),
                          Expanded(
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              itemCount: tree.pests.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          tree.pests[index].name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                        const Gap(16),
                                        AppButton(
                                          fontSize: 12,
                                          text: 'X',
                                          style: ButtonColors.red,
                                          onPressed: () {
                                            setState(() {
                                              tree.pests.removeAt(index);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    const Gap(4),
                                    Row(
                                      children: [
                                        Text(
                                          tree.pests[index].date
                                              .toString()
                                              .substring(0, 10),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                        const Gap(16),
                                        AppButton(
                                          style: tree.pests[index].isKilled
                                              ? ButtonColors.green
                                              : ButtonColors.red,
                                          text: tree.pests[index].isKilled
                                              ? 'Killed'
                                              : 'Kill',
                                          fontSize: 12,
                                          onPressed: () {
                                            setState(() {
                                              tree.pests[index].isKilled =
                                                  !tree.pests[index].isKilled;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    const Gap(16),
                                  ],
                                );
                              },
                            ),
                          ),
                          AppButton(
                            text: 'OK',
                            style: ButtonColors.green,
                            onPressed: () {
                              context
                                  .read<UserBloc>()
                                  .add(UserUpdateTree(tree));
                              context.pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void addDetailedPopup(BuildContext context, TreeProfile tree) {
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).removeViewInsets(removeBottom: true),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, StateSetter setState) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 1,
                  ),
                  SizedBox(
                    child: BackContainer(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppButton(
                              style: ButtonColors.green,
                              text: 'Close',
                              onPressed: () {
                                context.pop();
                              },
                            ),
                            const Gap(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 5,
                                  children: [
                                    AppIcon(
                                      asset:
                                          IconProvider.growth.buildImageUrl(),
                                      height: 58,
                                    ),
                                    Text(
                                      '${tree.height} ft',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Font',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 5,
                                  children: [
                                    AppIcon(
                                      asset:
                                          IconProvider.diameter.buildImageUrl(),
                                      height: 58,
                                    ),
                                    Text(
                                      '${tree.diameter} inch',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Font',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 5,
                                  children: [
                                    AppIcon(
                                      asset:
                                          IconProvider.infect.buildImageUrl(),
                                      height: 58,
                                    ),
                                    Text(
                                      tree.pests.any((t) => !t.isKilled)
                                          ? 'Infected'
                                          : 'Free',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Font',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Gap(12),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(19, 250, 250, 250),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                child: Row(
                                  spacing: 12,
                                  children: [
                                    AppIcon(
                                      asset:
                                          IconProvider.freque.buildImageUrl(),
                                      height: 64,
                                    ),
                                    Text(
                                      'Fertilizer type:\n${tree.fertilizer.fertilizer}',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Font',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(12),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(19, 250, 250, 250),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                child: Row(
                                  spacing: 12,
                                  children: [
                                    AppIcon(
                                      asset: IconProvider.soil.buildImageUrl(),
                                      height: 64,
                                      width: 64,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Soil type: ${tree.soil}',
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                        Text(
                                          'acidity: ${tree.acidity} pH',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                        Text(
                                          'moisiture: ${tree.moisture}%',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(12),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(19, 250, 250, 250),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                child: Row(
                                  spacing: 12,
                                  children: [
                                    AppIcon(
                                      asset:
                                          IconProvider.watering.buildImageUrl(),
                                      height: 64,
                                      width: 64,
                                    ),
                                    const Text(
                                      'Type: drip',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Font',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(12),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(19, 250, 250, 250),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                child: Row(
                                  spacing: 12,
                                  children: [
                                    AppIcon(
                                      asset: IconProvider.protected
                                          .buildImageUrl(),
                                      height: 64,
                                      width: 64,
                                    ),
                                    Text(
                                      'Protected type:\n${tree.protection}',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Font',
                                      ),
                                    ),
                                    const Spacer(),
                                    AnimatedButton(
                                      onPressed: () {
                                        addBugPopup(context, tree);
                                      },
                                      child: AppIcon(
                                        asset: IconProvider.bug.buildImageUrl(),
                                        height: 64,
                                        width: 64,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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

String _getImageByPercent(double percent) {
  if (percent < 20) {
    return IconProvider.grow1.buildImageUrl(); // 0-19%
  } else if (percent < 40) {
    return IconProvider.grow2.buildImageUrl(); // 20-39%
  } else if (percent < 60) {
    return IconProvider.grow3.buildImageUrl(); // 40-59%
  } else if (percent < 80) {
    return IconProvider.grow4.buildImageUrl(); // 60-79%
  } else {
    return IconProvider.grow5.buildImageUrl(); // 80-100%
  }
}

String getWeatherConditionName(String iconProvider) {
  switch (iconProvider) {
    case 'assets/images/sun.png':
      return 'Sunny';
    case 'assets/images/cloud.png':
      return 'Cloudy';
    case 'assets/images/sun-cloud.png':
      return 'Partly';
    default:
      return 'unknown';
  }
}
