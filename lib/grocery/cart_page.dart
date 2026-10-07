import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
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
              const Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
            actions: [
              if (cartState.items.isNotEmpty)
                TextButton.icon(
                  onPressed: () => context.read<CartBloc>().add(ClearCart()),
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  label: const Text('Clear', style: TextStyle(color: Colors.redAccent)),
                ),
            ],
          ),
          body: cartState.items.isEmpty
              ? Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1584473457406-6240486418e9?w=300&h=220&fit=crop',
                        width: 220, height: 180, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Your cart is empty',
                        style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Add some fresh groceries!', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ]),
                )
              : Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Column(children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: cartState.items.length,
                          itemBuilder: (_, i) {
                            final item = cartState.items[i];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF0a0d2c) : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
                              ),
                              child: Row(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(item.product.image,
                                      width: 70, height: 70, fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                          width: 70, height: 70,
                                          color: Colors.grey[200],
                                          child: const Icon(Icons.image, color: Colors.grey))),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(item.product.name,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    Text(item.product.unit,
                                        style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                    const SizedBox(height: 4),
                                    Text('\$${item.product.price.toStringAsFixed(2)} each',
                                        style: const TextStyle(color: Colors.green, fontSize: 12)),
                                  ]),
                                ),
                                Column(children: [
                                  Row(children: [
                                    _qtyBtn(Icons.remove,
                                        () => context.read<CartBloc>().add(RemoveFromCart(item.product)),
                                        Colors.red),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Text('${item.quantity}',
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    ),
                                    _qtyBtn(Icons.add,
                                        () => context.read<CartBloc>().add(AddToCart(item.product)),
                                        Colors.green),
                                  ]),
                                  const SizedBox(height: 6),
                                  Text('\$${item.total.toStringAsFixed(2)}',
                                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                ]),
                              ]),
                            );
                          },
                        ),
                      ),

                      // Summary
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF0a0d2c) : Colors.white,
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, -2))],
                        ),
                        child: Column(children: [
                          _summaryRow('Subtotal', '\$${cartState.total.toStringAsFixed(2)}'),
                          _summaryRow('Delivery Fee', '\$2.99'),
                          _summaryRow('Tax (8%)', '\$${(cartState.total * 0.08).toStringAsFixed(2)}'),
                          const Divider(height: 20),
                          _summaryRow('Total',
                              '\$${(cartState.total + 2.99 + cartState.total * 0.08).toStringAsFixed(2)}',
                              highlight: true),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.read<CartBloc>().add(ClearCart());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('🎉 Order placed successfully!'),
                                      backgroundColor: Colors.green),
                                );
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.check_circle, color: Colors.white),
                              label: const Text('Place Order',
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                ),
        );
      },
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap, Color color) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
          child: Icon(icon, color: color, size: 16),
        ),
      );

  Widget _summaryRow(String label, String value, {bool highlight = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: TextStyle(
              color: highlight ? null : Colors.grey,
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              fontSize: highlight ? 16 : 14)),
          Text(value, style: TextStyle(
              color: highlight ? Colors.green : null,
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              fontSize: highlight ? 18 : 14)),
        ]),
      );
}
