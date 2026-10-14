import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/darkthemeProvider.dart';
import 'employee_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<Darkthemeprovider>(context).isDarkTheme;
    final cardBg = isDark ? const Color(0xFF0D1117) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.white54 : Colors.black45;
    final e = employees[0]; // Alice as logged-in user

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Profile card
          SizedBox(
            width: 280,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(radius: 50, backgroundImage: NetworkImage(e.avatar)),
                          Positioned(
                            bottom: 0, right: 0,
                            child: Container(
                              width: 28, height: 28,
                              decoration: const BoxDecoration(color: Color(0xFF6366F1), shape: BoxShape.circle),
                              child: const Icon(Icons.edit, color: Colors.white, size: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(e.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
                      const SizedBox(height: 4),
                      Text(e.role, style: TextStyle(color: subColor)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                        child: const Text('Active', style: TextStyle(color: Color(0xFF10B981), fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 20),
                      _InfoRow(Icons.email_rounded, e.email, subColor, textColor),
                      const SizedBox(height: 10),
                      _InfoRow(Icons.phone_rounded, e.phone, subColor, textColor),
                      const SizedBox(height: 10),
                      _InfoRow(Icons.business_rounded, e.department, subColor, textColor),
                      const SizedBox(height: 10),
                      _InfoRow(Icons.calendar_today_rounded, 'Joined ${e.joinDate}', subColor, textColor),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Quick stats
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quick Stats', style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                      const SizedBox(height: 16),
                      _QuickStat('Performance', '${e.performanceScore}%', const Color(0xFF6366F1), isDark),
                      const SizedBox(height: 12),
                      _QuickStat('Attendance', '${e.attendancePercent}%', const Color(0xFF10B981), isDark),
                      const SizedBox(height: 12),
                      _QuickStat('Leave Balance', '${e.leavesTotal - e.leavesUsed}/${e.leavesTotal}', const Color(0xFFF59E0B), isDark),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          // Right: Details
          Expanded(
            child: Column(
              children: [
                // Personal info form
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Personal Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                      const SizedBox(height: 20),
                      Row(children: [
                        Expanded(child: _FormField('Full Name', e.name, isDark, textColor, subColor)),
                        const SizedBox(width: 16),
                        Expanded(child: _FormField('Employee ID', '#EMP-00${e.id}', isDark, textColor, subColor)),
                      ]),
                      const SizedBox(height: 16),
                      Row(children: [
                        Expanded(child: _FormField('Email', e.email, isDark, textColor, subColor)),
                        const SizedBox(width: 16),
                        Expanded(child: _FormField('Phone', e.phone, isDark, textColor, subColor)),
                      ]),
                      const SizedBox(height: 16),
                      Row(children: [
                        Expanded(child: _FormField('Department', e.department, isDark, textColor, subColor)),
                        const SizedBox(width: 16),
                        Expanded(child: _FormField('Role', e.role, isDark, textColor, subColor)),
                      ]),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Recent activity
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                      const SizedBox(height: 16),
                      ...[
                        ('Completed Q4 performance review', '2 hours ago', Icons.bar_chart_rounded, const Color(0xFF6366F1)),
                        ('Submitted leave request for Dec 20-27', '1 day ago', Icons.beach_access_rounded, const Color(0xFFF59E0B)),
                        ('Checked in at 09:03 AM', '2 days ago', Icons.login_rounded, const Color(0xFF10B981)),
                        ('Updated profile information', '1 week ago', Icons.person_rounded, const Color(0xFF8B5CF6)),
                      ].map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Row(children: [
                          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: item.$4.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                            child: Icon(item.$3, color: item.$4, size: 16)),
                          const SizedBox(width: 12),
                          Expanded(child: Text(item.$1, style: TextStyle(color: textColor, fontSize: 13))),
                          Text(item.$2, style: TextStyle(color: subColor, fontSize: 12)),
                        ]),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color subColor, textColor;
  const _InfoRow(this.icon, this.text, this.subColor, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 16, color: subColor),
      const SizedBox(width: 8),
      Expanded(child: Text(text, style: TextStyle(color: textColor, fontSize: 13), overflow: TextOverflow.ellipsis)),
    ]);
  }
}

class _QuickStat extends StatelessWidget {
  final String label, value;
  final Color color;
  final bool isDark;
  const _QuickStat(this.label, this.value, this.color, this.isDark);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Text(label, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 13))),
      Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
    ]);
  }
}

class _FormField extends StatelessWidget {
  final String label, value;
  final bool isDark;
  final Color textColor, subColor;
  const _FormField(this.label, this.value, this.isDark, this.textColor, this.subColor);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: TextStyle(color: subColor, fontSize: 12, fontWeight: FontWeight.w500)),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
        ),
        child: Text(value, style: TextStyle(color: textColor, fontSize: 14)),
      ),
    ]);
  }
}
