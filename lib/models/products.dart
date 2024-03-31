// This file contains the model class for the product. It has the properties name, description, price, and image. It also has a factory constructor to convert the JSON data to a Product object.


class Products {
  final String title;
  final int price;
  final String image;
  final int id;
  final double rating;

  const Products({
    required this.title,
    required this.price,
    required this.image,
    required this.id,
    this.rating = 4.5,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      title: json['title'],
      price: json['price'],
      image: json['image'],
      id: json['id'],
      rating: json['rating'],
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
      discountPercentage: json['discountPercentage'],
      rating: json['rating'],
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }
}
