import 'package:flutter/material.dart';
import 'component_card.dart';

class AlertCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg;
  final Color color;
  final bool selected;
  final VoidCallback? onTap;

  const AlertCard({
    super.key,
    required this.icon,
    required this.label,
    required this.bg,
    required this.color,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: '',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
            border: selected
                ? Border.all(color: color, width: 2)
                : Border.all(color: Colors.transparent, width: 2),
            boxShadow: selected
                ? [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 8, spreadRadius: 1)]
                : null,
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(label,
                    style: TextStyle(
                        fontSize: 13, color: color, fontWeight: FontWeight.w500)),
              ),
              if (selected)
                Icon(Icons.check_circle, size: 16, color: color),
            ],
          ),
        ),
      ),
    );
  }
}

// Alert type enum for summary
enum AlertType { success, error, warning, none }

class AlertsRow extends StatefulWidget {
  final AlertType selected;
  final ValueChanged<AlertType>? onChanged;

  const AlertsRow({super.key, this.selected = AlertType.none, this.onChanged});

  @override
  State<AlertsRow> createState() => _AlertsRowState();
}

class _AlertsRowState extends State<AlertsRow> {
  late AlertType _selected = widget.selected;

  void _select(AlertType type) {
    setState(() => _selected = _selected == type ? AlertType.none : type);
    widget.onChanged?.call(_selected);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AlertCard(
            icon: Icons.check_circle_outline,
            label: 'Changes saved',
            bg: const Color(0xFFECFDF5),
            color: const Color(0xFF16A34A),
            selected: _selected == AlertType.success,
            onTap: () => _select(AlertType.success),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AlertCard(
            icon: Icons.cancel_outlined,
            label: "Couldn't connect. Retry",
            bg: const Color(0xFFFEF2F2),
            color: const Color(0xFFDC2626),
            selected: _selected == AlertType.error,
            onTap: () => _select(AlertType.error),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AlertCard(
            icon: Icons.warning_amber_outlined,
            label: 'Approaching plan limit',
            bg: const Color(0xFFFFFBEB),
            color: const Color(0xFFD97706),
            selected: _selected == AlertType.warning,
            onTap: () => _select(AlertType.warning),
          ),
        ),
      ],
    );
  }
}
