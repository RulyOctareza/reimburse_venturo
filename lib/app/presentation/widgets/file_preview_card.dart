import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reimburse_venturo/app/domain/entities/upload_file.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';

class FilePreviewCard extends StatelessWidget {
  final UploadFile file;
  final VoidCallback onDelete;

  const FilePreviewCard({
    super.key,
    required this.file,
    required this.onDelete,
  });

  Widget _buildFileIcon() {
    switch (file.fileType) {
      case 'image':
        return Image.file(file.file, width: 80, height: 80, fit: BoxFit.cover);
      case 'pdf':
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
        );
      case 'excel':
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.table_chart, color: Colors.green, size: 40),
        );
      default:
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.description, color: Colors.blue, size: 40),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _buildFileIcon(),
          ),
        ),
        Positioned(
          top: 3,
          right: 3,
          child: GestureDetector(
            onTap: onDelete,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 12),
            ),
          ),
        ),
      ],
    );
  }
}
