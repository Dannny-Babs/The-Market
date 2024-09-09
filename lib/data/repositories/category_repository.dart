import 'package:the_market/data/models/products.dart';
import 'package:the_market/utils/packages.dart';
class CategoryRepository {
  final Dio _dio = Dio();

  Future<List<Products>> showCategories(String categoryName) async {
    categoryName = categoryName.toLowerCase();
    final response = await _dio.get('https://dummyjson.com/products?limit=50');
    final categoryresponse = await _dio
        .get('https://dummyjson.com/products/category/$categoryName?limit=0');
    if (categoryName == 'all') {
      // Check if response data is a Map
      if (response.data is Map<String, dynamic>) {
        // Extract the necessary data from the Map
        final responseData = response.data as Map<String, dynamic>;

        // Assuming the data containing products is under a key like "products"
        final productList = responseData['products'];

        // Map productList to List<Products>
        return (productList as List)
            .map((json) => Products(
                  title: json['title'] ?? 'Unknown Title', // Add null check
                  price: json['price'] ?? 0.0, // Add null check
                  image: json['thumbnail'] ?? 'default_image.png', // Add null check
                  id: json['id'] ?? 0, // Add null check
                  brand: json['brand'] ?? 'Unknown Brand', // Add null check
                  rating: (json['rating'] as num?)?.toDouble() ?? 0.0, // Add null check
                ))
            .toList();
      } else {
        // Handle error or unexpected response format
        throw Exception(response.data);
      }
    } else {
      // Check if response data is a Map
      if (categoryresponse.data is Map<String, dynamic>) {
        // Extract the necessary data from the Map
        final responseData = categoryresponse.data as Map<String, dynamic>;

        // Assuming the data containing products is under a key like "products"
        final productList = responseData['products'];

        // Map productList to List<Products>
        return (productList as List)
            .map((json) => Products(
                  title: json['title'] ?? 'Unknown Title', // Add null check
                  price: json['price'] ?? 0.0, // Add null check
                  brand: json['brand'] ?? 'Unknown Brand', // Add null check
                  image: json['thumbnail'] ?? 'default_image.png', // Add null check
                  id: json['id'] ?? 0, // Add null check
                  rating: (json['rating'] as num?)?.toDouble() ?? 0.0, // Add null check
                ))
            .toList();
      } else {
        // Handle error or unexpected response format
         throw Exception(response.data);
      }
    }
  }

  Future<List<String>> getCategories() async {
    final response = await _dio.get('https://dummyjson.com/categories');
    return response.data;
  }
}
