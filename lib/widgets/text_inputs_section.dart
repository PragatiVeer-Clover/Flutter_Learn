import 'package:flutter/material.dart';
import 'component_card.dart';

class TextInputsSection extends StatelessWidget {
  const TextInputsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Text Inputs',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Name', style: TextStyle(fontSize: 13, color: Colors.black87)),
          const SizedBox(height: 6),
          _field(hint: 'Ada Lovelace'),
          const SizedBox(height: 14),
          const Text('Password', style: TextStyle(fontSize: 13, color: Colors.black87)),
          const SizedBox(height: 6),
          _field(obscure: true),
          const SizedBox(height: 14),
          const Text('Disabled field', style: TextStyle(fontSize: 13, color: Colors.black87)),
          const SizedBox(height: 6),
          _field(hint: 'Read only', enabled: false),
        ],
      ),
    );
  }

  Widget _field({String hint = '', bool obscure = false, bool enabled = true}) {
    return TextField(
      enabled: enabled,
      obscureText: obscure,
      controller: obscure ? TextEditingController(text: '••••••••••') : null,
      decoration: InputDecoration(
        hintText: hint,
        filled: !enabled,
        fillColor: enabled ? null : Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: _border(),
        enabledBorder: _border(Colors.grey.shade300),
        disabledBorder: _border(Colors.grey.shade200),
      ),
    );
  }

  OutlineInputBorder _border([Color color = const Color(0xFFD1D5DB)]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: const BorderRadius.all(Radius.circular(6)),
    );
  }
}
