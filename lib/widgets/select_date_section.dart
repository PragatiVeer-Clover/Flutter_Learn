import 'package:flutter/material.dart';
import 'component_card.dart';

class SelectDateSection extends StatefulWidget {
  final String role;
  final DateTime? date;
  final ValueChanged<String>? onRoleChanged;
  final ValueChanged<DateTime>? onDateChanged;

  const SelectDateSection({
    super.key,
    this.role = 'Editor',
    this.date,
    this.onRoleChanged,
    this.onDateChanged,
  });

  @override
  State<SelectDateSection> createState() => _SelectDateSectionState();
}

class _SelectDateSectionState extends State<SelectDateSection> {
  late String _role;
  late DateTime _date;

  static const _roles = ['Viewer', 'Editor', 'Admin'];

  @override
  void initState() {
    super.initState();
    _role = widget.role;
    _date = widget.date ?? DateTime(2023, 2, 3);
  }

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Select and Date',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Role', style: TextStyle(fontSize: 13, color: Colors.black87)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: _role,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
            ),
            items: _roles.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
            onChanged: (v) {
              setState(() => _role = v!);
              widget.onRoleChanged?.call(v!);
            },
          ),
          const SizedBox(height: 14),
          const Text('Start date', style: TextStyle(fontSize: 13, color: Colors.black87)),
          const SizedBox(height: 6),
          InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                setState(() => _date = picked);
                widget.onDateChanged?.call(picked);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_date.month.toString().padLeft(2, '0')}/${_date.day.toString().padLeft(2, '0')}/${_date.year}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
