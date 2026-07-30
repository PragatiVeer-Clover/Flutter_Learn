import 'package:flutter_test/flutter_test.dart';
import 'package:demo/eshop/models/product.dart';
import 'package:demo/eshop/providers/wishlist_provider.dart';

void main() {
  group('WishlistProvider', () {
    test('toggles products and tracks favorites', () {
      final provider = WishlistProvider();
      final product = dummyProducts.first;

      expect(provider.contains(product.id), isFalse);

      provider.toggle(product);
      expect(provider.contains(product.id), isTrue);
      expect(provider.items.length, 1);

      provider.toggle(product);
      expect(provider.contains(product.id), isFalse);
      expect(provider.items, isEmpty);
    });

    test('keeps each product unique in the wishlist', () {
      final provider = WishlistProvider();
      final product = dummyProducts.first;

      provider.toggle(product);
      provider.toggle(product);
      provider.toggle(dummyProducts[1]);

      expect(provider.items.length, 2);
      expect(provider.contains(product.id), isFalse);
      expect(provider.contains(dummyProducts[1].id), isTrue);
    });
  });
}
