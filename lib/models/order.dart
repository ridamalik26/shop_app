import 'dart:convert';

class Order {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String productName;
  final int quantity;
  final int productPrice;
  final String category;
  final String image;
  final String buyerId;
  final String vendorId;
  final bool processing;
  final bool delivered;

  Order({required this.id, required this.fullName, required this.email, required this.state, required this.city, required this.productName, required this.quantity, required this.productPrice, required this.category, required this.image, required this.buyerId, required this.vendorId, required this.processing, required this.delivered});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'productName': productName,
      'quantity': quantity,
      'productPrice': productPrice,
      'category': category,
      'image': image,
      'buyerId': buyerId,
      'vendorId': vendorId,
      'processing': processing,
      'delivered': delivered,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      productName: map['productName'] ?? '',
      quantity: map['quantity'] ?? 0,
      productPrice: map['productPrice'] ?? 0,
      category: map['category'] ?? '',
      image: map['image'] ?? '',
      buyerId: map['buyerId'] ?? '',
      vendorId: map['vendorId'] ?? '',
      processing: map['processing'] ?? false,
      delivered: map['delivered'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}