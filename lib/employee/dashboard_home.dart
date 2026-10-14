import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/darkthemeProvider.dart';
import 'employees_page.dart';
import 'attendance_page.dart';
import 'leave_page.dart';
import 'payroll_page.dart';
import 'performance_page.dart';
import 'profile_page.dart';
import 'overview_page.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});
  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  int _selectedIndex = 0;
  bool _sidebarExpanded = true;

  final List<_NavItem> _navItems = const [
    _NavItem(Icons.dashboard_rounded, 'Overview'),
    _NavItem(Icons.people_rounded, 'Employees'),
    _NavItem(Icons.calendar_today_rounded, 'Attendance'),
    _NavItem(Icons.beach_access_rounded, 'Leave'),
    _NavItem(Icons.payments_rounded, 'Payroll'),
    _NavItem(Icons.bar_chart_rounded, 'Performance'),
    _NavItem(Icons.person_rounded, 'Profile'),
  ];

  final List<Widget> _pages = const [
    OverviewPage(),
    EmployeesPage(),
    AttendancePage(),
    LeavePage(),
    PayrollPage(),
    PerformancePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Darkthemeprovider>(context);
    final isDark = themeProvider.isDarkTheme;
    final sidebarBg = isDark ? const Color(0xFF0D1117) : const Color(0xFF1E293B);
    final mainBg = isDark ? const Color(0xFF0A0F1E) : const Color(0xFFF1F5F9);

    return Scaffold(
      backgroundColor: mainBg,
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: _sidebarExpanded ? 220 : 68,
            color: sidebarBg,
            child: Column(
              children: [
                const SizedBox(height: 24),
                // Logo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.business_center_rounded, color: Colors.white, size: 22),
                      ),
                      if (_sidebarExpanded) ...[
                        const SizedBox(width: 10),
                        const Text('WorkSpace', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Nav items
                Expanded(
                  child: ListView.builder(
                    itemCount: _navItems.length,
                    itemBuilder: (context, i) {
                      final selected = _selectedIndex == i;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedIndex = i),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: selected ? const Color(0xFF6366F1).withOpacity(0.2) : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: selected ? Border.all(color: const Color(0xFF6366F1).withOpacity(0.4)) : null,
                          ),
                          child: Row(
                            children: [
                              Icon(_navItems[i].icon, color: selected ? const Color(0xFF818CF8) : Colors.white54, size: 20),
                              if (_sidebarExpanded) ...[
                                const SizedBox(width: 12),
                                Text(_navItems[i].label, style: TextStyle(color: selected ? const Color(0xFF818CF8) : Colors.white70, fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Theme toggle
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: () => themeProvider.isDarkTheme = !isDark,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: Colors.white70, size: 20),
                          if (_sidebarExpanded) ...[
                            const SizedBox(width: 10),
                            Text(isDark ? 'Light Mode' : 'Dark Mode', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Column(
              children: [
                // Top bar
                Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0D1117) : Colors.white,
                    border: Border(bottom: BorderSide(color: isDark ? Colors.white10 : Colors.black12)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu_rounded, color: isDark ? Colors.white70 : Colors.black54),
                        onPressed: () => setState(() => _sidebarExpanded = !_sidebarExpanded),
                      ),
                      const SizedBox(width: 8),
                      Text(_navItems[_selectedIndex].label,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                      const Spacer(),
                      // Search
                      Container(
                        width: 220,
                        height: 38,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 13),
                            prefixIcon: Icon(Icons.search, size: 18, color: isDark ? Colors.white38 : Colors.black38),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Notification
                      Stack(
                        children: [
                          IconButton(
                            icon: Icon(Icons.notifications_rounded, color: isDark ? Colors.white70 : Colors.black54),
                            onPressed: () {},
                          ),
                          Positioned(
                            right: 8, top: 8,
                            child: Container(
                              width: 8, height: 8,
                              decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      // Avatar
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&h=100&fit=crop'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                // Page content
                Expanded(child: _pages[_selectedIndex]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}
