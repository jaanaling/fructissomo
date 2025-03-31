import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/src/feature/main/model/fertilizer.dart';
import 'package:fructissimo/src/feature/main/model/pest.dart';
import 'package:fructissimo/src/feature/main/model/tree.dart';
import 'package:fructissimo/ui_kit/app_app_bar.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:gap/gap.dart';


class EditScreen extends StatefulWidget {
  final String? id;
  const EditScreen({super.key, this.id});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool isEdit = false;
  bool isPutData = false;

  TextEditingController type = TextEditingController();
  TextEditingController subtype = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController diameter = TextEditingController();
  TextEditingController moisture = TextEditingController();
  TextEditingController acidity = TextEditingController();
  TextEditingController health = TextEditingController();
  TextEditingController growthStage = TextEditingController();
  TextEditingController protection = TextEditingController();
  TextEditingController fertilizer = TextEditingController();
  TextEditingController soil = TextEditingController();
  TextEditingController sunlight = TextEditingController();
  TextEditingController foliage = TextEditingController();

  List<Pest> pests = [];

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
        final trees = state.trees;
        if (isEdit) {
          final currentTree =
              trees.firstWhere((element) => element.id == widget.id);
          if (!isPutData) {
            type.text = currentTree.type;
            subtype.text = currentTree.subtype;
            height.text = currentTree.height.toString();
            diameter.text = currentTree.diameter.toString();
            moisture.text = currentTree.moisture.toString();
            acidity.text = currentTree.acidity.toString();
            health.text = currentTree.health.toString();
            growthStage.text = currentTree.growthStage.toString();
            protection.text = currentTree.protection;
            fertilizer.text = currentTree.fertilizer.fertilizer;
            soil.text = currentTree.soil;
            sunlight.text = currentTree.sunlight;
            foliage.text = currentTree.foliage;
            pests = currentTree.pests;
            isPutData = true;
          }
        }

        return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                AppAppBar(
                  title: "Edit",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void save(TreeProfile? tree) {
    if (tree == null) return;
    final newTree = tree.copyWith(
      type: type.text,
      subtype: subtype.text,
      height: double.parse(height.text),
      diameter: double.parse(diameter.text),
      moisture: double.parse(moisture.text),
      acidity: double.parse(acidity.text),
      health: double.parse(health.text),
      growthStage: double.parse(growthStage.text),
      protection: protection.text,
      fertilizer: Fertilizer(fertilizer: fertilizer.text, fertilization: 0),
      soil: soil.text,
      sunlight: sunlight.text,
      foliage: foliage.text,
      pests: pests,
    );
    context.read<UserBloc>().add(UserUpdateTree(newTree));
  }
}
