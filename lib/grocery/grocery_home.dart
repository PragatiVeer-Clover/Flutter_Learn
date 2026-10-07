import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'grocery_model.dart';
import 'grocery_detail.dart';
import 'cart_page.dart';
import 'settings_page.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class GroceryHome extends StatefulWidget {
  const GroceryHome({super.key});

  @override
  State<GroceryHome> createState() => _GroceryHomeState();
}

class _GroceryHomeState extends State<GroceryHome> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final _searchCtrl = TextEditingController();

  List<Product> get _filtered => products.where((p) {
        final matchCat = _selectedCategory == 'All' || p.category == _selectedCategory;
        final matchSearch = p.name.toLowerCase().contains(_searchQuery.toLowerCase());
        return matchCat && matchSearch;
      }).toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: theme.scaffoldBackgroundColor,
            title: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://images.unsplash.com/photo-1542838132-92c53300491e?w=60&h=60&fit=crop',
                  width: 36, height: 36, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.storefront, color: Colors.green, size: 36),
                ),
              ),
              const SizedBox(width: 10),
              const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('GroceryMart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                Text('Fresh & Fast Delivery', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ]),
            ]),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())),
              ),
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
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(children: [
                // Hero Banner
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1506617420156-8e4536971650?w=1100&h=160&fit=crop',
                        width: double.infinity, height: 140, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 140, color: Colors.green.withOpacity(0.2),
                          child: const Center(child: Icon(Icons.local_grocery_store, size: 60, color: Colors.green)),
                        ),
                      ),
                      Container(height: 140,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colors.black.withOpacity(0.55), Colors.transparent]),
                          )),
                      const Positioned(left: 20, top: 30,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Fresh Groceries', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Delivered to your door 🚚', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        ]),
                      ),
                      Positioned(right: 16, top: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                          child: const Text('Shop Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 12),

                // Search
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    decoration: InputDecoration(
                      hintText: 'Search groceries...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close, color: Colors.grey),
                              onPressed: () { _searchCtrl.clear(); setState(() => _searchQuery = ''); })
                          : null,
                      filled: true,
                      fillColor: isDark ? const Color(0xFF1a1f3c) : Colors.grey[100],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Categories
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: categories.length,
                    itemBuilder: (_, i) {
                      final cat = categories[i];
                      final selected = cat == _selectedCategory;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: selected ? Colors.green : (isDark ? const Color(0xFF1a1f3c) : Colors.grey[100]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(cat, style: TextStyle(
                              color: selected ? Colors.white : Colors.grey,
                              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 13)),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Grid
                Expanded(
                  child: _filtered.isEmpty
                      ? const Center(child: Text('No products found', style: TextStyle(color: Colors.grey)))
                      : LayoutBuilder(builder: (context, constraints) {
                          final cols = constraints.maxWidth > 900 ? 4 : constraints.maxWidth > 600 ? 3 : 2;
                          return GridView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: cols, childAspectRatio: 0.72,
                              crossAxisSpacing: 12, mainAxisSpacing: 12,
                            ),
                            itemCount: _filtered.length,
                            itemBuilder: (_, i) => _ProductCard(product: _filtered[i], cartState: cartState),
                          );
                        }),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final CartState cartState;
  const _ProductCard({required this.product, required this.cartState});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final inCart = cartState.contains(product);

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GroceryDetailPage(product: product))),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0a0d2c) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(product.image, width: double.infinity, fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) => progress == null ? child
                      : Container(color: isDark ? const Color(0xFF1a1f3c) : Colors.grey[100],
                          child: const Center(child: CircularProgressIndicator(color: Colors.green, strokeWidth: 2))),
                  errorBuilder: (_, __, ___) => Container(
                      color: isDark ? const Color(0xFF1a1f3c) : Colors.grey[100],
                      child: const Icon(Icons.image, color: Colors.grey, size: 40))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 2),
              Text(product.unit, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              const SizedBox(height: 6),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14)),
                GestureDetector(
                  onTap: () => context.read<CartBloc>().add(AddToCart(product)),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: inCart ? Colors.green : Colors.green.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(inCart ? Icons.check : Icons.add,
                        color: inCart ? Colors.white : Colors.green, size: 16),
                  ),
                ),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}
