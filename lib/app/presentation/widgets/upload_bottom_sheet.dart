import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reimburse_venturo/app/domain/entities/upload_file.dart';
import 'package:reimburse_venturo/app/presentation/widgets/custom_button.dart';
import 'package:reimburse_venturo/app/presentation/widgets/custom_text_field.dart';
import 'package:reimburse_venturo/app/presentation/widgets/file_preview_card.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';
import 'package:reimburse_venturo/core/theme/app_text_styles.dart';
import 'package:reimburse_venturo/core/utils/currency_formatter.dart';

class UploadBottomSheet extends StatelessWidget {
  final TextEditingController nominalController;
  final TextEditingController keteranganController;
  final RxList<UploadFile> selectedFiles;
  final VoidCallback onAddFile;
  final Function(String) onDeleteFile;
  final VoidCallback onSave;

  const UploadBottomSheet({
    super.key,
    required this.nominalController,
    required this.keteranganController,
    required this.selectedFiles,
    required this.onAddFile,
    required this.onDeleteFile,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bukti dan Nominal',
                  style: AppTextStyles.sectionHeader.copyWith(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bukti Foto Section
                Text(
                  'Bukti Foto',
                  style: AppTextStyles.fieldLabel,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onAddFile,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryBlue),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.primaryBlue,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // File Preview List
                Obx(() => Column(
                      children: selectedFiles
                          .map((file) => FilePreviewCard(
                                file: file,
                                onDelete: () => onDeleteFile(file.id),
                              ))
                          .toList(),
                    )),
                const SizedBox(height: 8),

                // Nominal Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nominal',
                      style: AppTextStyles.fieldLabel,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: nominalController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(),
                      ],
                      style: AppTextStyles.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'Masukkan nominal disini',
                        hintStyle: AppTextStyles.hint,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.primaryBlue,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Keterangan Section
                CustomTextField(
                  label: 'Keterangan',
                  hint: 'Masukkan keterangan pengajuan',
                  controller: keteranganController,
                  maxLines: 3,
                  minLines: 3,
                ),
                const SizedBox(height: 24),

                // Simpan Button
                CustomButton(
                  text: 'Simpan',
                  onPressed: onSave,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
