// This file contains the model class for the product. It has the properties name, description, price, and image. It also has a factory constructor to convert the JSON data to a Product object.

class Products {
  final String title;
  final int price;
  final String image;
  final String brand;
  final int id;
  final double rating;
  final int quantity ;

  const Products({
    required this.title,
    required this.price,
    required this.image,
    required this.brand,
    required this.id,
    this.rating = 4.5,
    this.quantity = 1,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      title: json['title'],
      price: json['price'],
      image: json['image'],
      brand: json['brand'],
      id: json['id'],
      rating: json['rating'],
    );
  }

  Products copyWith({
    String? title,
    int? price,
    String? image,
    String? brand,
    int? id,
    double? rating,
    int? quantity,
  }) {
    return Products(
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      brand: brand ?? this.brand,
      id: id ?? this.id,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
    );
  }
}

class Product {
  final int id;
  final String title;
  final String description;
  final int price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discountPercentage: json['discountPercentage'] * 1.00,
      rating: json['rating'] * 1.00,
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: json['images'] != null
          ? List<String>.from(json['images'].map((x) => x))
          : [],
    );
  }
}
