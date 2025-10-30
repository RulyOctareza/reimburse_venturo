import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReimbursementFormController extends GetxController {
  // Form fields
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxString selectedClaimType = ''.obs;
  final TextEditingController detailController = TextEditingController();

  // Upload fields (for bottom sheet)
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  @override
  void onClose() {
    detailController.dispose();
    nominalController.dispose();
    keteranganController.dispose();
    super.onClose();
  }
}
