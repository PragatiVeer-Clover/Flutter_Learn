import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'grocery_model.dart';
import 'cart_page.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class GroceryDetailPage extends StatelessWidget {
  final Product product;
  const GroceryDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        final qty = cartState.quantityOf(product);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
            title: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://images.unsplash.com/photo-1542838132-92c53300491e?w=60&h=60&fit=crop',
                  width: 32, height: 32, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.storefront, color: Colors.green),
                ),
              ),
              const SizedBox(width: 10),
              Text(product.category, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            ]),
            actions: [
              Stack(children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage())),
                ),
                if (cartState.count > 0)
                  Positioned(
                    right: 6, top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                      child: Text('${cartState.count}',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ]),
              const SizedBox(width: 8),
            ],
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(product.image, width: double.infinity, height: 280, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                            height: 280,
                            color: isDark ? const Color(0xFF1a1f3c) : Colors.grey[100],
                            child: const Icon(Icons.image, size: 60, color: Colors.grey))),
                  ),
                  const SizedBox(height: 20),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(child: Text(product.name,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                    Row(children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(product.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ]),
                  ]),
                  const SizedBox(height: 6),
                  Text(product.unit, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),

                  Text('About this product',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                  const SizedBox(height: 8),
                  Text(product.description,
                      style: TextStyle(color: isDark ? Colors.white70 : Colors.grey[700], height: 1.6, fontSize: 15)),
                  const SizedBox(height: 28),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0a0d2c) : Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Text('Price', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Text('\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.green, fontSize: 26, fontWeight: FontWeight.bold)),
                      ]),
                      const Spacer(),
                      if (qty > 0) ...[
                        Row(children: [
                          _qtyBtn(Icons.remove, () => context.read<CartBloc>().add(RemoveFromCart(product)), Colors.red),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('$qty', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          _qtyBtn(Icons.add, () => context.read<CartBloc>().add(AddToCart(product)), Colors.green),
                        ]),
                      ] else
                        ElevatedButton.icon(
                          onPressed: () => context.read<CartBloc>().add(AddToCart(product)),
                          icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                          label: const Text('Add to Cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                    ]),
                  ),
                  const SizedBox(height: 16),

                  if (qty > 0)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage())),
                        icon: const Icon(Icons.shopping_cart, color: Colors.white),
                        label: Text('View Cart (\$${(product.price * qty).toStringAsFixed(2)})',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap, Color color) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: color, size: 18),
        ),
      );
}
