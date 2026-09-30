import 'package:flutter/material.dart';
import 'order_model.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  double walletBalance = 500.00;
  bool _paid = false;

  List<Order> get _unpaid => orders.where((o) => !o.isPaid).toList();
  double get _total => _unpaid.fold(0, (s, o) => s + o.totalPrice);

  void _pay() {
    if (walletBalance < _total) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Insufficient wallet balance!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    setState(() {
      walletBalance -= _total;
      for (final o in _unpaid) {
        o.isPaid = true;
      }
      _paid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Row(
          children: [
            Icon(Icons.account_balance_wallet, color: Colors.orangeAccent),
            SizedBox(width: 8),
            Text('Billing', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: _paid ? _successView() : _billingView(),
        ),
      ),
    );
  }

  Widget _billingView() {
    if (_unpaid.isEmpty) {
      return const Center(
        child: Text('No pending orders to bill.', style: TextStyle(color: Colors.grey, fontSize: 16)),
      );
    }

    return Column(
      children: [
        // Wallet card
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2C2C2C), Color(0xFF1E1E1E)],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.orangeAccent.withOpacity(0.4)),
          ),
          child: Row(
            children: [
              const Icon(Icons.account_balance_wallet, color: Colors.orangeAccent, size: 36),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Wallet Balance', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  Text(
                    '\$${walletBalance.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Order items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _unpaid.length,
            itemBuilder: (context, i) {
              final o = _unpaid[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(o.recipe.image,
                          width: 60, height: 60, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Container(width: 60, height: 60, color: Colors.grey[800])),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(o.recipe.title,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text('Qty: ${o.quantity}  •  \$${o.recipe.price.toStringAsFixed(2)} each',
                              style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                    Text('\$${o.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              );
            },
          ),
        ),

        // Bill summary + pay
        Container(
          padding: const EdgeInsets.all(20),
          color: const Color(0xFF1E1E1E),
          child: Column(
            children: [
              _billRow('Subtotal', '\$${_total.toStringAsFixed(2)}'),
              _billRow('Delivery Fee', '\$2.99'),
              _billRow('Tax (8%)', '\$${(_total * 0.08).toStringAsFixed(2)}'),
              const Divider(color: Colors.grey, height: 24),
              _billRow(
                'Total',
                '\$${(_total + 2.99 + _total * 0.08).toStringAsFixed(2)}',
                highlight: true,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _pay,
                  icon: const Icon(Icons.payment, color: Colors.black),
                  label: const Text('Pay with Wallet',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _successView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle_rounded, color: Colors.greenAccent, size: 80),
          ),
          const SizedBox(height: 24),
          const Text('Payment Successful!',
              style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Your order has been confirmed 🎉',
              style: TextStyle(color: Colors.grey[400], fontSize: 15)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Remaining Balance: \$${walletBalance.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.orangeAccent, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Back to Orders', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _billRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: highlight ? Colors.white : Colors.grey,
                  fontSize: highlight ? 16 : 14,
                  fontWeight: highlight ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  color: highlight ? Colors.orangeAccent : Colors.white,
                  fontSize: highlight ? 18 : 14,
                  fontWeight: highlight ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
