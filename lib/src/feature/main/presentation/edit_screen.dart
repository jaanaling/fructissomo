import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fructissimo/src/core/utils/animated_button.dart';
import 'package:fructissimo/src/core/utils/app_icon.dart';
import 'package:fructissimo/src/core/utils/cupertino_snack_bar.dart';
import 'package:fructissimo/src/core/utils/icon_provider.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/src/feature/main/model/fertilizer.dart';
import 'package:fructissimo/src/feature/main/model/pest.dart';
import 'package:fructissimo/src/feature/main/model/tree.dart';
import 'package:fructissimo/ui_kit/app_app_bar.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:fructissimo/ui_kit/app_text_field.dart';
import 'package:fructissimo/ui_kit/back_container.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class EditScreen extends StatefulWidget {
  final String? id;
  const EditScreen({super.key, this.id});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final List<Color> leafColors = List.generate(
    100,
    (index) => HSVColor.fromAHSV(
      1.0,
      120.0 -
          (index * 1.2), // Плавный переход от 120° (зелёного) к 0° (красному)
      1.0,
      0.5,
    ).toColor(),
  );

  bool isEdit = false;
  bool isPutData = false;

  TextEditingController height = TextEditingController();
  TextEditingController diameter = TextEditingController();
  double? moisture;
  TextEditingController acidity = TextEditingController();
  double? health;
  double? growthStage;

  String? type;
  String? subtype;
  String? protection;
  String? fertilizer;
  String? soil;
  String? sunlight;
  Color? foliage;

  List<Pest> pests = [];

  String error = '';

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      isEdit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }
        final treesTypes = state.treeTypes;
        List<TreeSubtype> treesSubtypes = [];

        if (type != null) {
          treesSubtypes = treesTypes
              .firstWhere(
                (element) => element.type == type,
              )
              .subtypes;
        }

        if (isEdit) {
          final currentTree =
              state.trees.firstWhere((element) => element.id == widget.id);
          if (!isPutData) {
            type = currentTree.type;
            subtype = currentTree.subtype;
            height.text = currentTree.height.toString();
            diameter.text = currentTree.diameter.toString();
            moisture = currentTree.moisture;
            acidity.text = currentTree.acidity.toString();
            health = currentTree.health;
            growthStage = currentTree.growthStage;
            protection = currentTree.protection;
            fertilizer = currentTree.fertilizer.fertilizer;
            soil = currentTree.soil;
            sunlight = currentTree.sunlight;
            foliage = currentTree.foliage;
            pests = currentTree.pests;
            isPutData = true;
          }
        }

        return SingleChildScrollView(
          child: SafeArea(
            child: BackContainer(
              child: Column(
                spacing: 7,
                children: [
                  AppAppBar(
                    title: isEdit ? 'Edit' : 'Create',
                  ),
                  const Gap(12),
                  if (!isEdit)
                    AppButton(
                      text: type ?? 'Type',
                      style: ButtonColors.green,
                      onPressed: () {
                        addStatusPopup(
                          context,
                          treesTypes,
                          (id) {
                            setState(() {
                              type = treesTypes[id].type;
                            });
                          },
                        );
                      },
                    ),
                  if (!isEdit)
                    AppButton(
                      text: subtype ?? 'Subtype',
                      style: ButtonColors.green,
                      onPressed: () {
                        if (type == null) {
                          showCupertinoSnackBar(context, 'Select type first');
                          return;
                        }
                        addStatusPopup(
                          context,
                          treesSubtypes,
                          (id) {
                            setState(() {
                              subtype = treesSubtypes[id].subtype;
                            });
                          },
                        );
                      },
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Growth:"),
                      const Gap(12),
                      AppButton(
                        text: growthStage?.toString() ?? '0',
                        style: ButtonColors.green,
                        onPressed: () {
                          addPersentPopup(context, growthStage ?? 0, (id) {
                            setState(() {
                              growthStage = id.toDouble();
                            });
                          });
                        },
                      ),
                      const Gap(12),
                      Text("%"),
                    ],
                  ),
                  TextFieldRow(
                    controller: height,
                    prefix: 'Height',
                    postfix: 'ft',
                  ),
                  TextFieldRow(
                    controller: diameter,
                    prefix: 'Diameter',
                    postfix: 'inch',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcon(
                        asset: IconProvider.soil.buildImageUrl(),
                        height: 100,
                      ),
                      const Gap(4),
                      Text("Soil:"),
                      const Gap(12),
                      AppButton(
                        text: soil ?? 'Type',
                        style: ButtonColors.green,
                        onPressed: () {
                          addStatusPopup(
                            context,
                            soils,
                            (id) {
                              setState(() {
                                soil = soils[id];
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Humidity:"),
                      const Gap(12),
                      AppButton(
                        text: moisture?.toString() ?? '0',
                        style: ButtonColors.green,
                        onPressed: () {
                          addPersentPopup(context, moisture ?? 0, (id) {
                            setState(() {
                              moisture = id.toDouble();
                            });
                          });
                        },
                      ),
                      const Gap(12),
                      Text("%"),
                    ],
                  ),
                  TextFieldRow(
                    controller: acidity,
                    prefix: 'Acidity',
                    postfix: 'pH',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcon(
                        asset: IconProvider.protected.buildImageUrl(),
                        height: 100,
                      ),
                      const Gap(4),
                      Text("Protection:"),
                      const Gap(12),
                      AppButton(
                        text: protection ?? 'Type',
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcon(
                        asset: IconProvider.freque.buildImageUrl(),
                        height: 100,
                      ),
                      const Gap(4),
                      Text("Fertilizer:"),
                      const Gap(12),
                      AppButton(
                        text: fertilizer ?? 'Type',
                        style: ButtonColors.green,
                        onPressed: () {
                          addStatusPopup(
                            context,
                            fertilizers.map((e) => e.fertilizer).toList(),
                            (id) {
                              setState(() {
                                fertilizer = fertilizers[id].fertilizer;
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (isEdit)
                        AnimatedButton(
                          child: AppIcon(
                            asset: IconProvider.bug.buildImageUrl(),
                            height: 85,
                          ),
                          onPressed: () {
                            addBugPopup(context);
                          },
                        ),
                      AnimatedButton(
                        child: AppIcon(
                          asset: sunlight ?? light.first,
                          height: 60,
                        ),
                        onPressed: () {
                          setState(() {
                            if (sunlight == light.last) {
                              sunlight = light.first;
                            } else
                              sunlight = light[
                                  light.indexOf(sunlight ?? light.first) + 1];
                          });
                        },
                      ),
                      AnimatedButton(
                        child: Row(
                          children: [
                            AppIcon(
                              asset: IconProvider.list.buildImageUrl(),
                              height: 60,
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: foliage ?? Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          addColorPopup(
                            context,
                            leafColors,
                            (id) {
                              setState(() {
                                foliage = leafColors[id];
                              });
                            },
                          );
                        },
                      ),
                      AnimatedButton(
                        child: Row(
                          children: [
                            AppIcon(
                              asset: IconProvider.heart.buildImageUrl(),
                              height: 60,
                            ),
                            Text("${health?.toString() ?? 0} %"),
                          ],
                        ),
                        onPressed: () {
                          addPersentPopup(
                            context,
                            health ?? 0,
                            (id) {
                              setState(() {
                                health = id.toDouble();
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const Gap(12),
                  if (error.isNotEmpty)
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isEdit)
                        AppButton(
                          text: 'Delete',
                          style: ButtonColors.red,
                          onPressed: () {
                            delete(
                              state.trees.firstWhere(
                                (element) => element.id == widget.id,
                              ),
                            );
                          },
                        ),
                      const Gap(12),
                      AppButton(
                        text: 'Save',
                        style: ButtonColors.green,
                        onPressed: () {
                          save(
                            isEdit
                                ? state.trees.firstWhere(
                                    (element) => element.id == widget.id,
                                  )
                                : null,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void save(TreeProfile? tree) {
    if (type == null ||
        subtype == null ||
        height.text.isEmpty ||
        diameter.text.isEmpty ||
        moisture == null ||
        acidity.text.isEmpty ||
        health == null ||
        growthStage == null ||
        protection == null ||
        fertilizer == null ||
        soil == null ||
        sunlight == null ||
        foliage == null) {
      setState(() {
        error = 'Need fill all fields';
      });
      return;
    }

    if (tree != null) {
      final newTree = tree.copyWith(
        type: type,
        subtype: subtype,
        height: double.parse(height.text),
        diameter: double.parse(diameter.text),
        moisture: moisture,
        acidity: double.parse(acidity.text),
        health: health,
        growthStage: growthStage,
        protection: protection,
        fertilizer: fertilizers
            .firstWhere((element) => element.fertilizer == fertilizer),
        soil: soil,
        sunlight: sunlight,
        foliage: foliage,
        pests: pests,
      );
      context.read<UserBloc>().add(UserUpdateTree(newTree));
      context.pop();
    } else {
      final newTree = TreeProfile(
        id: UniqueKey().toString(),
        type: type!,
        subtype: subtype!,
        height: double.parse(height.text),
        diameter: double.parse(diameter.text),
        moisture: moisture!,
        acidity: double.parse(acidity.text),
        health: health!,
        growthStage: growthStage!,
        protection: protection!,
        fertilizer: fertilizers
            .firstWhere((element) => element.fertilizer == fertilizer),
        productivity: 0,
        soil: soil!,
        sunlight: sunlight!,
        foliage: foliage!,
        isCheckWater: false,
        isCheckProductivity: false,
        isCheckProtect: false,
        isCheckFertilize: false,
        isCheckTemperature: false,
        isPest: false,
        pests: pests,
        wateringRecords: [],
        fertilizationRecords: [],
        protectionRecords: [],
        pestRecords: [],
        harvestRecords: [],
        temperatureRecords: [],
      );
      context.read<UserBloc>().add(UserAddData(newTree));
      context.pop();
    }
  }

  void delete(TreeProfile tree) {
    context.read<UserBloc>().add(UserDeleteTree(tree));
    context.pop();
  }

  void addColorPopup(BuildContext context, List list, Function(int) submit) {
    int selectedItem = 0;
    Color selectedColor = foliage ?? leafColors[0];

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
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  height: 600,
                  child: BackContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: selectedColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 10,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              itemCount: leafColors.length,
                              itemBuilder: (context, index) {
                                return AnimatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedItem = index;
                                      selectedColor = leafColors[index];
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: leafColors[index],
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: selectedColor == leafColors[index]
                                            ? 3
                                            : 1,
                                      ),
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
              ),
            ),
          ),
        );
      },
    );
  }

  void addPersentPopup(
    BuildContext context,
    double value,
    Function(int) submit,
  ) {
    int values = value.toInt();

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
                          Text(values.toString(),
                              style:
                                  TextStyle(fontSize: 65, fontFamily: "Font")),
                          SizedBox(height: 10),
                          Slider(
                            value: value,
                            max: 100,
                            onChanged: (id) => setState(
                              () {
                                values = id.toInt();
                                value = id;
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
                                  submit(values);
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

  void addBugPopup(
    BuildContext context,
  ) {
    TextEditingController controller = TextEditingController();

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 150),
                child: BackContainer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AppTextField(controller: controller),
                          AppButton(
                            text: '+',
                            style: ButtonColors.purple,
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                setState(() {
                                  pests.add(
                                    Pest(
                                      id: UniqueKey().toString(),
                                      name: controller.text,
                                      date: DateTime.now(),
                                      isKilled: false,
                                    ),
                                  );
                                  controller.clear();
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: pests.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Text(pests[index].name),
                                AppButton(
                                  text: 'X',
                                  style: ButtonColors.red,
                                  onPressed: () {
                                    setState(() {
                                      pests.removeAt(index);
                                    });
                                  },
                                ),
                                const Gap(12),
                                Text(
                                  pests[index].date.toString(),
                                ),
                                AppButton(
                                  style: pests[index].isKilled
                                      ? ButtonColors.green
                                      : ButtonColors.red,
                                  text:
                                      pests[index].isKilled ? 'Killed' : 'Kill',
                                  onPressed: () {
                                    setState(() {
                                      pests[index].isKilled =
                                          !pests[index].isKilled;
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      AppButton(
                        text: 'OK',
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
        );
      },
    );
  }

  void addStatusPopup(BuildContext context, List list, Function(int) submit) {
    int selectedItem = 0;
    void onSelectedItemChanged(int index) {
      setState(() {
        selectedItem = index;
      });
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
                                      list[index] is TreeType
                                          ? (list[index] as TreeType).type
                                          : list[index] is TreeSubtype
                                              ? (list[index] as TreeSubtype)
                                                  .subtype
                                              : list[index] as String,
                                      style: TextStyle(
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
}

class TextFieldRow extends StatelessWidget {
  final TextEditingController controller;
  final String prefix;
  final String postfix;

  const TextFieldRow({
    super.key,
    required this.controller,
    required this.prefix,
    required this.postfix,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 15,
      children: [
        Text(prefix),
        AppTextField(controller: controller),
        Text(postfix),
      ],
    );
  }
}
