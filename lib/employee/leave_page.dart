import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/darkthemeProvider.dart';
import 'employee_model.dart';
import 'overview_page.dart';

class LeavePage extends StatelessWidget {
  const LeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<Darkthemeprovider>(context).isDarkTheme;
    final cardBg = isDark ? const Color(0xFF0D1117) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.white54 : Colors.black45;

    final leaveRequests = [
      _LeaveRequest('Alice Johnson', employees[0].avatar, 'Annual Leave', 'Dec 20 - Dec 27', 7, 'Pending'),
      _LeaveRequest('Frank Wilson', employees[5].avatar, 'Sick Leave', 'Dec 15 - Dec 22', 7, 'Approved'),
      _LeaveRequest('Bob Martinez', employees[1].avatar, 'Personal Leave', 'Dec 18 - Dec 19', 2, 'Approved'),
      _LeaveRequest('Grace Kim', employees[6].avatar, 'Annual Leave', 'Jan 2 - Jan 5', 4, 'Pending'),
      _LeaveRequest('David Lee', employees[3].avatar, 'Sick Leave', 'Dec 10 - Dec 12', 3, 'Rejected'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Leave balance cards
          LayoutBuilder(builder: (context, constraints) {
            final w = (constraints.maxWidth - 48) / 4;
            return Row(children: [
              _LeaveBalanceCard('Annual Leave', 20, 8, const Color(0xFF6366F1), cardBg, textColor, subColor, w),
              const SizedBox(width: 16),
              _LeaveBalanceCard('Sick Leave', 10, 3, const Color(0xFFEF4444), cardBg, textColor, subColor, w),
              const SizedBox(width: 16),
              _LeaveBalanceCard('Personal Leave', 5, 2, const Color(0xFFF59E0B), cardBg, textColor, subColor, w),
              const SizedBox(width: 16),
              _LeaveBalanceCard('Maternity/Paternity', 90, 0, const Color(0xFF10B981), cardBg, textColor, subColor, w),
            ]);
          }),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leave requests table
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text('Leave Requests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                      ),
                      ...leaveRequests.map((r) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        decoration: BoxDecoration(border: Border(top: BorderSide(color: isDark ? Colors.white10 : Colors.black12))),
                        child: Row(children: [
                          CircleAvatar(radius: 18, backgroundImage: NetworkImage(r.avatar)),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(r.name, style: TextStyle(fontWeight: FontWeight.w600, color: textColor, fontSize: 13)),
                            Text('${r.type} • ${r.dates}', style: TextStyle(color: subColor, fontSize: 12)),
                          ])),
                          Text('${r.days}d', style: TextStyle(color: subColor, fontSize: 13)),
                          const SizedBox(width: 16),
                          _LeaveBadge(r.status),
                          if (r.status == 'Pending') ...[
                            const SizedBox(width: 8),
                            _ActionBtn(Icons.check, const Color(0xFF10B981)),
                            const SizedBox(width: 4),
                            _ActionBtn(Icons.close, const Color(0xFFEF4444)),
                          ],
                        ]),
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Leave summary per employee
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Leave Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                      const SizedBox(height: 16),
                      ...employees.take(6).map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Row(children: [
                          CircleAvatar(radius: 16, backgroundImage: NetworkImage(e.avatar)),
                          const SizedBox(width: 10),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(e.name, style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: (e.leavesTotal - e.leavesUsed) / e.leavesTotal,
                                minHeight: 5,
                                backgroundColor: Colors.white10,
                                valueColor: const AlwaysStoppedAnimation(Color(0xFF6366F1)),
                              ),
                            ),
                          ])),
                          const SizedBox(width: 8),
                          Text('${e.leavesTotal - e.leavesUsed}/${e.leavesTotal}', style: TextStyle(color: subColor, fontSize: 11)),
                        ]),
                      )),
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
}

class _LeaveRequest {
  final String name, avatar, type, dates, status;
  final int days;
  const _LeaveRequest(this.name, this.avatar, this.type, this.dates, this.days, this.status);
}

class _LeaveBalanceCard extends StatelessWidget {
  final String title;
  final int total, used;
  final Color color, bg, textColor, subColor;
  final double width;
  const _LeaveBalanceCard(this.title, this.total, this.used, this.color, this.bg, this.textColor, this.subColor, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: subColor, fontSize: 12)),
        const SizedBox(height: 8),
        Text('${total - used}', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor)),
        Text('of $total days left', style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(value: (total - used) / total, minHeight: 6, backgroundColor: Colors.white10, valueColor: AlwaysStoppedAnimation(color)),
        ),
      ]),
    );
  }
}

class _LeaveBadge extends StatelessWidget {
  final String status;
  const _LeaveBadge(this.status);

  @override
  Widget build(BuildContext context) {
    final color = status == 'Approved' ? const Color(0xFF10B981) : status == 'Pending' ? const Color(0xFFF59E0B) : const Color(0xFFEF4444);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
      child: Text(status, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _ActionBtn(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28, height: 28,
      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
      child: Icon(icon, color: color, size: 16),
    );
  }
}
