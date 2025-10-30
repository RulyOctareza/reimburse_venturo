import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reimburse_venturo/app/domain/entities/upload_file.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';
import 'package:reimburse_venturo/core/theme/app_text_styles.dart';

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
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            file.file,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        );
      case 'pdf':
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.picture_as_pdf,
            color: Colors.red,
            size: 32,
          ),
        );
      case 'excel':
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.table_chart,
            color: Colors.green,
            size: 32,
          ),
        );
      default:
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.description,
            color: Colors.blue,
            size: 32,
          ),
        );
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildFileIcon(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.fileName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _formatFileSize(file.fileSize),
                  style: AppTextStyles.hint.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            color: Colors.red,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
