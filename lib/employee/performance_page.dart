import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/darkthemeProvider.dart';
import 'employee_model.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<Darkthemeprovider>(context).isDarkTheme;
    final cardBg = isDark ? const Color(0xFF0D1117) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.white54 : Colors.black45;

    final sorted = [...employees]..sort((a, b) => b.performanceScore.compareTo(a.performanceScore));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top performers
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Top Performers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                      const SizedBox(height: 16),
                      ...sorted.take(3).toList().asMap().entries.map((entry) {
                        final i = entry.key;
                        final e = entry.value;
                        final medals = ['🥇', '🥈', '🥉'];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(children: [
                            Text(medals[i], style: const TextStyle(fontSize: 24)),
                            const SizedBox(width: 12),
                            CircleAvatar(radius: 22, backgroundImage: NetworkImage(e.avatar)),
                            const SizedBox(width: 12),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(e.name, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                              Text(e.role, style: TextStyle(color: subColor, fontSize: 12)),
                            ])),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('${e.performanceScore}%', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            ),
                          ]),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Rating distribution
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rating Distribution', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                      const SizedBox(height: 16),
                      ...[
                        ('Excellent (90+)', employees.where((e) => e.performanceScore >= 90).length, const Color(0xFF10B981)),
                        ('Good (80-89)', employees.where((e) => e.performanceScore >= 80 && e.performanceScore < 90).length, const Color(0xFF6366F1)),
                        ('Average (70-79)', employees.where((e) => e.performanceScore >= 70 && e.performanceScore < 80).length, const Color(0xFFF59E0B)),
                        ('Below Avg (<70)', employees.where((e) => e.performanceScore < 70).length, const Color(0xFFEF4444)),
                      ].map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            Expanded(child: Text(item.$1, style: TextStyle(color: textColor, fontSize: 13))),
                            Text('${item.$2}', style: TextStyle(color: subColor, fontSize: 12)),
                          ]),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: item.$2 / employees.length,
                              minHeight: 8,
                              backgroundColor: Colors.white10,
                              valueColor: AlwaysStoppedAnimation(item.$3),
                            ),
                          ),
                        ]),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // All employees performance
          Container(
            decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('All Employees Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                ),
                ...sorted.map((e) {
                  final rating = e.performanceScore >= 90 ? 'Excellent' : e.performanceScore >= 80 ? 'Good' : e.performanceScore >= 70 ? 'Average' : 'Needs Improvement';
                  final ratingColor = e.performanceScore >= 90 ? const Color(0xFF10B981) : e.performanceScore >= 80 ? const Color(0xFF6366F1) : e.performanceScore >= 70 ? const Color(0xFFF59E0B) : const Color(0xFFEF4444);
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(border: Border(top: BorderSide(color: isDark ? Colors.white10 : Colors.black12))),
                    child: Row(children: [
                      CircleAvatar(radius: 18, backgroundImage: NetworkImage(e.avatar)),
                      const SizedBox(width: 12),
                      Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(e.name, style: TextStyle(fontWeight: FontWeight.w600, color: textColor, fontSize: 13)),
                        Text(e.role, style: TextStyle(color: subColor, fontSize: 12)),
                      ])),
                      Expanded(flex: 3, child: Row(children: [
                        Expanded(child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: e.performanceScore / 100,
                            minHeight: 8,
                            backgroundColor: Colors.white10,
                            valueColor: AlwaysStoppedAnimation(ratingColor),
                          ),
                        )),
                        const SizedBox(width: 12),
                        Text('${e.performanceScore}%', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 13)),
                      ])),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: ratingColor.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                        child: Text(rating, style: TextStyle(color: ratingColor, fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ]),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
