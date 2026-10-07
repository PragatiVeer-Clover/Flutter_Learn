import 'package:flutter/material.dart';
import 'grocery_model.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
  double get total => product.price * quantity;
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  int get count => _items.fold(0, (s, i) => s + i.quantity);
  double get total => _items.fold(0, (s, i) => s + i.total);

  void add(Product p) {
    final idx = _items.indexWhere((i) => i.product.id == p.id);
    if (idx >= 0) {
      _items[idx].quantity++;
    } else {
      _items.add(CartItem(product: p));
    }
    notifyListeners();
  }

  void remove(Product p) {
    final idx = _items.indexWhere((i) => i.product.id == p.id);
    if (idx >= 0) {
      if (_items[idx].quantity > 1) {
        _items[idx].quantity--;
      } else {
        _items.removeAt(idx);
      }
      notifyListeners();
    }
  }

  void delete(Product p) {
    _items.removeWhere((i) => i.product.id == p.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  bool contains(Product p) => _items.any((i) => i.product.id == p.id);
  int quantityOf(Product p) {
    final idx = _items.indexWhere((i) => i.product.id == p.id);
    return idx >= 0 ? _items[idx].quantity : 0;
  }
}
