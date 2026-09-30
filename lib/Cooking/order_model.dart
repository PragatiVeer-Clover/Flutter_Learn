import 'recipe_data.dart';

class Order {
  final Recipe recipe;
  final int quantity;
  final DateTime orderedAt;
  String status;
  bool isPaid;

  Order({
    required this.recipe,
    required this.quantity,
    required this.orderedAt,
    this.status = 'Preparing',
    this.isPaid = false,
  });

  double get totalPrice => quantity * recipe.price;
}

List<Order> orders = [];
