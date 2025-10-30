import 'dart:io';

class UploadFile {
  final String id;
  final File file;
  final String fileName;
  final String fileType; // image, pdf, excel
  final int fileSize;

  UploadFile({
    required this.id,
    required this.file,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
  });
}
