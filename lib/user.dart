import 'dart:convert';

class UserFields {
  static const String id = 'ID';
  static const String name = 'Name';
  static const String details = 'Details';
  static const String isTrue = "isTrue?";

  static List<String> getFields() => [id, name, details, isTrue];
}

class User {
  final int? id;
  final String name;
  final String detail;
  final bool isTrue;

  const User({
    this.id,
    required this.name,
    required this.detail,
    required this.isTrue,
  });

  User copy({int? id, String? name, String? detail, bool? isTrue}) => User(
      id: id ?? this.id,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      isTrue: isTrue ?? this.isTrue);

  static User fromJson(Map<String, dynamic> json) => User(
      id: jsonDecode(json[UserFields.id]),
      name: json[UserFields.name],
      detail: json[UserFields.details],
      isTrue: jsonDecode(json[UserFields.isTrue]),
      );

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.details: detail,
        UserFields.isTrue: isTrue
      };
}
