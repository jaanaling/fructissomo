part of 'app_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserLoadData extends UserEvent {
  const UserLoadData();
  @override
  List<Object?> get props => [];
}

class UserUpdateData extends UserEvent {
  final String id;
  final String type;
  final String subtype;
  final double height;
  final double diameter;
  final double moisture;
  final double acidity;
  final String protection;
  final Fertilizer fertilizer;
  final String soil;
  final String sunlight;
  final String foliage;
  final double health;
  final double productivity;
  final double growthStage;
  final bool isCheckWater;
  final bool isCheckProductivity;
  final bool isCheckProtect;
  final bool isCheckFertilize;
  final bool isCheckTemperature;
  final bool isPest;
  final List<Pest> pests;

  const UserUpdateData({
    required this.id,
    required this.type,
    required this.subtype,
    required this.height,
    required this.diameter,
    required this.moisture,
    required this.acidity,
    required this.protection,
    required this.fertilizer,
    required this.soil,
    required this.sunlight,
    required this.foliage,
    required this.health,
    required this.productivity,
    required this.growthStage,
    required this.isCheckWater,
    required this.isCheckProductivity,
    required this.isCheckProtect,
    required this.isCheckFertilize,
    required this.isCheckTemperature,
    required this.isPest,
    required this.pests,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        subtype,
        height,
        diameter,
        moisture,
        acidity,
        protection,
        fertilizer,
        soil,
        sunlight,
        foliage,
        health,
        productivity,
        growthStage,
        isCheckWater,
        isCheckProductivity,
        isCheckProtect,
        isCheckFertilize,
        isCheckTemperature,
        isPest,
        pests,
      ];
}
