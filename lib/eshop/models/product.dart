class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final double rating;
  final int reviews;
  final String description;
  final bool isNew;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.description,
    this.isNew = false,
  });

  bool get hasDiscount => originalPrice != null && originalPrice! > price;
  int get discountPercent => hasDiscount
      ? (((originalPrice! - price) / originalPrice!) * 100).round()
      : 0;
}

final List<Product> dummyProducts = [
  const Product(
    id: 1,
    name: 'Wireless Headphones',
    category: 'Electronics',
    price: 79.99,
    originalPrice: 129.99,
    imageUrl: 'assets/images/headphones.jpg',
    rating: 4.5,
    reviews: 128,
    isNew: true,
    description:
        'Premium wireless headphones with active noise cancellation, 30-hour battery life, and crystal-clear sound quality.',
  ),
  const Product(
    id: 2,
    name: 'Running Sneakers',
    category: 'Fashion',
    price: 59.99,
    originalPrice: 89.99,
    imageUrl: 'assets/images/sneakers.jpg',
    rating: 4.3,
    reviews: 95,
    description:
        'Lightweight and breathable running shoes with cushioned sole for maximum comfort during long runs.',
  ),
  const Product(
    id: 3,
    name: 'Smart Watch',
    category: 'Electronics',
    price: 199.99,
    imageUrl: 'assets/images/smartwatch.jpg',
    rating: 4.7,
    reviews: 214,
    isNew: true,
    description:
        'Feature-packed smartwatch with health tracking, GPS, and 7-day battery life.',
  ),
  const Product(
    id: 4,
    name: 'Leather Backpack',
    category: 'Fashion',
    price: 89.99,
    originalPrice: 119.99,
    imageUrl: 'assets/images/backpack.jpg',
    rating: 4.4,
    reviews: 67,
    description:
        'Genuine leather backpack with laptop compartment and multiple pockets for everyday use.',
  ),
  const Product(
    id: 5,
    name: 'Coffee Maker',
    category: 'Home',
    price: 49.99,
    imageUrl: 'assets/images/coffee.jpg',
    rating: 4.2,
    reviews: 183,
    description:
        'Programmable coffee maker with 12-cup capacity, built-in grinder, and keep-warm function.',
  ),
  const Product(
    id: 6,
    name: 'Yoga Mat',
    category: 'Sports',
    price: 29.99,
    originalPrice: 44.99,
    imageUrl: 'assets/images/yogamat.jpg',
    rating: 4.6,
    reviews: 312,
    description:
        'Non-slip eco-friendly yoga mat with alignment lines, 6mm thickness for joint support.',
  ),
  const Product(
    id: 7,
    name: 'Desk Lamp',
    category: 'Home',
    price: 34.99,
    imageUrl: 'assets/images/desklamp.jpg',
    rating: 4.1,
    reviews: 54,
    isNew: true,
    description:
        'LED desk lamp with adjustable brightness, color temperature control, and USB charging port.',
  ),
  const Product(
    id: 8,
    name: 'Sunglasses',
    category: 'Fashion',
    price: 44.99,
    originalPrice: 69.99,
    imageUrl: 'assets/images/sunglasses.jpg',
    rating: 4.0,
    reviews: 88,
    description:
        'Polarized UV400 sunglasses with lightweight frame, perfect for outdoor activities.',
  ),
];

const List<String> categories = [
  'All',
  'Electronics',
  'Fashion',
  'Home',
  'Sports',
];
