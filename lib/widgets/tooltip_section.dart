import 'package:flutter/material.dart';
import 'component_card.dart';

class TooltipSection extends StatelessWidget {
  const TooltipSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Tooltip',
      child: Center(
        child: Tooltip(
          message: 'Additional context here',
          preferBelow: false,
          decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(6)),
          textStyle: const TextStyle(color: Colors.white, fontSize: 12),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.info_outline, size: 18, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
