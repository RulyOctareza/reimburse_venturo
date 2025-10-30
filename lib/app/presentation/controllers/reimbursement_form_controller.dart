import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:reimburse_venturo/app/data/models/approver_model.dart';
import 'package:reimburse_venturo/app/domain/entities/approver.dart';
import 'package:reimburse_venturo/app/domain/entities/upload_file.dart';
import 'package:reimburse_venturo/app/domain/entities/uploaded_item.dart';
import 'package:reimburse_venturo/core/utils/currency_formatter.dart';

/// Controller for managing reimbursement form state and logic
class ReimbursementFormController extends GetxController {
  // Form fields
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxString selectedClaimType = ''.obs;
  final TextEditingController detailController = TextEditingController();

  // Upload fields (for bottom sheet)
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final RxList<UploadFile> selectedFiles = <UploadFile>[].obs;

  // Uploaded items (saved items)
  final RxList<UploadedItem> uploadedItems = <UploadedItem>[].obs;

  // Approvers
  final RxList<Approver> approvers = <Approver>[].obs;

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // Load dummy approvers
    approvers.value = ApproverModel.getDummyData();
  }

  // Validate form
  String? validateForm() {
    if (selectedDate.value == null) {
      return 'Tanggal harus dipilih';
    }

    if (selectedClaimType.value.isEmpty) {
      return 'Jenis klaim harus dipilih';
    }

    if (detailController.text.isEmpty) {
      return 'Detail pengajuan harus diisi';
    }

    if (uploadedItems.isEmpty) {
      return 'Minimal 1 lampiran bukti harus diupload';
    }

    return null; // Form is valid
  }

  // Helper method to check if form is complete
  bool isFormComplete() {
    return selectedDate.value != null &&
        selectedClaimType.value.isNotEmpty &&
        detailController.text.isNotEmpty &&
        uploadedItems.isNotEmpty;
  }

  // Helper method to get total nominal
  int getTotalNominal() {
    return uploadedItems.fold(
      0,
      (sum, item) => sum + item.nominal,
    );
  }

  // Clear all form data
  void clearForm() {
    selectedDate.value = null;
    selectedClaimType.value = '';
    detailController.clear();
    uploadedItems.clear();
    selectedFiles.clear();
    nominalController.clear();
    keteranganController.clear();
  }

  // Submit form
  Future<void> submitForm() async {
    // Validate first
    final validationError = validateForm();
    if (validationError != null) {
      Get.snackbar(
        'Error',
        validationError,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      return;
    }

    // Show loading
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Close loading
    Get.back();

    // Show success message
    Get.snackbar(
      'Berhasil',
      'Pengajuan reimbursement berhasil dikirim!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      duration: const Duration(seconds: 3),
    );

    // Wait a bit then navigate back
    await Future.delayed(const Duration(milliseconds: 500));
    Get.back(); // Back to list

    // Clear form for next use
    clearForm();
  }

  // Pick images
  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage();

      for (var image in images) {
        final file = File(image.path);
        final fileSize = await file.length();

        // Validate file size (5MB max)
        if (fileSize > 5 * 1024 * 1024) {
          Get.snackbar(
            'Error',
            'File ${image.name} melebihi 5MB',
            snackPosition: SnackPosition.BOTTOM,
          );
          continue;
        }

        selectedFiles.add(UploadFile(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          file: file,
          fileName: image.name,
          fileType: 'image',
          fileSize: fileSize,
        ));
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memilih gambar: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Pick documents (PDF, Excel, etc.)
  Future<void> pickDocuments() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'xlsx', 'xls', 'doc', 'docx'],
        allowMultiple: true,
      );

      if (result != null) {
        for (var platformFile in result.files) {
          if (platformFile.path == null) continue;

          final file = File(platformFile.path!);
          final fileSize = await file.length();

          // Validate file size (5MB max)
          if (fileSize > 5 * 1024 * 1024) {
            Get.snackbar(
              'Error',
              'File ${platformFile.name} melebihi 5MB',
              snackPosition: SnackPosition.BOTTOM,
            );
            continue;
          }

          String fileType = 'pdf';
          if (platformFile.extension == 'xlsx' || platformFile.extension == 'xls') {
            fileType = 'excel';
          } else if (platformFile.extension == 'doc' || platformFile.extension == 'docx') {
            fileType = 'doc';
          }

          selectedFiles.add(UploadFile(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            file: file,
            fileName: platformFile.name,
            fileType: fileType,
            fileSize: fileSize,
          ));
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memilih dokumen: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Remove file
  void removeFile(String fileId) {
    selectedFiles.removeWhere((file) => file.id == fileId);
  }

  // Save uploaded item
  void saveUploadedItem() {
    // Validate
    if (selectedFiles.isEmpty) {
      Get.snackbar(
        'Error',
        'Pilih minimal 1 file',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (nominalController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Nominal harus diisi',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Parse nominal
    final nominal = CurrencyFormatter.parseFromRupiah(nominalController.text);
    if (nominal == 0) {
      Get.snackbar(
        'Error',
        'Nominal tidak valid',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Create uploaded item
    final item = UploadedItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      files: List.from(selectedFiles),
      nominal: nominal,
      keterangan: keteranganController.text,
    );

    uploadedItems.add(item);

    // Clear form
    selectedFiles.clear();
    nominalController.clear();
    keteranganController.clear();

    Get.back();
    Get.snackbar(
      'Berhasil',
      'Data berhasil disimpan',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    detailController.dispose();
    nominalController.dispose();
    keteranganController.dispose();
    super.onClose();
  }
}
