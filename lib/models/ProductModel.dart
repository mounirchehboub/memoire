import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productId;
  final String title, description;
  final int stock, promotion;
  final List<String> images;
  final double rating, price;
  bool isAvailable, isPromo;
  final String category;
  final String brand;
  final int km, peopleCapacity;

  Product(
      {required this.promotion,
      required this.productId,
      required this.stock,
      required this.images,
      this.rating = 2.5,
      this.isPromo = false,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      this.isAvailable = true,
      required this.brand,
      required this.km,
      required this.peopleCapacity});

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Product(
        promotion: data?['promotion'],
        images: data?['images'] is Iterable ? List.from(data?['images']) : [],
        title: data?['title'],
        rating: data?['rating'],
        description: data?['description'],
        price: data?['price'],
        productId: data?['productId'],
        category: data?['category'],
        isAvailable: data?['isAvailable'],
        stock: data?['stock'],
        brand: data?['brand'],
        km: data?['km'],
        peopleCapacity: data?['peopleCapacity'],
        isPromo: data?['isPromo']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (images != null) "images": images,
      if (rating != null) "rating": rating,
      if (description != null) "description": description,
      if (isPromo != null) "isPromo": isPromo,
      if (title != null) "title": title,
      if (price != null) "price": price,
      if (isAvailable != null) "isAvailable": isAvailable,
      if (productId != null) "productId": productId,
      if (category != null) "category": category,
      if (promotion != null) "promotion": promotion,
      if (stock != null) "stock": stock,
      if (km != null) "km": km,
      if (peopleCapacity != null) "peopleCapacity": peopleCapacity,
      if (brand != null) "brand": brand,
    };
  }
}

/*

  Product copyWith(
      {String? productId,
      int? stock,
      String? title,
      String? description,
      int? promotion,
      List<String>? images,
      double? rating,
      double? price,
      bool? isAvailable,
      String? category,
      String? km,
      String? peopleCapacity,
      String? brand,
     }) {
    return Product(
      productId: productId ?? this.productId,
      stock: stock ?? this.stock,
      title: title ?? this.title,
      description: description ?? this.description,
      promotion: promotion ?? this.promotion,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      isAvailable: isAvailable ?? this.isAvailable,
      category: category ?? this.category,
    );
  }
 */
