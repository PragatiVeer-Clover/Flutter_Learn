import 'package:flutter/material.dart';
import 'order_model.dart';
import 'billing_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Color _statusColor(String status) {
    switch (status) {
      case 'Preparing':
        return Colors.orangeAccent;
      case 'On the way':
        return Colors.blueAccent;
      case 'Delivered':
        return Colors.greenAccent;
      default:
        return Colors.grey;
    }
  }

  double get _total =>
      orders.fold(0, (sum, o) => sum + o.totalPrice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E1E1E),
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Icon(Icons.receipt_long, color: Colors.orangeAccent),
            SizedBox(width: 8),
            Text('My Orders',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          if (orders.isNotEmpty) ...[  
            TextButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BillingPage()),
              ).then((_) => setState(() {})),
              icon: const Icon(Icons.payment, color: Colors.orangeAccent),
              label: const Text('Pay Bill', style: TextStyle(color: Colors.orangeAccent)),
            ),
            TextButton.icon(
              onPressed: () => setState(() => orders.clear()),
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              label: const Text('Clear All', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: orders.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long,
                          size: 80, color: Colors.grey[700]),
                      SizedBox(height: 16),
                      Text('No orders yet',
                          style:
                              TextStyle(color: Colors.grey, fontSize: 18)),
                      SizedBox(height: 8),
                      Text('Go back and order something delicious!',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14)),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: orders.length,
                        itemBuilder: (context, i) {
                          final order = orders[i];
                          return Container(
                            margin: EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                // Recipe image
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    order.recipe.image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey[800],
                                      child: Icon(Icons.image,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),

                                // Order info
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(order.recipe.title,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        SizedBox(height: 4),
                                        Text(
                                            'Qty: ${order.quantity}  •  \$${order.totalPrice.toStringAsFixed(2)}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13)),
                                        SizedBox(height: 4),
                                        Text(
                                            '${order.orderedAt.hour}:${order.orderedAt.minute.toString().padLeft(2, '0')}',
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ),

                                // Status
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: _statusColor(order.status)
                                              .withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(order.status,
                                            style: TextStyle(
                                                color:
                                                    _statusColor(order.status),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(height: 8),
                                      // Change status dropdown
                                      DropdownButton<String>(
                                        value: order.status,
                                        dropdownColor: Color(0xFF1E1E1E),
                                        underline: SizedBox(),
                                        icon: Icon(Icons.arrow_drop_down,
                                            color: Colors.grey, size: 16),
                                        items: ['Preparing', 'On the way', 'Delivered']
                                            .map((s) => DropdownMenuItem(
                                                  value: s,
                                                  child: Text(s,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12)),
                                                ))
                                            .toList(),
                                        onChanged: (val) {
                                          if (val != null)
                                            setState(
                                                () => order.status = val);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // Total bar
                    Container(
                      padding: EdgeInsets.all(20),
                      color: Color(0xFF1E1E1E),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${orders.length} order(s)',
                              style: TextStyle(color: Colors.grey)),
                          Text(
                            'Total: \$${_total.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
