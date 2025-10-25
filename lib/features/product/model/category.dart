import 'package:kasir_app/core/utils/datetime_utils.dart';

class Category {
  final String? id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Category({
    this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      createdAt: DatetimeUtils.fromStringToDateTime(json['created_at']),
      updatedAt: DatetimeUtils.fromStringToDateTime(json['updated_at']),
      deletedAt: DatetimeUtils.fromStringToDateTime(json['deleted_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': DatetimeUtils.fromDateTimeToString(createdAt),
      'updated_at': DatetimeUtils.fromDateTimeToString(updatedAt),
      'deleted_at': DatetimeUtils.fromDateTimeToString(deletedAt),
    };
  }

  @override
  String toString() =>
      'Category(id: $id, name: $name, created_at: $createdAt, updated_at: $updatedAt, deleted_at: $deletedAt)';
}
