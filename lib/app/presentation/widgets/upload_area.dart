import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';
import 'package:reimburse_venturo/core/theme/app_text_styles.dart';

class UploadArea extends StatelessWidget {
  final VoidCallback onTap;

  const UploadArea({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        color: Colors.grey.shade400,
        strokeWidth: 1.5,
        dashPattern: const [6, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud_upload_outlined,
                size: 48,
                color: AppColors.textLightGray,
              ),
              const SizedBox(height: 12),
              Text(
                'Klik untuk upload file dan nominal',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'PNG, JPG, PDF, XLSX (Max: 5MB)',
                style: AppTextStyles.hint.copyWith(
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
