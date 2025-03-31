// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
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
  String foliage;
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
    String? foliage,
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
      'foliage': foliage,
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
      foliage: map['foliage'] as String,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory TreeProfile.fromJson(String source) =>
      TreeProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TreeProfile(id: $id, type: $type, subtype: $subtype, height: $height, diameter: $diameter, moisture: $moisture, acidity: $acidity, protection: $protection, fertilizer: $fertilizer, soil: $soil, sunlight: $sunlight, foliage: $foliage, health: $health, productivity: $productivity, growthStage: $growthStage, isCheckWater: $isCheckWater, isCheckProductivity: $isCheckProductivity, isCheckProtect: $isCheckProtect, isCheckFertilize: $isCheckFertilize, isCheckTemperature: $isCheckTemperature, isPest: $isPest, pests: $pests)';
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
        other.pests == pests;
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
        pests.hashCode;
  }
}

List<String> protection = [
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

List<String> soil = [
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
