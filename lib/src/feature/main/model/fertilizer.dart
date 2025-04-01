// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Fertilizer {
  String fertilizer;
  int fertilization; // 1 -5
  Fertilizer({required this.fertilizer, required this.fertilization});

  Fertilizer copyWith({String? fertilizer, int? fertilization}) {
    return Fertilizer(
      fertilizer: fertilizer ?? this.fertilizer,
      fertilization: fertilization ?? this.fertilization,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fertilizer': fertilizer,
      'fertilization': fertilization,
    };
  }

  factory Fertilizer.fromMap(Map<String, dynamic> map) {
    return Fertilizer(
      fertilizer: map['fertilizer'] as String,
      fertilization: map['fertilization'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fertilizer.fromJson(String source) =>
      Fertilizer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Fertilizer(fertilizer: $fertilizer, fertilization: $fertilization)';

  @override
  bool operator ==(covariant Fertilizer other) {
    if (identical(this, other)) return true;

    return other.fertilizer == fertilizer &&
        other.fertilization == fertilization;
  }

  @override
  int get hashCode => fertilizer.hashCode ^ fertilization.hashCode;
}

List<Fertilizer> fertilizers = [
  Fertilizer(fertilizer: "Nitrogen Fertilizer", fertilization: 5),
  Fertilizer(fertilizer: "Phosphorus Fertilizer", fertilization: 4),
  Fertilizer(fertilizer: "Potassium Fertilizer", fertilization: 5),
  Fertilizer(fertilizer: "Calcium Nitrate", fertilization: 3),
  Fertilizer(fertilizer: "Magnesium Sulfate", fertilization: 4),
  Fertilizer(fertilizer: "Ammonium Nitrate", fertilization: 5),
  Fertilizer(fertilizer: "Urea", fertilization: 5),
  Fertilizer(fertilizer: "Superphosphate", fertilization: 4),
  Fertilizer(fertilizer: "Bone Meal", fertilization: 3),
  Fertilizer(fertilizer: "Blood Meal", fertilization: 4),
  Fertilizer(fertilizer: "Fish Emulsion", fertilization: 3),
  Fertilizer(fertilizer: "Compost", fertilization: 2),
  Fertilizer(fertilizer: "Manure", fertilization: 2),
  Fertilizer(fertilizer: "Seaweed Extract", fertilization: 3),
  Fertilizer(fertilizer: "Greensand", fertilization: 2),
  Fertilizer(fertilizer: "Rock Phosphate", fertilization: 3),
  Fertilizer(fertilizer: "Gypsum", fertilization: 2),
  Fertilizer(fertilizer: "Epsom Salt", fertilization: 3),
  Fertilizer(fertilizer: "Dolomite Lime", fertilization: 2),
  Fertilizer(fertilizer: "Sulfur", fertilization: 4),
  Fertilizer(fertilizer: "Zinc Sulfate", fertilization: 3),
  Fertilizer(fertilizer: "Iron Chelate", fertilization: 4),
  Fertilizer(fertilizer: "Manganese Sulfate", fertilization: 3),
  Fertilizer(fertilizer: "Copper Sulfate", fertilization: 4),
  Fertilizer(fertilizer: "Boron", fertilization: 3),
  Fertilizer(fertilizer: "Molybdenum", fertilization: 3),
  Fertilizer(fertilizer: "Silicon Fertilizer", fertilization: 2),
  Fertilizer(fertilizer: "Humic Acid", fertilization: 4),
  Fertilizer(fertilizer: "Fulvic Acid", fertilization: 4),
  Fertilizer(fertilizer: "Vermicompost", fertilization: 3),
];


