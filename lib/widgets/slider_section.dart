import 'package:flutter/material.dart';
import 'component_card.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  double _value = 62;

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Slider',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Volume', style: TextStyle(fontSize: 13, color: Colors.black87)),
          Slider(
            value: _value,
            min: 0,
            max: 100,
            activeColor: const Color(0xFF2563EB),
            inactiveColor: Colors.grey.shade300,
            onChanged: (v) => setState(() => _value = v),
          ),
          Text(_value.round().toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
