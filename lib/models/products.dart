// This file contains the model class for the product. It has the properties name, description, price, and image. It also has a factory constructor to convert the JSON data to a Product object.

class Products {
  final String title;
  final double price;
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
     int id;
    String title;
    String description;
    int price;
    double discountPercentage;
    double rating;
    int stock;
    String brand;
    String category;
    String thumbnail;
    List<String> images;

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
      title: json['title'],
      description: json['description'],
      price: json['price'],
      images: json['images'],
      id: json['id'],
      rating: json['rating'],
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      discountPercentage: json['discountPercentage'],
    );
  }  

}