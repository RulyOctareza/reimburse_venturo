import 'package:reimburse_venturo/app/domain/entities/upload_file.dart';

class UploadedItem {
  final String id;
  final List<UploadFile> files;
  final int nominal;
  final String keterangan;

  UploadedItem({
    required this.id,
    required this.files,
    required this.nominal,
    required this.keterangan,
  });
}
