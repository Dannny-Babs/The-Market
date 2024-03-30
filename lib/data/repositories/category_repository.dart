import 'package:the_market/models/products.dart';
import 'package:the_market/utils/packages.dart';

class CategoryRepository {
  final Dio _dio = Dio();

  Future<List<Products>> showCategories(String categoryName) async {
    categoryName = categoryName.toLowerCase();
    final response =
        await _dio.get('https://dummyjson.com/products/category/$categoryName');
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

  Future<List<String>> getCategories() async {
    final response = await _dio.get('https://dummyjson.com/categories');
    return response.data;
  }
}
