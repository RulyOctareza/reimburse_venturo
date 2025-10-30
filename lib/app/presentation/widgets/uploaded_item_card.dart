import 'package:flutter/material.dart';
import 'package:reimburse_venturo/app/domain/entities/uploaded_item.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';
import 'package:reimburse_venturo/core/theme/app_text_styles.dart';
import 'package:reimburse_venturo/core/utils/currency_formatter.dart';

class UploadedItemCard extends StatelessWidget {
  final UploadedItem item;
  final VoidCallback? onTap;

  const UploadedItemCard({
    super.key,
    required this.item,
    this.onTap,
  });

  Widget _buildFilePreview() {
    if (item.files.isEmpty) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      );
    }

    final firstFile = item.files.first;
    if (firstFile.fileType == 'image') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          firstFile.file,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      );
    } else if (firstFile.fileType == 'pdf') {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.picture_as_pdf, color: Colors.red, size: 28),
      );
    } else if (firstFile.fileType == 'excel') {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.table_chart, color: Colors.green, size: 28),
      );
    } else {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.description, color: Colors.blue, size: 28),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _buildFilePreview(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.keterangan.isEmpty
                          ? 'Lampiran (${item.files.length} file)'
                          : item.keterangan,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item.files.length} file',
                      style: AppTextStyles.hint.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Rp ${CurrencyFormatter.formatToRupiah(item.nominal)}',
                style: AppTextStyles.personName.copyWith(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
