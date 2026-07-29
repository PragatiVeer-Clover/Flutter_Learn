import 'dart:typed_data';
import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const SummaryPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Submission Summary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black)),
            Text('Review of your selected values',
                style: TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF16A34A).withValues(alpha: 0.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle_outline, size: 18, color: Color(0xFF16A34A)),
                  SizedBox(width: 10),
                  Text('Form submitted successfully!',
                      style: TextStyle(fontSize: 13, color: Color(0xFF16A34A), fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Sections grid
            LayoutBuilder(builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              final cards = [
                _buildCard('Text Inputs', [
                  _row('Name', data['name'] ?? '—'),
                  _row('Password', data['password']?.isNotEmpty == true ? '........' : '—'),
                ]),
                _buildCard('Buttons', [
                  _row('Last clicked', data['lastButtonPressed']?.isNotEmpty == true
                      ? data['lastButtonPressed']
                      : 'None'),
                ]),
                _buildCard('Selection', [
                  _row('Email notifications', data['emailNotif'] == true ? 'Yes' : 'No'),
                  _row('SMS notifications', data['smsNotif'] == true ? 'Yes' : 'No'),
                  _row('Billing', data['billing'] == 0 ? 'Monthly' : 'Annual'),
                  _row('Dark mode', data['darkMode'] == true ? 'On' : 'Off'),
                ]),
                _buildCard('Slider', [
                  _row('Volume', '${data['sliderValue']?.round() ?? 62}'),
                ]),
                _buildCard('Select & Date', [
                  _row('Role', data['role'] ?? '—'),
                  _row('Start date', data['date'] ?? '—'),
                ]),
                _buildCard('Textarea', [
                  _row('Notes', data['notes']?.isNotEmpty == true ? data['notes'] : '—'),
                ]),
                _buildCard('Badges & Tags', [
                  _row('Tags', (data['tags'] as List?)?.join(', ') ?? '—'),
                ]),
                _buildCard('Tabs', [
                  _row('Active tab', data['activeTab'] ?? 'Overview'),
                ]),
                _buildCard('Alerts & Modal', [
                  _row('Selected alert', _alertLabel(data['selectedAlert'] ?? 'none')),
                  _row('Modal action', _modalLabel(data['modalAction'] ?? 'none')),
                ]),
                _buildCard('File Upload', [
                  _row('Files uploaded', '${(data['fileCount'] ?? 0)} file(s)'),
                  if ((data['uploadedFiles'] as List<Uint8List>?)?.isNotEmpty == true)
                    _imageGrid(data['uploadedFiles'] as List<Uint8List>),
                ]),
              ];

              if (isWide) {
                final rows = <Widget>[];
                for (int i = 0; i < cards.length; i += 2) {
                  rows.add(Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: cards[i]),
                      const SizedBox(width: 16),
                      Expanded(child: i + 1 < cards.length ? cards[i + 1] : const SizedBox()),
                    ],
                  ));
                  rows.add(const SizedBox(height: 16));
                }
                return Column(children: rows);
              }

              return Column(
                children: cards.expand((c) => [c, const SizedBox(height: 16)]).toList(),
              );
            }),

            const SizedBox(height: 8),

            // Back button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('← Back to Component Library',
                    style: TextStyle(fontSize: 14, color: Colors.black87)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _alertLabel(String val) {
    switch (val) {
      case 'success': return 'Changes saved';
      case 'error':   return "Couldn't connect. Retry";
      case 'warning': return 'Approaching plan limit';
      default:        return 'None selected';
    }
  }

  String _modalLabel(String val) {
    switch (val) {
      case 'deleted':   return 'Deleted';
      case 'cancelled': return 'Cancelled';
      default:          return 'No action taken';
    }
  }

  Widget _imageGrid(List<Uint8List> images) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: images
            .map((bytes) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    bytes,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCard(String title, List<Widget> rows) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                  letterSpacing: 1.2)),
          const SizedBox(height: 14),
          ...rows,
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
