import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reimburse_venturo/app/presentation/controllers/reimbursement_form_controller.dart';
import 'package:reimburse_venturo/app/presentation/widgets/custom_dropdown.dart';
import 'package:reimburse_venturo/app/presentation/widgets/custom_text_field.dart';
import 'package:reimburse_venturo/app/presentation/widgets/date_picker_field.dart';
import 'package:reimburse_venturo/app/presentation/widgets/section_header.dart';
import 'package:reimburse_venturo/app/presentation/widgets/upload_area.dart';
import 'package:reimburse_venturo/app/presentation/widgets/upload_bottom_sheet.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';
import 'package:reimburse_venturo/core/constants/claim_types.dart';

class ReimbursementFormPage extends GetView<ReimbursementFormController> {
  const ReimbursementFormPage({super.key});

  void _showUploadBottomSheet() {
    Get.bottomSheet(
      UploadBottomSheet(
        nominalController: controller.nominalController,
        keteranganController: controller.keteranganController,
        onAddFile: () {
          // File picker will be implemented in next commit
          Get.snackbar(
            'Info',
            'File picker akan diimplementasi di commit berikutnya',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        onSave: () {
          // Save logic will be implemented in next commits
          Get.back();
          Get.snackbar(
            'Berhasil',
            'Data berhasil disimpan',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      ),
      isScrollControlled: true,
      isDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengajuan Reimburs'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Detail Pengajuan
            const SectionHeader(title: 'Detail Pengajuan'),
            const SizedBox(height: 12),
            // Date Field
            Obx(() => DatePickerField(
                  label: 'Tanggal',
                  hint: 'Pilih tanggal',
                  selectedDate: controller.selectedDate.value,
                  onDateSelected: (date) {
                    controller.selectedDate.value = date;
                  },
                )),
            const SizedBox(height: 20),
            // Jenis Klaim Dropdown
            Obx(() => CustomDropdown<String>(
                  label: 'Jenis Klaim',
                  hint: 'Pilih jenis klaim',
                  value: controller.selectedClaimType.value.isEmpty
                      ? null
                      : controller.selectedClaimType.value,
                  items: ClaimTypes.options
                      .map((type) => DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedClaimType.value = value;
                    }
                  },
                )),
            const SizedBox(height: 20),
            // Detail Text Area
            CustomTextField(
              label: 'Detail',
              hint: 'Masukkan detail pengajuan',
              controller: controller.detailController,
              maxLines: 5,
              minLines: 3,
            ),
            const SizedBox(height: 24),

            // Section 2: Lampiran Bukti
            const SectionHeader(title: 'Lampiran Bukti'),
            const SizedBox(height: 12),
            UploadArea(
              onTap: () {
                _showUploadBottomSheet();
              },
            ),
            const SizedBox(height: 24),

            // Section 3: Approval Line
            const SectionHeader(title: 'Approval Line'),
            const SizedBox(height: 12),
            const Text('Approval cards - coming in Phase 8'),
          ],
        ),
      ),
    );
  }
}
