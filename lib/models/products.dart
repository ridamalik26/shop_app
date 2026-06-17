import 'dart:convert';

class Product {
  final String id;
  final String productName;
  final int productPrice;
  final int quantity;
  final String description;
  final String category;
  final String vendorId;
  final String fullName;
  final String subCategory;
  final List<String> images;
  final double averageRating;
  final double totalRatings;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.description,
    required this.category,
    required this.vendorId,
    required this.fullName,
    required this.subCategory,
    required this.images,
    required this.totalRatings,
    required this.averageRating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'description': description,
      'category': category,
      'vendorId': vendorId,
      'fullName': fullName,
      'subCategory': subCategory,
      'images': images,
      'averageRating': averageRating,
      'totalRatings': totalRatings,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      productName: map['productName'] ?? '',
      productPrice: map['productPrice'] ?? 0,
      quantity: map['quantity'] ?? 0,
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      vendorId: map['vendorId'] ?? '',
      fullName: map['fullName'] ?? '',
      subCategory: map['subCategory'] ?? '',
      images: map['images'] != null
          ? List<String>.from(map['images'])
          : [],
      totalRatings: map['totalRatings'] is int
          ? (map['totalRatings'] as int).toDouble()
          : map['totalRatings'] as double,
      averageRating: map['averageRating'] is int
          ? (map['averageRating'] as int).toDouble()
          : map['averageRating'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}