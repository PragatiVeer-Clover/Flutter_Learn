import 'package:flutter/material.dart';
import 'component_card.dart';

class TextareaSection extends StatelessWidget {
  final TextEditingController? controller;

  const TextareaSection({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Textarea',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Notes', style: TextStyle(fontSize: 13, color: Colors.black87)),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Add a note',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
            ),
          ),
        ],
      ),
    );
  }
}
