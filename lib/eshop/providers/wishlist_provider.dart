import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistProvider extends ChangeNotifier {
  final Set<int> _favoriteIds = <int>{};

  List<Product> get items =>
      dummyProducts.where((product) => _favoriteIds.contains(product.id)).toList();

  bool contains(int productId) => _favoriteIds.contains(productId);

  void toggle(Product product) {
    if (_favoriteIds.contains(product.id)) {
      _favoriteIds.remove(product.id);
    } else {
      _favoriteIds.add(product.id);
    }
    notifyListeners();
  }
}
