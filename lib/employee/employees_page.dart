import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/darkthemeProvider.dart';
import 'employee_model.dart';
import 'overview_page.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});
  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  String _search = '';
  String _filterDept = 'All';

  List<String> get _departments => ['All', ...{...employees.map((e) => e.department)}];

  List<Employee> get _filtered => employees.where((e) {
    final matchSearch = e.name.toLowerCase().contains(_search.toLowerCase()) || e.role.toLowerCase().contains(_search.toLowerCase());
    final matchDept = _filterDept == 'All' || e.department == _filterDept;
    return matchSearch && matchDept;
  }).toList();

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
          // Search + filter row
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
                  child: TextField(
                    onChanged: (v) => setState(() => _search = v),
                    style: TextStyle(color: textColor, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search employees...',
                      hintStyle: TextStyle(color: subColor, fontSize: 14),
                      prefixIcon: Icon(Icons.search, color: subColor, size: 20),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: isDark ? Colors.white10 : Colors.black12)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _filterDept,
                    dropdownColor: cardBg,
                    style: TextStyle(color: textColor, fontSize: 14),
                    items: _departments.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                    onChanged: (v) => setState(() => _filterDept = v!),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('${_filtered.length} employees found', style: TextStyle(color: subColor, fontSize: 13)),
          const SizedBox(height: 16),
          // Grid
          LayoutBuilder(builder: (context, constraints) {
            final cols = constraints.maxWidth > 900 ? 4 : constraints.maxWidth > 600 ? 3 : 2;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _filtered.map((e) => SizedBox(
                width: (constraints.maxWidth - (cols - 1) * 16) / cols,
                child: _EmployeeCard(e, cardBg, textColor, subColor),
              )).toList(),
            );
          }),
        ],
      ),
    );
  }
}

class _EmployeeCard extends StatelessWidget {
  final Employee emp;
  final Color cardBg, textColor, subColor;
  const _EmployeeCard(this.emp, this.cardBg, this.textColor, this.subColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
      child: Column(
        children: [
          CircleAvatar(radius: 32, backgroundImage: NetworkImage(emp.avatar)),
          const SizedBox(height: 12),
          Text(emp.name, style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 14), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(emp.role, style: TextStyle(color: subColor, fontSize: 12), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(emp.department, style: const TextStyle(color: Color(0xFF6366F1), fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          StatusBadge(emp.status),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _MiniStat(Icons.trending_up_rounded, '${emp.performanceScore}%', subColor),
              _MiniStat(Icons.calendar_today_rounded, '${emp.attendancePercent}%', subColor),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;
  const _MiniStat(this.icon, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 14, color: color),
      const SizedBox(width: 4),
      Text(value, style: TextStyle(color: color, fontSize: 12)),
    ]);
  }
}
