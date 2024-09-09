// This file contains the model class for the product. It has the properties name, description, price, and image. It also has a factory constructor to convert the JSON data to a Product object.

class Products {
  final String title;
  final double price;
  final String image;
  final String brand;
  final int id;
  final double rating;
  final int quantity;

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
      title: json['title'] ?? 'Unknown Title', // Add null check
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // Add null check and cast to double
      image: json['image'] ?? 'default_image.png', // Add null check
      brand: json['brand'] ?? 'Unknown Brand', // Add null check
      id: (json['id'] as num?)?.toInt() ?? 0, // Add null check and cast to int
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5, // Add null check and cast to double
    );
  }

  Products copyWith({
    String? title,
    double? price,
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
      id: (json['id'] as num?)?.toInt() ?? 0, // Add null check and cast to int
      title: json['title'] ?? 'Unknown Title', // Add null check
      description: json['description'] ?? 'No Description', // Add null check
      price: (json['price'] as num?)?.toInt() ?? 0, // Add null check and cast to int
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0, // Add null check and cast to double
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0, // Add null check and cast to double
      stock: (json['stock'] as num?)?.toInt() ?? 0, // Add null check and cast to int
      brand: json['brand'] ?? 'Unknown Brand', // Add null check
      category: json['category'] ?? 'Unknown Category', // Add null check
      thumbnail: json['thumbnail'] ?? 'default_image.png', // Add null check
      images: json['images'] != null
          ? List<String>.from(json['images'].map((x) => x))
          : [], // Add null check
    );
  }
}