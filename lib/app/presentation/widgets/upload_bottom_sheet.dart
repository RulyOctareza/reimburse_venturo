import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reimburse_venturo/app/presentation/widgets/custom_button.dart';
import 'package:reimburse_venturo/app/presentation/widgets/custom_text_field.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';
import 'package:reimburse_venturo/core/theme/app_text_styles.dart';

class UploadBottomSheet extends StatelessWidget {
  final TextEditingController nominalController;
  final TextEditingController keteranganController;
  final VoidCallback onAddFile;
  final VoidCallback onSave;

  const UploadBottomSheet({
    super.key,
    required this.nominalController,
    required this.keteranganController,
    required this.onAddFile,
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
                const SizedBox(height: 20),

                // Nominal Section
                CustomTextField(
                  label: 'Nominal',
                  hint: 'Masukkan nominal disini',
                  controller: nominalController,
                  keyboardType: TextInputType.number,
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
