import 'package:flutter/material.dart';
import 'component_card.dart';

class BadgesSection extends StatefulWidget {
  final List<String> tags;
  final ValueChanged<List<String>>? onTagsChanged;

  const BadgesSection({
    super.key,
    this.tags = const ['Design', 'Frontend'],
    this.onTagsChanged,
  });

  @override
  State<BadgesSection> createState() => _BadgesSectionState();
}

class _BadgesSectionState extends State<BadgesSection> {
  late final List<String> _tags = List.from(widget.tags);

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Badges and Tags',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _badge('Active', const Color(0xFFDCFCE7), const Color(0xFF16A34A)),
              _badge('Pending', const Color(0xFFFEF9C3), const Color(0xFFCA8A04)),
              _badge('Failed', const Color(0xFFFEE2E2), const Color(0xFFDC2626)),
              _badge('Beta', const Color(0xFFEFF6FF), const Color(0xFF2563EB)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _tags
                .map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(tag, style: const TextStyle(fontSize: 13)),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              setState(() => _tags.remove(tag));
                              widget.onTagsChanged?.call(List.from(_tags));
                            },
                            child: const Icon(Icons.close, size: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _badge(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(fontSize: 12, color: fg, fontWeight: FontWeight.w500)),
    );
  }
}
