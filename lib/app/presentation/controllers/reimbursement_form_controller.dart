import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReimbursementFormController extends GetxController {
  // Form fields
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxString selectedClaimType = ''.obs;
  final TextEditingController detailController = TextEditingController();

  @override
  void onClose() {
    detailController.dispose();
    super.onClose();
  }
}
