// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Pest {
  String id;
  String name;
  DateTime date;
  bool isKilled;

  Pest({
    required this.id,
    required this.name,
    required this.date,
    required this.isKilled,
  });

  Pest copyWith({
    String? id,
    String? name,
    DateTime? date,
    bool? isKilled,
  }) {
    return Pest(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      isKilled: isKilled ?? this.isKilled,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'isKilled': isKilled,
    };
  }

  factory Pest.fromMap(Map<String, dynamic> map) {
    return Pest(
      id: map['id'] as String,
      name: map['name'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      isKilled: map['isKilled'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pest.fromJson(String source) => Pest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pest(id: $id, name: $name, date: $date, isKilled: $isKilled)';
  }

  @override
  bool operator ==(covariant Pest other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.date == date &&
      other.isKilled == isKilled;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      date.hashCode ^
      isKilled.hashCode;
  }
}
