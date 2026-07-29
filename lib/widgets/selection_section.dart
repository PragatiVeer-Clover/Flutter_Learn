import 'package:flutter/material.dart';
import 'component_card.dart';

class SelectionSection extends StatefulWidget {
  const SelectionSection({super.key});

  @override
  State<SelectionSection> createState() => _SelectionSectionState();
}

class _SelectionSectionState extends State<SelectionSection> {
  bool emailNotif = false;
  bool smsNotif = false;
  int billing = 0; // 0 = monthly, 1 = annual
  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Selection',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _checkbox(
            'Email notifications',
            emailNotif,
            (v) => setState(() => emailNotif = v!),
          ),
          _checkbox(
            'SMS notifications',
            smsNotif,
            (v) => setState(() => smsNotif = v!),
          ),
          _radio('Monthly billing', 0),
          _radio('Annual billing', 1),
          const SizedBox(height: 4),
          Row(
            children: [
              Transform.scale(
                scale: 0.7, // 1.0 is normal size. 0.8 makes it 20% smaller.
                child: Switch(
                  value: darkMode,
                  onChanged: (v) => setState(() => darkMode = v),
                  activeThumbColor: Colors.white,
                  activeTrackColor: const Color(0xFF2563EB),
                  // This removes extra padding around the small switch
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
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
        Checkbox(
          value: value,
          onChanged: onChanged,
          side: BorderSide(color: Colors.grey.shade400),
          activeColor: const Color(0xFF2563EB),
          checkColor: Colors.white,  
        
        ),
        Text(label, style: const TextStyle(fontSize: 14,color: Colors.black)),
      ],
    );
  }

  Widget _radio(String label, int value) {
    final selected = billing == value;
    return GestureDetector(
      onTap: () => setState(() => billing = value),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected
                    ? const Color(0xFF2563EB)
                    : Colors.grey.shade400,
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
