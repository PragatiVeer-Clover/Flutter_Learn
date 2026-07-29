import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final _controller = PageController();

  final _banners = const [
    _BannerData(
      title: 'Summer Sale',
      subtitle: 'Up to 50% off on Electronics',
      cta: 'Shop Now',
      gradient: [Color(0xFF2563EB), Color(0xFF7C3AED)],
      icon: Icons.headphones,
    ),
    _BannerData(
      title: 'New Arrivals',
      subtitle: 'Fresh styles just dropped',
      cta: 'Explore',
      gradient: [Color(0xFF059669), Color(0xFF0891B2)],
      icon: Icons.local_offer_outlined,
    ),
    _BannerData(
      title: 'Free Shipping',
      subtitle: 'On all orders above \$50',
      cta: 'Learn More',
      gradient: [Color(0xFFDC2626), Color(0xFFEA580C)],
      icon: Icons.local_shipping_outlined,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            itemCount: _banners.length,
            itemBuilder: (context, i) => _BannerCard(data: _banners[i]),
          ),
        ),
        const SizedBox(height: 12),
        SmoothPageIndicator(
          controller: _controller,
          count: _banners.length,
          effect: const WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Color(0xFF2563EB),
            dotColor: Color(0xFFD1D5DB),
          ),
        ),
      ],
    );
  }
}

class _BannerData {
  final String title, subtitle, cta;
  final List<Color> gradient;
  final IconData icon;
  const _BannerData({
    required this.title,
    required this.subtitle,
    required this.cta,
    required this.gradient,
    required this.icon,
  });
}

class _BannerCard extends StatelessWidget {
  final _BannerData data;
  const _BannerCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: data.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(28),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    data.cta,
                    style: TextStyle(
                      color: data.gradient.first,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(data.icon, size: 80, color: Colors.white.withValues(alpha: 0.2)),
        ],
      ),
    );
  }
}
