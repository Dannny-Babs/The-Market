// ignore_for_file: non_constant_identifier_names

import 'package:the_market/models/products.dart';
import 'package:the_market/utils/packages.dart';

class ProductRepository {
  final Dio _dio = Dio();

  Future<List<Products>> getProducts() async {
    final response = await _dio.get('https://dummyjson.com/products');

    // Check if response data is a Map
    if (response.data is Map<String, dynamic>) {
      // Extract the necessary data from the Map
      final responseData = response.data as Map<String, dynamic>;

      // Assuming the data containing products is under a key like "products"
      final productList = responseData['products'];

      // Map productList to List<Products>
      return (productList as List)
          .map((json) => Products(
                title: json['title'],
                price: json['price'],
                image: json['thumbnail'],
                id: json['id'],
                rating: (json['rating'] as num).toDouble(),
              ))
          .toList();
    } else {
      // Handle error or unexpected response format
      throw Exception('Unexpected response format');
    }
  }

  Future<List<Product>> showProduct() async {
    final response = await _dio.get('https://dummyjson.com/products');
    return (response.data as List)
        .map(
          (Json) => Product(
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
            /* images: List<String>.from(
              Json['images'],
            ),*/
          ),
        )
        .toList();
  }
}
