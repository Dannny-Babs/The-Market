import 'package:the_market/models/products.dart';

enum StoreRequest { unknown, loading, success, error }

class StoreState {
  const StoreState({
    this.productStatus = StoreRequest.unknown,
    this.products = const [],
    this.product = const [],
    this.categories = const [],
    required this.tabIndex ,
    this.cartIds = const {},
    this.favoriteIds = const {},
  });

  final StoreRequest productStatus;
  final int tabIndex;
  final List<Products> products;
  final List<Product> product;
  final List<String> categories;
  final Set<int> cartIds;
  final Set<int> favoriteIds;

  StoreState copyWith({
    StoreRequest? productStatus,
    int? tabIndex,
    List<Products>? products,
    List<Product>?product,
    List<String>? categories,
    Set<int>? cartIds,
    Set<int>? favoriteIds,
  }) {
    return StoreState(
      productStatus: productStatus ?? this.productStatus,
      tabIndex: tabIndex ?? this.tabIndex,
      products: products ?? this.products,
      product: product ?? this.product,
      categories: categories ?? this.categories,
      cartIds: cartIds ?? this.cartIds,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}
