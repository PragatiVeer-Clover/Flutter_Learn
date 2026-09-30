import 'package:flutter/material.dart';
import 'recipe_data.dart';
import 'order_model.dart';
import 'orders_page.dart';
import 'billing_page.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailPage({super.key, required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  int _quantity = 1;

  void _placeOrder() {
    orders.add(Order(
      recipe: widget.recipe,
      quantity: _quantity,
      orderedAt: DateTime.now(),
    ));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.greenAccent),
            SizedBox(width: 8),
            Text('Order Placed!', style: TextStyle(color: Colors.white)),
          ],
        ),
        content: Text(
          '${_quantity}x ${widget.recipe.title}\nTotal: \$${(widget.recipe.price * _quantity).toStringAsFixed(2)}',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Continue', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OrdersPage()));
            },
            child: Text('View Orders', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const BillingPage()));
            },
            child: Text('Pay Now', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: Color(0xFF1E1E1E),
                iconTheme: IconThemeData(color: Colors.white),
                actions: [
                  IconButton(
                    icon: Icon(Icons.receipt_long, color: Colors.white),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => OrdersPage())),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget.recipe.title,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(widget.recipe.image, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Container(color: Colors.grey[800])),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black87],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stats row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _statItem(Icons.timer, '${widget.recipe.time} min', 'Time'),
                          _statItem(Icons.people, '${widget.recipe.servings}', 'Servings'),
                          _statItem(Icons.bar_chart, widget.recipe.difficulty, 'Difficulty'),
                          _statItem(Icons.attach_money,
                              '\$${widget.recipe.price.toStringAsFixed(2)}', 'Price'),
                        ],
                      ),
                      SizedBox(height: 30),

                      // Order section
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            // Quantity selector
                            Text('Quantity:',
                                style: TextStyle(color: Colors.white, fontSize: 16)),
                            SizedBox(width: 16),
                            IconButton(
                              onPressed: () {
                                if (_quantity > 1)
                                  setState(() => _quantity--);
                              },
                              icon: Icon(Icons.remove_circle_outline,
                                  color: Colors.orangeAccent),
                            ),
                            Text('$_quantity',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () => setState(() => _quantity++),
                              icon: Icon(Icons.add_circle_outline,
                                  color: Colors.orangeAccent),
                            ),
                            Spacer(),
                            // Total price
                            Text(
                              '\$${(widget.recipe.price * _quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // Order button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _placeOrder,
                          icon: Icon(Icons.shopping_cart, color: Colors.black),
                          label: Text('Order Now',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Ingredients
                      _sectionTitle('Ingredients'),
                      SizedBox(height: 12),
                      ...widget.recipe.ingredients.map((ing) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(ing,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          )),
                      SizedBox(height: 30),

                      // Steps
                      _sectionTitle('Instructions'),
                      SizedBox(height: 12),
                      ...widget.recipe.steps.asMap().entries.map((entry) => Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text('${entry.key + 1}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Text(entry.value,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 15,
                                            height: 1.5)),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.orangeAccent, size: 24),
        SizedBox(height: 6),
        Text(value,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title,
        style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold));
  }
}
