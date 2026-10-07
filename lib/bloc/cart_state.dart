import '../grocery/grocery_model.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
  double get total => product.price * quantity;
}

class CartState {
  final List<CartItem> items;

  const CartState({this.items = const []});

  CartState copyWith(List<CartItem> items) => CartState(items: items);

  int get count => items.fold(0, (s, i) => s + i.quantity);
  double get total => items.fold(0, (s, i) => s + i.total);

  bool contains(Product p) => items.any((i) => i.product.id == p.id);
  int quantityOf(Product p) {
    final idx = items.indexWhere((i) => i.product.id == p.id);
    return idx >= 0 ? items[idx].quantity : 0;
  }
}
