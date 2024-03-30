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

  Future<List<Product>> showProduct(id) async {
    final response = await _dio.get('https://dummyjson.com/products/$id');

    // Check for successful response
    if (response.statusCode == 200) {
      // Parse the JSON data
      final List jsonProducts = response.data as List;

      // Convert each JSON object to a Product object
      return jsonProducts
          .map((jsonProduct) => Product.fromJson(jsonProduct))
          .toList();
    } else {
      // Handle error based on response code
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}
