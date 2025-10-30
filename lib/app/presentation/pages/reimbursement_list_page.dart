import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reimburse_venturo/app/presentation/controllers/reimbursement_list_controller.dart';
import 'package:reimburse_venturo/app/presentation/widgets/custom_card.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';
import 'package:reimburse_venturo/core/theme/app_text_styles.dart';

class ReimbursementListPage extends GetView<ReimbursementListController> {
  const ReimbursementListPage({super.key});

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
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.reimbursements.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = controller.reimbursements[index];
            return CustomCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: AppTextStyles.personName.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    'Ajukan >',
                    style: AppTextStyles.personName.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
