
abstract class StoreEvent {
  const StoreEvent();
}

class ProductRequested extends StoreEvent {  
}

class CategoryRequested extends StoreEvent {
}

class CategoryProductRequested extends StoreEvent {
  String categoryName;
  
  CategoryProductRequested(this.categoryName);
}
class ProductAddedToCart extends StoreEvent {
  final int productId;

  const ProductAddedToCart(this.productId);
}

class ProductRemovedFromCart extends StoreEvent {
  final int productId;

  const ProductRemovedFromCart(this.productId);
}

class CartCleared extends StoreEvent {
  const CartCleared();
}

class FavoriteToggled extends StoreEvent {
  final int productId;

  const FavoriteToggled(this.productId);
}

class FavoriteRemoved extends StoreEvent {
  final int productId;

  const FavoriteRemoved(this.productId);
}




