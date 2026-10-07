import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/darkthemeProvider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Darkthemeprovider>(context);
    final isDark = themeProvider.isDarkTheme;
    final theme = Theme.of(context);

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
          const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        ]),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [

              // Profile card with avatar
              _settingCard(
                isDark: isDark,
                child: Row(children: [
                  // Profile avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&h=100&fit=crop',
                      width: 64, height: 64, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.green.withOpacity(0.2),
                        child: const Icon(Icons.person, color: Colors.green, size: 32),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Clover User', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Text('clover@grocerymart.com', style: TextStyle(color: Colors.grey, fontSize: 13)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(color: Colors.green.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                      child: const Text('Premium Member', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ]),
                ]),
              ),
              const SizedBox(height: 20),

              // App banner image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1488459716781-31db52582fe9?w=600&h=120&fit=crop',
                    width: double.infinity, height: 110, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 110, color: Colors.green.withOpacity(0.2),
                      child: const Center(child: Icon(Icons.local_grocery_store, size: 50, color: Colors.green)),
                    ),
                  ),
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.black.withOpacity(0.5), Colors.transparent]),
                    ),
                  ),
                  const Positioned(
                    left: 16, top: 20,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('GroceryMart', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('Fresh • Fast • Reliable', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ]),
                  ),
                ]),
              ),
              const SizedBox(height: 20),

              // Appearance
              _sectionTitle('Appearance'),
              const SizedBox(height: 12),
              _settingCard(
                isDark: isDark,
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.amber.withOpacity(0.15) : Colors.blueGrey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(isDark ? Icons.dark_mode : Icons.light_mode,
                        color: isDark ? Colors.amber : Colors.blueGrey),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(isDark ? 'Dark theme is ON' : 'Light theme is ON',
                          style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ]),
                  ),
                  Switch(value: isDark, activeColor: Colors.green, onChanged: (val) => themeProvider.isDarkTheme = val),
                ]),
              ),
              const SizedBox(height: 12),

              // Theme preview
              _settingCard(
                isDark: isDark,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Theme Preview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => themeProvider.isDarkTheme = false,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: !isDark ? Colors.green : Colors.grey.withOpacity(0.3), width: !isDark ? 2 : 1),
                          ),
                          child: Column(children: [
                            Image.network('https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=80&h=50&fit=crop',
                                width: 80, height: 50, fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(Icons.light_mode, color: Colors.orange)),
                            const SizedBox(height: 6),
                            const Text('Light', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            if (!isDark) const Icon(Icons.check_circle, color: Colors.green, size: 16),
                          ]),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => themeProvider.isDarkTheme = true,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00001a),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: isDark ? Colors.green : Colors.grey.withOpacity(0.3), width: isDark ? 2 : 1),
                          ),
                          child: Column(children: [
                            Image.network('https://images.unsplash.com/photo-1557683316-973673baf926?w=80&h=50&fit=crop',
                                width: 80, height: 50, fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(Icons.dark_mode, color: Colors.amber)),
                            const SizedBox(height: 6),
                            const Text('Dark', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            if (isDark) const Icon(Icons.check_circle, color: Colors.green, size: 16),
                          ]),
                        ),
                      ),
                    ),
                  ]),
                ]),
              ),
              const SizedBox(height: 24),

              // About
              _sectionTitle('About'),
              const SizedBox(height: 12),
              _settingCard(
                isDark: isDark,
                child: Column(children: [
                  _infoRow(Icons.storefront, 'App Name', 'GroceryMart', isDark),
                  const Divider(height: 20),
                  _infoRow(Icons.info_outline, 'Version', '1.0.0', isDark),
                  const Divider(height: 20),
                  _infoRow(Icons.local_shipping, 'Delivery', 'Fast & Fresh', isDark),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Text(title,
      style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1));

  Widget _settingCard({required Widget child, required bool isDark}) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0a0d2c) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
        ),
        child: child,
      );

  Widget _infoRow(IconData icon, String label, String value, bool isDark) => Row(children: [
        Icon(icon, color: Colors.green, size: 20),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const Spacer(),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ]);
}
