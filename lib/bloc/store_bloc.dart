import 'package:bloc/bloc.dart';
import 'package:the_market/data/repositories/category_repository.dart';
import 'package:the_market/data/repositories/product_repository.dart';
import 'package:the_market/utils/bloc.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(const StoreState(tabIndex: 0)) {
    on<ProductRequested>(_handleProductRequested);
    on<TabChanged>(_handleTabChanged);
    on<CategoryRequested>(_handleCategoryRequested);
    on<CategoryProductRequested>(_handleCategoryProductRequested);
    on<ProductAddedToCart>(_handleProductAddedToCart);
    on<ProductRemovedFromCart>(_handleProductRemovedFromCart);
    on<CartCleared>(_handleCartCleared);
    on<FavoriteRemoved>(_handleProductAddedToFavorite);
    on<FavoriteToggled>(_handleProductRemovedFromFavorite);
    on<ProductSearch>(_handleSearchProduct);
  }

  final ProductRepository api = ProductRepository();
  final CategoryRepository categoryApi = CategoryRepository();

  Future<void> _handleProductRequested(
    ProductRequested event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(productStatus: StoreRequest.loading));
    try {
      final product = await api.showProduct(event.productId);
      emit(state.copyWith(
        productStatus: StoreRequest.success,
        product: product,
      ));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(productStatus: StoreRequest.error));
    }
  }

  Future<void> _handleCategoryRequested(
    CategoryRequested event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(productStatus: StoreRequest.loading));
    try {
      final categories = await categoryApi.getCategories();
      emit(state.copyWith(categories: categories));
    } catch (e) {
      emit(state.copyWith(productStatus: StoreRequest.error));
    }
  }

  Future<void> _handleCategoryProductRequested(
    CategoryProductRequested event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(productStatus: StoreRequest.loading));
    try {
      final categories = await categoryApi.showCategories(event.categoryName);
      emit(state.copyWith(
        productStatus: StoreRequest.success,
        products: categories,
      ));
    } catch (e) {
      emit(state.copyWith(productStatus: StoreRequest.error));
    }
  }

  Future<void> _handleProductAddedToCart(
    ProductAddedToCart event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(cartIds: {...state.cartIds, event.productId}));
  }

  Future<void> _handleProductRemovedFromCart(
    ProductRemovedFromCart event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(cartIds: {...state.cartIds}..remove(event.productId)));
  }

  Future<void> _handleCartCleared(
    CartCleared event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(cartIds: {}));
  }

  Future<void> _handleProductAddedToFavorite(
    FavoriteRemoved event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(favoriteIds: {...state.favoriteIds, event.productId}));
  }

  Future<void> _handleProductRemovedFromFavorite(
    FavoriteToggled event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(
        favoriteIds: {...state.favoriteIds}..remove(event.productId)));
  }

  Future<void> _handleTabChanged(
    TabChanged event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(tabIndex: event.index));
  }

  Future<void> _handleSearchProduct(
    ProductSearch event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(productStatus: StoreRequest.loading));
    try {
      final products = await api.getProducts(event.query);
      emit(state.copyWith(
        productStatus: StoreRequest.success,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(productStatus: StoreRequest.error));
    }
  }
}
