import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/darkthemeProvider.dart';
import 'employee_model.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<Darkthemeprovider>(context).isDarkTheme;
    final cardBg = isDark ? const Color(0xFF0D1117) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.white54 : Colors.black45;

    final active = employees.where((e) => e.status == 'Active').length;
    final onLeave = employees.where((e) => e.status == 'On Leave').length;
    final remote = employees.where((e) => e.status == 'Remote').length;
    final avgPerf = (employees.map((e) => e.performanceScore).reduce((a, b) => a + b) / employees.length).round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome back, Admin 👋', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 4),
          Text("Here's what's happening today", style: TextStyle(color: subColor)),
          const SizedBox(height: 24),
          // Stats row
          LayoutBuilder(builder: (context, constraints) {
            final w = (constraints.maxWidth - 48) / 4;
            return Row(
              children: [
                _StatCard(title: 'Total Employees', value: '${employees.length}', icon: Icons.people_rounded, color: const Color(0xFF6366F1), bg: cardBg, textColor: textColor, subColor: subColor, width: w, subtitle: '+2 this month'),
                const SizedBox(width: 16),
                _StatCard(title: 'Active Today', value: '$active', icon: Icons.check_circle_rounded, color: const Color(0xFF10B981), bg: cardBg, textColor: textColor, subColor: subColor, width: w, subtitle: '${(active / employees.length * 100).round()}% present'),
                const SizedBox(width: 16),
                _StatCard(title: 'On Leave', value: '$onLeave', icon: Icons.beach_access_rounded, color: const Color(0xFFF59E0B), bg: cardBg, textColor: textColor, subColor: subColor, width: w, subtitle: '$remote remote'),
                const SizedBox(width: 16),
                _StatCard(title: 'Avg Performance', value: '$avgPerf%', icon: Icons.bar_chart_rounded, color: const Color(0xFF8B5CF6), bg: cardBg, textColor: textColor, subColor: subColor, width: w, subtitle: 'This quarter'),
              ],
            );
          }),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recent employees
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recent Employees', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                      const SizedBox(height: 16),
                      ...employees.take(5).map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            CircleAvatar(radius: 20, backgroundImage: NetworkImage(e.avatar)),
                            const SizedBox(width: 12),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.name, style: TextStyle(fontWeight: FontWeight.w600, color: textColor, fontSize: 13)),
                                Text(e.role, style: TextStyle(color: subColor, fontSize: 12)),
                              ],
                            )),
                            StatusBadge(e.status),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Department breakdown
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('By Department', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                      const SizedBox(height: 16),
                      ..._deptCounts().entries.map((entry) {
                        final pct = entry.value / employees.length;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Expanded(child: Text(entry.key, style: TextStyle(color: textColor, fontSize: 13))),
                                Text('${entry.value}', style: TextStyle(color: subColor, fontSize: 12)),
                              ]),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: pct,
                                  minHeight: 6,
                                  backgroundColor: isDark ? Colors.white10 : Colors.black12,
                                  valueColor: const AlwaysStoppedAnimation(Color(0xFF6366F1)),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Map<String, int> _deptCounts() {
    final map = <String, int>{};
    for (final e in employees) {
      map[e.department] = (map[e.department] ?? 0) + 1;
    }
    return map;
  }
}

class _StatCard extends StatelessWidget {
  final String title, value, subtitle;
  final IconData icon;
  final Color color, bg, textColor, subColor;
  final double width;
  const _StatCard({required this.title, required this.value, required this.icon, required this.color, required this.bg, required this.textColor, required this.subColor, required this.width, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 22)),
            const Spacer(),
          ]),
          const SizedBox(height: 16),
          Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: subColor, fontSize: 13)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    final color = status == 'Active' ? const Color(0xFF10B981) : status == 'On Leave' ? const Color(0xFFF59E0B) : const Color(0xFF6366F1);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
      child: Text(status, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}
