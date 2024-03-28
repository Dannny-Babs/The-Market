import 'package:bloc/bloc.dart';
import 'package:the_market/data/repositories/product_repository.dart';
import 'package:the_market/utils/bloc.dart';



class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(const StoreState()) {
    on<ProductRequested>(_handleProductRequested);
    on<ProductAddedToCart>(_handleProductAddedToCart);
    on<ProductRemovedFromCart>(_handleProductRemovedFromCart);
    on<CartCleared>(_handleCartCleared);
    on<FavoriteRemoved>(_handleProductAddedToFavorite);
    on<FavoriteToggled>(_handleProductRemovedFromFavorite);
  }

  final ProductRepository api = ProductRepository();

  Future<void> _handleProductRequested(
    ProductRequested event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(productStatus: StoreRequest.loading));
    try {
      final products = await api.getProducts();
      emit(state.copyWith(
        productStatus: StoreRequest.success,
        products: products, 
      ));
    } catch (e) {
      emit(state.copyWith(productStatus: StoreRequest.error));
    }
  }

  Future<void> _handleProductAddedToCart(
    ProductAddedToCart event,
    Emitter<StoreState> emit,
  ) async {
      emit(state.copyWith(cartIds: {...state.cartIds, event.productId} ));
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
      emit(state.copyWith(favoriteIds: {...state.favoriteIds, event.productId} ));
  }

  Future<void> _handleProductRemovedFromFavorite(
    FavoriteToggled event,
    Emitter<StoreState> emit,
  ) async {
      emit(state.copyWith(favoriteIds: {...state.favoriteIds}..remove(event.productId)));
  }


}
