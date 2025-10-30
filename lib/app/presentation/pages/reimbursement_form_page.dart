import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reimburse_venturo/app/presentation/controllers/reimbursement_form_controller.dart';
import 'package:reimburse_venturo/app/presentation/widgets/custom_dropdown.dart';
import 'package:reimburse_venturo/app/presentation/widgets/date_picker_field.dart';
import 'package:reimburse_venturo/app/presentation/widgets/section_header.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';
import 'package:reimburse_venturo/core/constants/claim_types.dart';

class ReimbursementFormPage extends GetView<ReimbursementFormController> {
  const ReimbursementFormPage({super.key});

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
            const SizedBox(height: 16),
            // Date Field
            Obx(() => DatePickerField(
                  label: 'Tanggal',
                  hint: 'Pilih tanggal',
                  selectedDate: controller.selectedDate.value,
                  onDateSelected: (date) {
                    controller.selectedDate.value = date;
                  },
                )),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            const Text('Detail field - coming in Phase 5'),
            const SizedBox(height: 32),

            // Section 2: Lampiran Bukti
            const SectionHeader(title: 'Lampiran Bukti'),
            const SizedBox(height: 16),
            const Text('Upload area - coming in Phase 6'),
            const SizedBox(height: 32),

            // Section 3: Approval Line
            const SectionHeader(title: 'Approval Line'),
            const SizedBox(height: 16),
            const Text('Approval cards - coming in Phase 8'),
          ],
        ),
      ),
    );
  }
}
