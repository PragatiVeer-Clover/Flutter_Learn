import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/darkthemeProvider.dart';
import 'employee_model.dart';

class PayrollPage extends StatelessWidget {
  const PayrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<Darkthemeprovider>(context).isDarkTheme;
    final cardBg = isDark ? const Color(0xFF0D1117) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.white54 : Colors.black45;

    final totalPayroll = employees.map((e) => e.salary).reduce((a, b) => a + b);
    final avgSalary = totalPayroll / employees.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary
          LayoutBuilder(builder: (context, constraints) {
            final w = (constraints.maxWidth - 48) / 4;
            return Row(children: [
              _PayCard('Total Payroll', '\$${(totalPayroll / 1000).toStringAsFixed(0)}K', 'Monthly', const Color(0xFF6366F1), cardBg, textColor, subColor, w),
              const SizedBox(width: 16),
              _PayCard('Avg Salary', '\$${(avgSalary / 1000).toStringAsFixed(1)}K', 'Per employee', const Color(0xFF10B981), cardBg, textColor, subColor, w),
              const SizedBox(width: 16),
              _PayCard('Highest', '\$${(employees.map((e) => e.salary).reduce((a, b) => a > b ? a : b) / 1000).toStringAsFixed(0)}K', 'Top earner', const Color(0xFFF59E0B), cardBg, textColor, subColor, w),
              const SizedBox(width: 16),
              _PayCard('Lowest', '\$${(employees.map((e) => e.salary).reduce((a, b) => a < b ? a : b) / 1000).toStringAsFixed(0)}K', 'Entry level', const Color(0xFF8B5CF6), cardBg, textColor, subColor, w),
            ]);
          }),
          const SizedBox(height: 24),
          // Payroll table
          Container(
            decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade50,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Row(children: [
                    Expanded(flex: 3, child: Text('Employee', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                    Expanded(flex: 2, child: Text('Department', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                    Expanded(child: Text('Base Salary', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                    Expanded(child: Text('Bonus', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                    Expanded(child: Text('Deductions', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                    Expanded(child: Text('Net Pay', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                    Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                  ]),
                ),
                ...employees.map((e) {
                  final monthly = e.salary / 12;
                  final bonus = monthly * (e.performanceScore > 90 ? 0.1 : e.performanceScore > 80 ? 0.05 : 0.02);
                  final deduction = monthly * 0.12;
                  final net = monthly + bonus - deduction;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isDark ? Colors.white10 : Colors.black12))),
                    child: Row(children: [
                      Expanded(flex: 3, child: Row(children: [
                        CircleAvatar(radius: 16, backgroundImage: NetworkImage(e.avatar)),
                        const SizedBox(width: 10),
                        Expanded(child: Text(e.name, style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)),
                      ])),
                      Expanded(flex: 2, child: Text(e.department, style: TextStyle(color: subColor, fontSize: 13))),
                      Expanded(child: Text('\$${monthly.toStringAsFixed(0)}', style: TextStyle(color: textColor, fontSize: 13))),
                      Expanded(child: Text('+\$${bonus.toStringAsFixed(0)}', style: const TextStyle(color: Color(0xFF10B981), fontSize: 13))),
                      Expanded(child: Text('-\$${deduction.toStringAsFixed(0)}', style: const TextStyle(color: Color(0xFFEF4444), fontSize: 13))),
                      Expanded(child: Text('\$${net.toStringAsFixed(0)}', style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.bold))),
                      Expanded(child: _PayBadge('Paid')),
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

class _PayCard extends StatelessWidget {
  final String title, value, subtitle;
  final Color color, bg, textColor, subColor;
  final double width;
  const _PayCard(this.title, this.value, this.subtitle, this.color, this.bg, this.textColor, this.subColor, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
          child: Icon(Icons.payments_rounded, color: color, size: 22)),
        const SizedBox(height: 16),
        Text(value, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textColor)),
        Text(title, style: TextStyle(color: subColor, fontSize: 13)),
        Text(subtitle, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500)),
      ]),
    );
  }
}

class _PayBadge extends StatelessWidget {
  final String status;
  const _PayBadge(this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
      child: Text(status, style: const TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}
