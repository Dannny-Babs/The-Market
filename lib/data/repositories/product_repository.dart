// ignore_for_file: non_constant_identifier_names

import 'package:the_market/data/models/products.dart';
import 'package:the_market/utils/packages.dart';

class ProductRepository {
  final Dio _dio = Dio();

  Future<List<Products>> getProducts(String query) async {
    query = query.toLowerCase().replaceAll(' ', '+');
    final response = await _dio
        .get('https://dummyjson.com/products/search?q=$query&limit=0');

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
                brand: json['brand'],
                rating: (json['rating'] as num).toDouble(),
              ))
          .toList();
    } else {
      // Handle error or unexpected response format
      throw Exception('Unexpected response format');
    }
  }

  Future<List<Product>> showProduct(id) async {
    final response = await _dio.get('https://dummyjson.com/products/$id');

    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        final responseData = response.data as Map<String, dynamic>;
        return [Product.fromJson(responseData)];
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load product');
    }
    // Add this line to return an empty list if the function completes normally.
  }
}
