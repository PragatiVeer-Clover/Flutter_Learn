import 'package:flutter/material.dart';
import 'component_card.dart';

class SelectionSection extends StatefulWidget {
  final bool emailNotif;
  final bool smsNotif;
  final int billing;
  final bool darkMode;
  final ValueChanged<bool>? onEmailChanged;
  final ValueChanged<bool>? onSmsChanged;
  final ValueChanged<int>? onBillingChanged;
  final ValueChanged<bool>? onDarkModeChanged;

  const SelectionSection({
    super.key,
    this.emailNotif = false,
    this.smsNotif = false,
    this.billing = 0,
    this.darkMode = true,
    this.onEmailChanged,
    this.onSmsChanged,
    this.onBillingChanged,
    this.onDarkModeChanged,
  });

  @override
  State<SelectionSection> createState() => _SelectionSectionState();
}

class _SelectionSectionState extends State<SelectionSection> {
  late bool _emailNotif = widget.emailNotif;
  late bool _smsNotif = widget.smsNotif;
  late int _billing = widget.billing;
  late bool _darkMode = widget.darkMode;

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Selection',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _checkbox('Email notifications', _emailNotif, (v) {
            setState(() => _emailNotif = v!);
            widget.onEmailChanged?.call(v!);
          }),
          _checkbox('SMS notifications', _smsNotif, (v) {
            setState(() => _smsNotif = v!);
            widget.onSmsChanged?.call(v!);
          }),
          _radio('Monthly billing', 0),
          _radio('Annual billing', 1),
          const SizedBox(height: 4),
          Row(
            children: [
              Switch(
                value: _darkMode,
                onChanged: (v) {
                  setState(() => _darkMode = v);
                  widget.onDarkModeChanged?.call(v);
                },
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF2563EB),
              ),
              const SizedBox(width: 8),
              const Text('Dark mode', style: TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _checkbox(String label, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged, side: BorderSide(color: Colors.grey.shade400),activeColor: const Color(0xFF2563EB),
          checkColor: Colors.white, ),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _radio(String label, int value) {
    final selected = _billing == value;
    return GestureDetector(
      onTap: () {
        setState(() => _billing = value);
        widget.onBillingChanged?.call(value);
      },
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? const Color(0xFF2563EB) : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child: selected
                ? Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  )
                : null,
          ),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
