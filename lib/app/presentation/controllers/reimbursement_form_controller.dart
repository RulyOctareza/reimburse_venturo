import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:reimburse_venturo/app/domain/entities/upload_file.dart';

class ReimbursementFormController extends GetxController {
  // Form fields
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxString selectedClaimType = ''.obs;
  final TextEditingController detailController = TextEditingController();

  // Upload fields (for bottom sheet)
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final RxList<UploadFile> selectedFiles = <UploadFile>[].obs;

  final ImagePicker _imagePicker = ImagePicker();

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

  @override
  void onClose() {
    detailController.dispose();
    nominalController.dispose();
    keteranganController.dispose();
    super.onClose();
  }
}
