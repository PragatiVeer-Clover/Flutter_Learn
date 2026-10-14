import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/darkthemeProvider.dart';
import 'employee_model.dart';
import 'overview_page.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<Darkthemeprovider>(context).isDarkTheme;
    final cardBg = isDark ? const Color(0xFF0D1117) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.white54 : Colors.black45;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary cards
          LayoutBuilder(builder: (context, constraints) {
            final w = (constraints.maxWidth - 48) / 4;
            final present = employees.where((e) => e.status == 'Active').length;
            final absent = employees.where((e) => e.status == 'On Leave').length;
            final remote = employees.where((e) => e.status == 'Remote').length;
            return Row(children: [
              _AttCard('Present', '$present', Icons.check_circle_rounded, const Color(0xFF10B981), cardBg, textColor, subColor, w),
              const SizedBox(width: 16),
              _AttCard('Absent', '$absent', Icons.cancel_rounded, const Color(0xFFEF4444), cardBg, textColor, subColor, w),
              const SizedBox(width: 16),
              _AttCard('Remote', '$remote', Icons.home_work_rounded, const Color(0xFF6366F1), cardBg, textColor, subColor, w),
              const SizedBox(width: 16),
              _AttCard('Total', '${employees.length}', Icons.people_rounded, const Color(0xFFF59E0B), cardBg, textColor, subColor, w),
            ]);
          }),
          const SizedBox(height: 24),
          // Table
          Container(
            decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade50,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Row(children: [
                    Expanded(flex: 3, child: Text('Employee', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                    Expanded(flex: 2, child: Text('Department', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                    Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                    Expanded(child: Text('Attendance', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                    Expanded(child: Text('Check In', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                    Expanded(child: Text('Check Out', style: TextStyle(fontWeight: FontWeight.bold, color: subColor, fontSize: 13))),
                  ]),
                ),
                ...employees.map((e) {
                  final checkIn = e.status == 'On Leave' ? '--' : '09:${(e.id * 3 % 60).toString().padLeft(2, '0')} AM';
                  final checkOut = e.status == 'On Leave' ? '--' : '06:${(e.id * 7 % 60).toString().padLeft(2, '0')} PM';
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
                      Expanded(child: StatusBadge(e.status)),
                      Expanded(child: _ProgressBar(e.attendancePercent / 100, textColor, subColor)),
                      Expanded(child: Text(checkIn, style: TextStyle(color: textColor, fontSize: 13))),
                      Expanded(child: Text(checkOut, style: TextStyle(color: textColor, fontSize: 13))),
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

class _AttCard extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color, bg, textColor, subColor;
  final double width;
  const _AttCard(this.title, this.value, this.icon, this.color, this.bg, this.textColor, this.subColor, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 24)),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textColor)),
          Text(title, style: TextStyle(color: subColor, fontSize: 13)),
        ]),
      ]),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double value;
  final Color textColor, subColor;
  const _ProgressBar(this.value, this.textColor, this.subColor);

  @override
  Widget build(BuildContext context) {
    final color = value >= 0.95 ? const Color(0xFF10B981) : value >= 0.85 ? const Color(0xFFF59E0B) : const Color(0xFFEF4444);
    return Row(children: [
      Expanded(child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(value: value, minHeight: 6, backgroundColor: Colors.white10, valueColor: AlwaysStoppedAnimation(color)),
      )),
      const SizedBox(width: 8),
      Text('${(value * 100).round()}%', style: TextStyle(color: textColor, fontSize: 12)),
    ]);
  }
}
