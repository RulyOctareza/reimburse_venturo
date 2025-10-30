import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reimburse_venturo/app/domain/entities/uploaded_item.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';
import 'package:reimburse_venturo/core/theme/app_text_styles.dart';
import 'package:reimburse_venturo/core/utils/currency_formatter.dart';

class UploadedItemCard extends StatelessWidget {
  final UploadedItem item;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const UploadedItemCard({
    super.key,
    required this.item,
    this.onTap,
    this.onDelete,
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

  void _showFileDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Detail Lampiran', style: AppTextStyles.sectionHeader),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),
            Text('Nominal', style: AppTextStyles.fieldLabel),
            const SizedBox(height: 4),
            Text(
              'Rp ${CurrencyFormatter.formatToRupiah(item.nominal)}',
              style: AppTextStyles.personName.copyWith(
                color: AppColors.primaryBlue,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Text('Keterangan', style: AppTextStyles.fieldLabel),
            const SizedBox(height: 4),
            Text(
              item.keterangan.isEmpty ? '-' : item.keterangan,
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'File Terlampir (${item.files.length})',
              style: AppTextStyles.fieldLabel,
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: item.files.length,
                itemBuilder: (context, index) {
                  final file = item.files[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: _buildFileIcon(file.fileType),
                      title: Text(
                        file.fileName,
                        style: AppTextStyles.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        '${(file.fileSize / 1024).toStringAsFixed(1)} KB',
                        style: AppTextStyles.hint,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileIcon(String fileType) {
    if (fileType == 'image') {
      return const Icon(Icons.image, color: AppColors.primaryBlue);
    } else if (fileType == 'pdf') {
      return const Icon(Icons.picture_as_pdf, color: Colors.red);
    } else if (fileType == 'excel') {
      return const Icon(Icons.table_chart, color: Colors.green);
    } else {
      return const Icon(Icons.description, color: Colors.blue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 32),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Hapus Item'),
            content: const Text('Apakah Anda yakin ingin menghapus item ini?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Hapus'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        if (onDelete != null) {
          onDelete!();
        }
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: InkWell(
          onTap: () => _showFileDetails(context),
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
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Rp ${CurrencyFormatter.formatToRupiah(item.nominal)}',
                      style: AppTextStyles.personName.copyWith(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
