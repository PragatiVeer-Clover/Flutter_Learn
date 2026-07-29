import 'package:flutter/material.dart';
import 'component_card.dart';

class TabsSection extends StatefulWidget {
  final ValueChanged<String>? onTabChanged;

  const TabsSection({super.key, this.onTabChanged});

  @override
  State<TabsSection> createState() => _TabsSectionState();
}

class _TabsSectionState extends State<TabsSection> {
  int _selected = 0;
  final _tabs = ['Overview', 'Members', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Tabs',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(_tabs.length, (i) {
              final active = _selected == i;
              return GestureDetector(
                onTap: () {
                  setState(() => _selected = i);
                  widget.onTabChanged?.call(_tabs[i]);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 24),
                  padding: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: active ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    _tabs[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: active ? FontWeight.bold : FontWeight.normal,
                      color: active ? Colors.black : Colors.black54,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Text(
            _selected == 0
                ? 'Project summary and recent activity show up here.'
                : _selected == 1
                    ? 'Team members and roles are listed here.'
                    : 'Project settings and preferences go here.',
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
