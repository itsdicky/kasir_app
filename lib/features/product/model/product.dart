import 'dart:io';

import 'package:kasir_app/core/utils/datetime_utils.dart';

class Product {
  final String? id;
  final String categoryId;
  final String name;
  final int price;
  final File? picture;
  final String? pictureUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Product({
    this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    this.picture,
    this.pictureUrl,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      price: json['price'],
      pictureUrl: json['picture_url'],
      createdAt: DatetimeUtils.fromStringToDateTime(json['created_at']),
      updatedAt: DatetimeUtils.fromStringToDateTime(json['updated_at']),
      deletedAt: DatetimeUtils.fromStringToDateTime(json['deleted_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'price': price,
      'picture_url': pictureUrl,
      'created_at': DatetimeUtils.fromDateTimeToString(createdAt),
      'updated_at': DatetimeUtils.fromDateTimeToString(updatedAt),
      'deleted_at': DatetimeUtils.fromDateTimeToString(deletedAt),
    };
  }

  @override
  String toString() =>
      'Product(id: $id, category_id: $categoryId, name: $name, price: $price, picture_url: $pictureUrl, created_at: $createdAt, updated_at: $updatedAt, deleted_at: $deletedAt)';
}
