import 'package:flutter/material.dart';
import 'component_card.dart';

enum ModalAction { none, cancelled, deleted }

class ModalSection extends StatefulWidget {
  final ValueChanged<ModalAction>? onAction;

  const ModalSection({super.key, this.onAction});

  @override
  State<ModalSection> createState() => _ModalSectionState();
}

class _ModalSectionState extends State<ModalSection> {
  bool _showModal = true;
  ModalAction _lastAction = ModalAction.none;

  void _handleAction(ModalAction action) {
    setState(() {
      _showModal = false;
      _lastAction = action;
    });
    widget.onAction?.call(action);
  }

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Modal',
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(8),
        ),
        child: _showModal
            ? Center(
                child: Container(
                  width: 340,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 20)
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Delete project?',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text(
                        "This can't be undone. All files and history will be removed.",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => _handleAction(ModalAction.cancelled),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.black87)),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => _handleAction(ModalAction.deleted),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.red,
                              elevation: 0,
                              side: const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Action result badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: _lastAction == ModalAction.deleted
                            ? const Color(0xFFFEF2F2)
                            : const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _lastAction == ModalAction.deleted
                                ? Icons.delete_outline
                                : Icons.check_circle_outline,
                            size: 14,
                            color: _lastAction == ModalAction.deleted
                                ? Colors.red
                                : const Color(0xFF16A34A),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _lastAction == ModalAction.deleted
                                ? 'Deleted'
                                : 'Cancelled',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _lastAction == ModalAction.deleted
                                  ? Colors.red
                                  : const Color(0xFF16A34A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: () => setState(() {
                        _showModal = true;
                        _lastAction = ModalAction.none;
                        widget.onAction?.call(ModalAction.none);
                      }),
                      icon: const Icon(Icons.refresh, size: 14),
                      label: const Text('Show modal again'),
                      style: TextButton.styleFrom(foregroundColor: Colors.white),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
