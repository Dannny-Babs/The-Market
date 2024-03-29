// ignore_for_file: non_constant_identifier_names

import 'package:the_market/models/products.dart';
import 'package:the_market/utils/packages.dart';

class ProductRepository {
  final Dio _dio = Dio();

  Future<List<Products>> getProducts() async {
    final response = await _dio.get('https://dummyjson.com/products');
    return (response.data as List)
        .map((Json) => Products(
            title: Json['title'],
            price: Json['price'],
            image: Json['thumbnail'],
            id: Json['id'],
            rating: Json['rating']))
        .toList();
  }

  Future<List<Product>> showProduct() async {
    final response = await _dio.get('https://dummyjson.com/products');
    return (response.data as List)
        .map((Json) => Product(
            id: Json['id'],
            title: Json['title'],
            description: Json['description'],
            price: Json['price'],
            discountPercentage: Json['discountPercentage'],
            rating: Json['rating'],
            stock: Json['stock'],
            brand: Json['brand'],
            category: Json['category'],
            thumbnail: Json['thumbnail'],
            images: List<String>.from(Json['images'])))
        .toList();
  }
}
