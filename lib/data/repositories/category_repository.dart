import 'package:the_market/models/products.dart';
import 'package:the_market/utils/packages.dart';

class CategoryRepository {
  final Dio _dio = Dio();

  Future<List<Products>> showCategories(String categoryName) async {
    categoryName = categoryName.toLowerCase();
    final response =
        await _dio.get('https://dummyjson.com/products/category/$categoryName');
    return (response.data as List)
        .map((Json) => Products(
            title: Json['title'],
            price: Json['price'],
            image: Json['thumbnail'],
            id: Json['id'],
            rating: Json['rating']))
        .toList();
  }

  Future<List<String>> getCategories() async {
    final response = await _dio.get('https://dummyjson.com/categories');
    return response.data;
  }
}
