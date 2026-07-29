import 'package:flutter/material.dart';
import 'component_card.dart';

class ButtonsSection extends StatefulWidget {
  final ValueChanged<String>? onButtonPressed;

  const ButtonsSection({super.key, this.onButtonPressed});

  @override
  State<ButtonsSection> createState() => _ButtonsSectionState();
}

class _ButtonsSectionState extends State<ButtonsSection> {
  String _lastPressed = '';

  void _press(String label) {
    setState(() => _lastPressed = label);
    widget.onButtonPressed?.call(label);
  }

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Buttons',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _press('Save changes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  elevation: 0,
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('Save changes'),
              ),
              ElevatedButton(
                onPressed: () => _press('Create project'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('Create project'),
              ),
              OutlinedButton.icon(
                onPressed: () => _press('Delete'),
                icon: const Icon(Icons.delete_outline, size: 16, color: Colors.red),
                label: const Text('Delete'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: const Color(0xFFFEF2F2),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
              ),
              TextButton(
                onPressed: () => _press('Cancel'),
                style: TextButton.styleFrom(foregroundColor: Colors.grey.shade600),
                child: const Text('Cancel'),
              ),
              IconButton(
                onPressed: () => _press('Refresh'),
                icon: const Icon(Icons.refresh, size: 18),
                style: IconButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
              ),
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.grey.shade100,
                  disabledForegroundColor: Colors.grey.shade400,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('Disabled'),
              ),
            ],
          ),
          if (_lastPressed.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.touch_app, size: 13, color: Color(0xFF2563EB)),
                  const SizedBox(width: 6),
                  Text(
                    'Last clicked: $_lastPressed',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
