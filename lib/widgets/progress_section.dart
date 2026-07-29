import 'package:flutter/material.dart';
import 'component_card.dart';

class ProgressSection extends StatefulWidget {
  const ProgressSection({super.key});

  @override
  State<ProgressSection> createState() => _ProgressSectionState();
}

class _ProgressSectionState extends State<ProgressSection> {
  int _page = 1;
  final int _totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Progress',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Upload progress', style: TextStyle(fontSize: 13, color: Colors.black87)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.50,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Pagination', style: TextStyle(fontSize: 13, color: Colors.black87)),
          const SizedBox(height: 10),
          Row(
            children: [
              _pageBtn(Icons.chevron_left, () {
                if (_page > 1) setState(() => _page--);
              }),
              const SizedBox(width: 4),
              ...List.generate(_totalPages, (i) {
                final p = i + 1;
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: _pageBtn(null, () => setState(() => _page = p), label: '$p', active: _page == p),
                );
              }),
              _pageBtn(Icons.chevron_right, () {
                if (_page < _totalPages) setState(() => _page++);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pageBtn(IconData? icon, VoidCallback onTap, {String? label, bool active = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF2563EB) : Colors.white,
          border: Border.all(color: active ? const Color(0xFF2563EB) : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: icon != null
            ? Icon(icon, size: 16, color: Colors.black54)
            : Text(label!, style: TextStyle(fontSize: 13, color: active ? Colors.white : Colors.black87)),
      ),
    );
  }
}
