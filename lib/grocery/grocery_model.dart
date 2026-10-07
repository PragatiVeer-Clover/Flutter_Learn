class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final String image;
  final String description;
  final double rating;
  final String unit;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
    required this.rating,
    required this.unit,
  });
}

const List<String> categories = ['All', 'Fruits', 'Vegetables', 'Dairy', 'Bakery', 'Drinks', 'Snacks'];

const List<Product> products = [
  // Fruits
  Product(id: 1, name: 'Fresh Apples', category: 'Fruits', price: 3.99, unit: '1 kg', rating: 4.5,
      image: 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=400',
      description: 'Crisp and sweet fresh apples, perfect for snacking or baking.'),
  Product(id: 2, name: 'Bananas', category: 'Fruits', price: 1.49, unit: '6 pcs', rating: 4.3,
      image: 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400',
      description: 'Ripe yellow bananas, rich in potassium and natural energy.'),
  Product(id: 3, name: 'Strawberries', category: 'Fruits', price: 4.99, unit: '500g', rating: 4.7,
      image: 'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=400',
      description: 'Sweet and juicy strawberries, freshly picked.'),
  Product(id: 4, name: 'Oranges', category: 'Fruits', price: 2.99, unit: '1 kg', rating: 4.4,
      image: 'https://images.unsplash.com/photo-1547514701-42782101795e?w=400',
      description: 'Juicy navel oranges packed with Vitamin C.'),

  // Vegetables
  Product(id: 5, name: 'Broccoli', category: 'Vegetables', price: 2.49, unit: '1 head', rating: 4.2,
      image: 'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400',
      description: 'Fresh green broccoli, high in fiber and vitamins.'),
  Product(id: 6, name: 'Carrots', category: 'Vegetables', price: 1.99, unit: '500g', rating: 4.1,
      image: 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=400',
      description: 'Crunchy orange carrots, great for salads and cooking.'),
  Product(id: 7, name: 'Tomatoes', category: 'Vegetables', price: 2.29, unit: '500g', rating: 4.3,
      image: 'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400',
      description: 'Ripe red tomatoes, perfect for salads and sauces.'),
  Product(id: 8, name: 'Spinach', category: 'Vegetables', price: 1.79, unit: '200g', rating: 4.0,
      image: 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400',
      description: 'Fresh baby spinach leaves, rich in iron and nutrients.'),

  // Dairy
  Product(id: 9, name: 'Whole Milk', category: 'Dairy', price: 2.99, unit: '1 L', rating: 4.6,
      image: 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400',
      description: 'Fresh whole milk from local farms.'),
  Product(id: 10, name: 'Cheddar Cheese', category: 'Dairy', price: 5.49, unit: '200g', rating: 4.8,
      image: 'https://images.unsplash.com/photo-1618164436241-4473940d1f5c?w=400',
      description: 'Aged cheddar cheese with rich, sharp flavor.'),
  Product(id: 11, name: 'Greek Yogurt', category: 'Dairy', price: 3.29, unit: '500g', rating: 4.5,
      image: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400',
      description: 'Thick and creamy Greek yogurt, high in protein.'),

  // Bakery
  Product(id: 12, name: 'Sourdough Bread', category: 'Bakery', price: 4.49, unit: '1 loaf', rating: 4.7,
      image: 'https://images.unsplash.com/photo-1585478259715-876acc5be8eb?w=400',
      description: 'Freshly baked sourdough bread with crispy crust.'),
  Product(id: 13, name: 'Croissants', category: 'Bakery', price: 3.99, unit: '4 pcs', rating: 4.6,
      image: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=400',
      description: 'Buttery flaky croissants baked fresh every morning.'),

  // Drinks
  Product(id: 14, name: 'Orange Juice', category: 'Drinks', price: 3.49, unit: '1 L', rating: 4.4,
      image: 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=400',
      description: 'Freshly squeezed orange juice, no added sugar.'),
  Product(id: 15, name: 'Sparkling Water', category: 'Drinks', price: 1.29, unit: '500ml', rating: 4.2,
      image: 'https://images.unsplash.com/photo-1523362628745-0c100150b504?w=400',
      description: 'Refreshing sparkling mineral water.'),

  // Snacks
  Product(id: 16, name: 'Mixed Nuts', category: 'Snacks', price: 6.99, unit: '300g', rating: 4.6,
      image: 'https://images.unsplash.com/photo-1599599810769-bcde5a160d32?w=400',
      description: 'Premium mix of almonds, cashews, walnuts and pecans.'),
  Product(id: 17, name: 'Dark Chocolate', category: 'Snacks', price: 3.79, unit: '100g', rating: 4.8,
      image: 'https://images.unsplash.com/photo-1606312619070-d48b4c652a52?w=400',
      description: '70% dark chocolate, rich in antioxidants.'),
];
