import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reimburse_venturo/app/presentation/controllers/reimbursement_form_controller.dart';
import 'package:reimburse_venturo/app/presentation/widgets/approver_card.dart';
import 'package:reimburse_venturo/app/presentation/widgets/custom_button.dart';
import 'package:reimburse_venturo/app/presentation/widgets/custom_dropdown.dart';
import 'package:reimburse_venturo/app/presentation/widgets/custom_text_field.dart';
import 'package:reimburse_venturo/app/presentation/widgets/date_picker_field.dart';
import 'package:reimburse_venturo/app/presentation/widgets/section_header.dart';
import 'package:reimburse_venturo/app/presentation/widgets/upload_area.dart';
import 'package:reimburse_venturo/app/presentation/widgets/upload_bottom_sheet.dart';
import 'package:reimburse_venturo/app/presentation/widgets/uploaded_item_card.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';
import 'package:reimburse_venturo/core/constants/claim_types.dart';

class ReimbursementFormPage extends GetView<ReimbursementFormController> {
  const ReimbursementFormPage({super.key});

  void _showFilePickerOptions() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Pilih Gambar'),
              onTap: () {
                Get.back();
                controller.pickImages();
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Pilih Dokumen (PDF, Excel)'),
              onTap: () {
                Get.back();
                controller.pickDocuments();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showUploadBottomSheet() {
    Get.bottomSheet(
      UploadBottomSheet(
        nominalController: controller.nominalController,
        keteranganController: controller.keteranganController,
        selectedFiles: controller.selectedFiles,
        onAddFile: () {
          _showFilePickerOptions();
        },
        onDeleteFile: (fileId) {
          controller.removeFile(fileId);
        },
        onSave: () {
          controller.saveUploadedItem();
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
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
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
            Obx(
              () => DatePickerField(
                label: 'Tanggal',
                hint: 'Pilih tanggal',
                selectedDate: controller.selectedDate.value,
                onDateSelected: (date) {
                  controller.selectedDate.value = date;
                },
              ),
            ),
            const SizedBox(height: 20),
            // Jenis Klaim Dropdown
            Obx(
              () => CustomDropdown<String>(
                label: 'Jenis Klaim',
                hint: 'Pilih jenis klaim',
                value: controller.selectedClaimType.value.isEmpty
                    ? null
                    : controller.selectedClaimType.value,
                items: ClaimTypes.options
                    .map(
                      (type) => DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedClaimType.value = value;
                  }
                },
              ),
            ),
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(title: 'Lampiran Bukti'),
                    const SizedBox(height: 12),
                    Obx(() {
                      if (controller.uploadedItems.isEmpty) {
                        return UploadArea(
                          onTap: () {
                            _showUploadBottomSheet();
                          },
                        );
                      }
                      return Column(
                        children: [
                          ...controller.uploadedItems
                              .map(
                                (item) => UploadedItemCard(
                                  item: item,
                                  onDelete: () {
                                    controller.deleteUploadedItem(item.id);
                                  },
                                ),
                              )
                              .toList(),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.textLightGray.withValues(
                                  alpha: 0.5,
                                ),
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomButton(
                              text: '+ Tambah Item',
                              onPressed: () {
                                _showUploadBottomSheet();
                              },
                              useGradient: false,
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(
                                color: AppColors.textLightGray,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Section 3: Approval Line
            const SectionHeader(title: 'Approval Line'),
            const SizedBox(height: 12),
            Obx(
              () => Column(
                children: controller.approvers
                    .map((approver) => ApproverCard(approver: approver))
                    .toList(),
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            Obx(
              () => CustomButton(
                text: 'Submit Request',
                onPressed: controller.isFormComplete()
                    ? () => controller.submitForm()
                    : null,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
