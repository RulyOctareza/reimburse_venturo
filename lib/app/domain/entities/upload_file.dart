import 'dart:io';

/// Entity representing an uploaded file
class UploadFile {
  final String id;
  final File file;
  final String fileName;
  final String fileType; // image, pdf, excel, doc
  final int fileSize; // in bytes

  UploadFile({
    required this.id,
    required this.file,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
  });
}
