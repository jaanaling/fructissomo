// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tips {
  final int id;
  final String description;
  Tips({
    required this.id,
    required this.description,
  });

  Tips copyWith({
    int? id,
    String? description,
  }) {
    return Tips(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
    };
  }

  factory Tips.fromMap(Map<String, dynamic> map) {
    return Tips(
      id: map['id'] as int,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tips.fromJson(String source) => Tips.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Tips(id: $id, description: $description)';

  @override
  bool operator ==(covariant Tips other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ description.hashCode;
}
