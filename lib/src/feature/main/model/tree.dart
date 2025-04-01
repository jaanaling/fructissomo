// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:fructissimo/src/core/utils/icon_provider.dart';

import 'fertilizer.dart';
import 'pest.dart';

class TreeType {
  String id;
  String type;
  List<TreeSubtype> subtypes;

  TreeType({required this.id, required this.type, required this.subtypes});

  TreeType copyWith({String? id, String? type, List<TreeSubtype>? subtypes}) {
    return TreeType(
      id: id ?? this.id,
      type: type ?? this.type,
      subtypes: subtypes ?? this.subtypes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'subtypes': subtypes.map((x) => x.toMap()).toList(),
    };
  }

  factory TreeType.fromMap(Map<String, dynamic> map) {
    return TreeType(
      id: map['id'] as String,
      type: map['type'] as String,
      subtypes: List<TreeSubtype>.from(
        (map['subtypes'] as List<dynamic>).map<TreeSubtype>(
          (x) => TreeSubtype.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TreeType.fromJson(String source) =>
      TreeType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TreeType(id: $id, type: $type, subtypes: $subtypes)';

  @override
  bool operator ==(covariant TreeType other) {
    if (identical(this, other)) return true;

    return other.id == id && other.type == type && other.subtypes == subtypes;
  }

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ subtypes.hashCode;
}

class TreeSubtype {
  String subtype;
  int watering;
  String typeWatering;
  TreeSubtype({
    required this.subtype,
    required this.watering,
    required this.typeWatering,
  });

  TreeSubtype copyWith({String? subtype, int? watering, String? typeWatering}) {
    return TreeSubtype(
      subtype: subtype ?? this.subtype,
      watering: watering ?? this.watering,
      typeWatering: typeWatering ?? this.typeWatering,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subtype': subtype,
      'watering': watering,
      'typeWatering': typeWatering,
    };
  }

  factory TreeSubtype.fromMap(Map<String, dynamic> map) {
    return TreeSubtype(
      subtype: map['subtype'] as String,
      watering: map['watering'] as int,
      typeWatering: map['typeWatering'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TreeSubtype.fromJson(String source) =>
      TreeSubtype.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TreeSubtype(subtype: $subtype, watering: $watering, typeWatering: $typeWatering)';

  @override
  bool operator ==(covariant TreeSubtype other) {
    if (identical(this, other)) return true;

    return other.subtype == subtype &&
        other.watering == watering &&
        other.typeWatering == typeWatering;
  }

  @override
  int get hashCode =>
      subtype.hashCode ^ watering.hashCode ^ typeWatering.hashCode;
}

class TreeProfile {
  String id;
  String type;
  String subtype;
  double height;
  double diameter;
  double moisture;
  double acidity;

  String protection;
  Fertilizer fertilizer;
  String soil;
  String sunlight;
  Color foliage;
  double health;
  double productivity;
  double growthStage;
  bool isCheckWater;
  bool isCheckProductivity;
  bool isCheckProtect;
  bool isCheckFertilize;
  bool isCheckTemperature;
  bool isPest;
  List<Pest> pests;

  List<WateringRecord> wateringRecords;
  List<FertilizationRecord> fertilizationRecords;
  List<ProtectionRecord> protectionRecords;
  List<PestRecord> pestRecords;
  List<HarvestRecord> harvestRecords;
  List<TemperatureRecord> temperatureRecords;

  TreeProfile({
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
    required this.wateringRecords,
    required this.fertilizationRecords,
    required this.protectionRecords,
    required this.pestRecords,
    required this.harvestRecords,
    required this.temperatureRecords,
  });

  TreeProfile copyWith({
    String? id,
    String? type,
    String? subtype,
    double? height,
    double? diameter,
    double? moisture,
    double? acidity,
    String? protection,
    Fertilizer? fertilizer,
    String? soil,
    String? sunlight,
    Color? foliage,
    double? health,
    double? productivity,
    double? growthStage,
    bool? isCheckWater,
    bool? isCheckProductivity,
    bool? isCheckProtect,
    bool? isCheckFertilize,
    bool? isCheckTemperature,
    bool? isPest,
    List<Pest>? pests,
    List<WateringRecord>? wateringRecords,
    List<FertilizationRecord>? fertilizationRecords,
    List<ProtectionRecord>? protectionRecords,
    List<PestRecord>? pestRecords,
    List<HarvestRecord>? harvestRecords,
    List<TemperatureRecord>? temperatureRecords,
  }) {
    return TreeProfile(
      id: id ?? this.id,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      height: height ?? this.height,
      diameter: diameter ?? this.diameter,
      moisture: moisture ?? this.moisture,
      acidity: acidity ?? this.acidity,
      protection: protection ?? this.protection,
      fertilizer: fertilizer ?? this.fertilizer,
      soil: soil ?? this.soil,
      sunlight: sunlight ?? this.sunlight,
      foliage: foliage ?? this.foliage,
      health: health ?? this.health,
      productivity: productivity ?? this.productivity,
      growthStage: growthStage ?? this.growthStage,
      isCheckWater: isCheckWater ?? this.isCheckWater,
      isCheckProductivity: isCheckProductivity ?? this.isCheckProductivity,
      isCheckProtect: isCheckProtect ?? this.isCheckProtect,
      isCheckFertilize: isCheckFertilize ?? this.isCheckFertilize,
      isCheckTemperature: isCheckTemperature ?? this.isCheckTemperature,
      isPest: isPest ?? this.isPest,
      pests: pests ?? this.pests,
      wateringRecords: wateringRecords ?? this.wateringRecords,
      fertilizationRecords: fertilizationRecords ?? this.fertilizationRecords,
      protectionRecords: protectionRecords ?? this.protectionRecords,
      pestRecords: pestRecords ?? this.pestRecords,
      harvestRecords: harvestRecords ?? this.harvestRecords,
      temperatureRecords: temperatureRecords ?? this.temperatureRecords,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'subtype': subtype,
      'height': height,
      'diameter': diameter,
      'moisture': moisture,
      'acidity': acidity,
      'protection': protection,
      'fertilizer': fertilizer.toMap(),
      'soil': soil,
      'sunlight': sunlight,
      'foliage': foliage.value,
      'health': health,
      'productivity': productivity,
      'growthStage': growthStage,
      'isCheckWater': isCheckWater,
      'isCheckProductivity': isCheckProductivity,
      'isCheckProtect': isCheckProtect,
      'isCheckFertilize': isCheckFertilize,
      'isCheckTemperature': isCheckTemperature,
      'isPest': isPest,
      'pests': pests.map((x) => x.toMap()).toList(),
      'wateringRecords': wateringRecords.map((x) => x.toMap()).toList(),
      'fertilizationRecords':
          fertilizationRecords.map((x) => x.toMap()).toList(),
      'protectionRecords': protectionRecords.map((x) => x.toMap()).toList(),
      'pestRecords': pestRecords.map((x) => x.toMap()).toList(),
      'harvestRecords': harvestRecords.map((x) => x.toMap()).toList(),
      'temperatureRecords': temperatureRecords.map((x) => x.toMap()).toList(),
    };
  }

  factory TreeProfile.fromMap(Map<String, dynamic> map) {
    return TreeProfile(
      id: map['id'] as String,
      type: map['type'] as String,
      subtype: map['subtype'] as String,
      height: map['height'] as double,
      diameter: map['diameter'] as double,
      moisture: map['moisture'] as double,
      acidity: map['acidity'] as double,
      protection: map['protection'] as String,
      fertilizer: Fertilizer.fromMap(map['fertilizer'] as Map<String, dynamic>),
      soil: map['soil'] as String,
      sunlight: map['sunlight'] as String,
      foliage: Color(map['foliage'] as int),
      health: map['health'] as double,
      productivity: map['productivity'] as double,
      growthStage: map['growthStage'] as double,
      isCheckWater: map['isCheckWater'] as bool,
      isCheckProductivity: map['isCheckProductivity'] as bool,
      isCheckProtect: map['isCheckProtect'] as bool,
      isCheckFertilize: map['isCheckFertilize'] as bool,
      isCheckTemperature: map['isCheckTemperature'] as bool,
      isPest: map['isPest'] as bool,
      pests: List<Pest>.from(
        (map['pests'] as List<dynamic>).map<Pest>(
          (x) => Pest.fromMap(x as Map<String, dynamic>),
        ),
      ),
      wateringRecords: List<WateringRecord>.from(
        (map['wateringRecords'] as List<dynamic>).map<WateringRecord>(
          (x) => WateringRecord.fromMap(x as Map<String, dynamic>),
        ),
      ),
      fertilizationRecords: List<FertilizationRecord>.from(
        (map['fertilizationRecords'] as List<dynamic>).map<FertilizationRecord>(
          (x) => FertilizationRecord.fromMap(x as Map<String, dynamic>),
        ),
      ),
      protectionRecords: List<ProtectionRecord>.from(
        (map['protectionRecords'] as List<dynamic>).map<ProtectionRecord>(
          (x) => ProtectionRecord.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pestRecords: List<PestRecord>.from(
        (map['pestRecords'] as List<dynamic>).map<PestRecord>(
          (x) => PestRecord.fromMap(x as Map<String, dynamic>),
        ),
      ),
      harvestRecords: List<HarvestRecord>.from(
        (map['harvestRecords'] as List<dynamic>).map<HarvestRecord>(
          (x) => HarvestRecord.fromMap(x as Map<String, dynamic>),
        ),
      ),
      temperatureRecords: List<TemperatureRecord>.from(
        (map['temperatureRecords'] as List<dynamic>).map<TemperatureRecord>(
          (x) => TemperatureRecord.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TreeProfile.fromJson(String source) =>
      TreeProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TreeProfile(id: $id, type: $type, subtype: $subtype, height: $height, diameter: $diameter, moisture: $moisture, acidity: $acidity, protection: $protection, fertilizer: $fertilizer, soil: $soil, sunlight: $sunlight, foliage: $foliage, health: $health, productivity: $productivity, growthStage: $growthStage, isCheckWater: $isCheckWater, isCheckProductivity: $isCheckProductivity, isCheckProtect: $isCheckProtect, isCheckFertilize: $isCheckFertilize, isCheckTemperature: $isCheckTemperature, isPest: $isPest, pests: $pests, wateringRecords: $wateringRecords, fertilizationRecords: $fertilizationRecords, protectionRecords: $protectionRecords, pestRecords: $pestRecords, harvestRecords: $harvestRecords, temperatureRecords: $temperatureRecords)';
  }

  @override
  bool operator ==(covariant TreeProfile other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.subtype == subtype &&
        other.height == height &&
        other.diameter == diameter &&
        other.moisture == moisture &&
        other.acidity == acidity &&
        other.protection == protection &&
        other.fertilizer == fertilizer &&
        other.soil == soil &&
        other.sunlight == sunlight &&
        other.foliage == foliage &&
        other.health == health &&
        other.productivity == productivity &&
        other.growthStage == growthStage &&
        other.isCheckWater == isCheckWater &&
        other.isCheckProductivity == isCheckProductivity &&
        other.isCheckProtect == isCheckProtect &&
        other.isCheckFertilize == isCheckFertilize &&
        other.isCheckTemperature == isCheckTemperature &&
        other.isPest == isPest &&
        listEquals(other.pests, pests) &&
        listEquals(other.wateringRecords, wateringRecords) &&
        listEquals(other.fertilizationRecords, fertilizationRecords) &&
        listEquals(other.protectionRecords, protectionRecords) &&
        listEquals(other.pestRecords, pestRecords) &&
        listEquals(other.harvestRecords, harvestRecords) &&
        listEquals(other.temperatureRecords, temperatureRecords);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        subtype.hashCode ^
        height.hashCode ^
        diameter.hashCode ^
        moisture.hashCode ^
        acidity.hashCode ^
        protection.hashCode ^
        fertilizer.hashCode ^
        soil.hashCode ^
        sunlight.hashCode ^
        foliage.hashCode ^
        health.hashCode ^
        productivity.hashCode ^
        growthStage.hashCode ^
        isCheckWater.hashCode ^
        isCheckProductivity.hashCode ^
        isCheckProtect.hashCode ^
        isCheckFertilize.hashCode ^
        isCheckTemperature.hashCode ^
        isPest.hashCode ^
        pests.hashCode ^
        wateringRecords.hashCode ^
        fertilizationRecords.hashCode ^
        protectionRecords.hashCode ^
        pestRecords.hashCode ^
        harvestRecords.hashCode ^
        temperatureRecords.hashCode;
  }
}

List<String> protections = [
  "Insecticides",
  "Fungicides",
  "Herbicides",
  "Rodenticides",
  "Bactericides",
  "Nematicides",
  "Miticides",
  "Repellents",
  "Growth Regulators",
  "Biological Control Agents",
  "Horticultural Oils",
  "Sulfur Sprays",
  "Copper Sprays",
  "Neem Oil",
  "Diatomaceous Earth",
  "Pyrethrin Sprays",
  "Bacillus thuringiensis",
  "Kaolin Clay",
  "Sticky Traps",
  "Garlic Spray",
  "Pepper Spray",
  "Soap Sprays",
  "Horticultural Vinegar",
  "Essential Oil Blends",
  "Chitin-Based Protectants",
  "Plant-Based Repellents",
  "Hydrogen Peroxide Solutions",
  "Milk-Based Fungicides",
  "Beauveria Bassiana",
  "Trichoderma-Based Biofungicides",
];

List<String> soils = [
  "Clay",
  "Loamy",
  "Sandy",
  "Silty",
  "Peaty",
  "Saline",
  "Chalky",
  "Acidic",
  "Alkaline",
  "Humus-Rich",
  "Alluvial",
  "Red",
  "Black",
  "Desert",
  "Forest",
  "Mountain",
  "Volcanic",
  "Terrace",
  "Floodplain",
  "Riverbank",
  "Coastal",
  "Wetland",
  "Prairie",
  "Swamp",
  "Tundra",
  "Boreal",
  "Steppe",
  "Arid",
  "Temperate",
  "Tropical",
];

List<String> treeVegetationTypes = [
  "Deciduous",
  "Evergreen",
  "Coniferous",
  "Tropical",
  "Subtropical",
  "Temperate",
  "Boreal",
  "Mountainous",
  "Mediterranean",
  "Mangrove",
  "Riparian",
  "Swamp",
  "Floodplain",
  "Rainforest",
  "Dryland",
  "Savanna",
  "Woodland",
  "Forest",
  "Scrubland",
  "Grassland",
  "Coastal",
  "Pine Forest",
  "Oak Forest",
  "Birch Forest",
  "Cedar Forest",
  "Eucalyptus",
  "Sequoia",
  "Baobab",
  "Redwood",
  "Palm Tree",
  "Acacia",
];

List<String> fertilizerUsesForTrees = [
  "Promote Healthy Growth",
  "Enhance Root Development",
  "Increase Flowering",
  "Boost Fruit Production",
  "Improve Leaf Color",
  "Increase Disease Resistance",
  "Strengthen Tree's Overall Health",
  "Correct Soil Deficiencies",
  "Aid in Soil Structure Improvement",
  "Support Tree Recovery after Transplanting",
];

List<String> light = [
  IconProvider.sun.buildImageUrl(),
  IconProvider.cloud.buildImageUrl(),
  IconProvider.sunCloud.buildImageUrl(),
];

class WateringRecord {
  DateTime date;
  double amount;
  WateringRecord({
    required this.date,
    required this.amount,
  });

  WateringRecord copyWith({
    DateTime? date,
    double? amount,
  }) {
    return WateringRecord(
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
    };
  }

  factory WateringRecord.fromMap(Map<String, dynamic> map) {
    return WateringRecord(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      amount: map['amount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory WateringRecord.fromJson(String source) =>
      WateringRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WateringRecord(date: $date, amount: $amount)';

  @override
  bool operator ==(covariant WateringRecord other) {
    if (identical(this, other)) return true;

    return other.date == date && other.amount == amount;
  }

  @override
  int get hashCode => date.hashCode ^ amount.hashCode;
}

class FertilizationRecord {
  DateTime date;
  String fertilizerName;
  double amount;
  FertilizationRecord({
    required this.date,
    required this.fertilizerName,
    required this.amount,
  });

  FertilizationRecord copyWith({
    DateTime? date,
    String? fertilizerName,
    double? amount,
  }) {
    return FertilizationRecord(
      date: date ?? this.date,
      fertilizerName: fertilizerName ?? this.fertilizerName,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'fertilizerName': fertilizerName,
      'amount': amount,
    };
  }

  factory FertilizationRecord.fromMap(Map<String, dynamic> map) {
    return FertilizationRecord(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      fertilizerName: map['fertilizerName'] as String,
      amount: map['amount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory FertilizationRecord.fromJson(String source) =>
      FertilizationRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FertilizationRecord(date: $date, fertilizerName: $fertilizerName, amount: $amount)';

  @override
  bool operator ==(covariant FertilizationRecord other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.fertilizerName == fertilizerName &&
        other.amount == amount;
  }

  @override
  int get hashCode => date.hashCode ^ fertilizerName.hashCode ^ amount.hashCode;
}

class ProtectionRecord {
  DateTime date;
  String protectionName;
  ProtectionRecord({
    required this.date,
    required this.protectionName,
  });

  ProtectionRecord copyWith({
    DateTime? date,
    String? protectionName,
  }) {
    return ProtectionRecord(
      date: date ?? this.date,
      protectionName: protectionName ?? this.protectionName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'protectionName': protectionName,
    };
  }

  factory ProtectionRecord.fromMap(Map<String, dynamic> map) {
    return ProtectionRecord(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      protectionName: map['protectionName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProtectionRecord.fromJson(String source) =>
      ProtectionRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProtectionRecord(date: $date, protectionName: $protectionName)';

  @override
  bool operator ==(covariant ProtectionRecord other) {
    if (identical(this, other)) return true;

    return other.date == date && other.protectionName == protectionName;
  }

  @override
  int get hashCode => date.hashCode ^ protectionName.hashCode;
}

class PestRecord {
  DateTime date;
  String pestName;
  PestRecord({
    required this.date,
    required this.pestName,
  });

  PestRecord copyWith({
    DateTime? date,
    String? pestName,
  }) {
    return PestRecord(
      date: date ?? this.date,
      pestName: pestName ?? this.pestName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'pestName': pestName,
    };
  }

  factory PestRecord.fromMap(Map<String, dynamic> map) {
    return PestRecord(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      pestName: map['pestName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PestRecord.fromJson(String source) =>
      PestRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PestRecord(date: $date, pestName: $pestName)';

  @override
  bool operator ==(covariant PestRecord other) {
    if (identical(this, other)) return true;

    return other.date == date && other.pestName == pestName;
  }

  @override
  int get hashCode => date.hashCode ^ pestName.hashCode;
}

class HarvestRecord {
  DateTime date;
  double amount;
  HarvestRecord({
    required this.date,
    required this.amount,
  });

  HarvestRecord copyWith({
    DateTime? date,
    double? amount,
  }) {
    return HarvestRecord(
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
    };
  }

  factory HarvestRecord.fromMap(Map<String, dynamic> map) {
    return HarvestRecord(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      amount: map['amount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory HarvestRecord.fromJson(String source) =>
      HarvestRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HarvestRecord(date: $date, amount: $amount)';

  @override
  bool operator ==(covariant HarvestRecord other) {
    if (identical(this, other)) return true;

    return other.date == date && other.amount == amount;
  }

  @override
  int get hashCode => date.hashCode ^ amount.hashCode;
}

class TemperatureRecord {
  DateTime date;
  double temperature;
  TemperatureRecord({
    required this.date,
    required this.temperature,
  });

  TemperatureRecord copyWith({
    DateTime? date,
    double? temperature,
  }) {
    return TemperatureRecord(
      date: date ?? this.date,
      temperature: temperature ?? this.temperature,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'temperature': temperature,
    };
  }

  factory TemperatureRecord.fromMap(Map<String, dynamic> map) {
    return TemperatureRecord(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      temperature: map['temperature'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory TemperatureRecord.fromJson(String source) =>
      TemperatureRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TemperatureRecord(date: $date, temperature: $temperature)';

  @override
  bool operator ==(covariant TemperatureRecord other) {
    if (identical(this, other)) return true;

    return other.date == date && other.temperature == temperature;
  }

  @override
  int get hashCode => date.hashCode ^ temperature.hashCode;
}
