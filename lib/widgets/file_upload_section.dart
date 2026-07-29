import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'component_card.dart';

class FileUploadSection extends StatefulWidget {
  final ValueChanged<int>? onFileCountChanged;
  final ValueChanged<List<Uint8List>>? onFilesChanged;

  const FileUploadSection({super.key, this.onFileCountChanged, this.onFilesChanged});

  @override
  State<FileUploadSection> createState() => _FileUploadSectionState();
}

class _FileUploadSectionState extends State<FileUploadSection> {
  final List<_UploadedFile> _files = [];
  bool _isDragging = false;

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
      withData: true,
    );
    if (result != null) {
      setState(() {
        for (final f in result.files) {
          if (f.bytes != null) {
            _files.add(_UploadedFile(name: f.name, bytes: f.bytes!, size: f.size));
          }
        }
      });
      widget.onFileCountChanged?.call(_files.length);
      widget.onFilesChanged?.call(_files.map((f) => f.bytes).toList());
    }
  }

  void _removeFile(int index) {
    setState(() => _files.removeAt(index));
    widget.onFileCountChanged?.call(_files.length);
    widget.onFilesChanged?.call(_files.map((f) => f.bytes).toList());
  }

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'File Upload',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DragTarget<Object>(
            onWillAcceptWithDetails: (_) {
              setState(() => _isDragging = true);
              return true;
            },
            onLeave: (_) => setState(() => _isDragging = false),
            onAcceptWithDetails: (_) => setState(() => _isDragging = false),
            builder: (context, accepted, rejected) {
              return GestureDetector(
                onTap: _pickFiles,
                child: DottedBorder(
                  color: _isDragging ? const Color(0xFF2563EB) : Colors.grey.shade400,
                  strokeWidth: 1.5,
                  dashPattern: const [6, 4],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    decoration: BoxDecoration(
                      color: _isDragging ? const Color(0xFFEFF6FF) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_outlined, size: 28,
                            color: _isDragging ? const Color(0xFF2563EB) : Colors.black54),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 13, color: Colors.black54),
                            children: [
                              TextSpan(
                                text: 'Click to upload',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _isDragging ? const Color(0xFF2563EB) : Colors.black87,
                                ),
                              ),
                              const TextSpan(text: ' or drag and drop'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text('PNG, JPG up to 10MB',
                            style: TextStyle(fontSize: 12, color: Colors.black45)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          if (_files.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_files.length, (i) => _previewTile(i)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _previewTile(int index) {
    final file = _files[index];
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
            image: DecorationImage(image: MemoryImage(file.bytes), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: GestureDetector(
            onTap: () => _removeFile(index),
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black87),
              child: const Icon(Icons.close, size: 12, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
            ),
            child: Text(_formatSize(file.size),
                style: const TextStyle(fontSize: 9, color: Colors.white),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    );
  }

  String _formatSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}

class _UploadedFile {
  final String name;
  final Uint8List bytes;
  final int size;
  const _UploadedFile({required this.name, required this.bytes, required this.size});
}
