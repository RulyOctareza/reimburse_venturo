import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';

class ReimbursementFormPage extends StatelessWidget {
  const ReimbursementFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? itemId = Get.parameters['id'];
    final String? title = Get.parameters['title'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengajuan Reimburs'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Form Page - ID: $itemId'),
            Text('Title: $title'),
            const SizedBox(height: 20),
            const Text('Form will be implemented in Phase 4'),
          ],
        ),
      ),
    );
  }
}
