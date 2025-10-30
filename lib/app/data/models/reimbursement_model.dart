import 'package:reimburse_venturo/app/domain/entities/reimbursement_item.dart';

class ReimbursementModel extends ReimbursementItem {
  ReimbursementModel({
    required super.id,
    required super.title,
    required super.requesterName,
  });

  factory ReimbursementModel.fromJson(Map<String, dynamic> json) {
    return ReimbursementModel(
      id: json['id'] as String,
      title: json['title'] as String,
      requesterName: json['requesterName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'requesterName': requesterName};
  }

  // Dummy data - Nama kegiatan kantor
  static List<ReimbursementItem> getDummyData() {
    return [
      ReimbursementModel(
        id: '1',
        title: 'Seminar Pengembangan SDM',
        requesterName: 'HRD',
      ),
      ReimbursementModel(
        id: '2',
        title: 'Workshop Digital Marketing',
        requesterName: 'Marketing',
      ),
      ReimbursementModel(
        id: '3',
        title: 'Training Leadership',
        requesterName: 'HRD',
      ),
      ReimbursementModel(
        id: '4',
        title: 'Gathering Karyawan',
        requesterName: 'HRD',
      ),
      ReimbursementModel(
        id: '5',
        title: 'Rapat Koordinasi Bulanan',
        requesterName: 'Management',
      ),
      ReimbursementModel(
        id: '6',
        title: 'Konferensi Teknologi',
        requesterName: 'IT',
      ),
      ReimbursementModel(
        id: '7',
        title: 'Pelatihan Soft Skills',
        requesterName: 'HRD',
      ),
      ReimbursementModel(
        id: '8',
        title: 'Seminar Keuangan Perusahaan',
        requesterName: 'Finance',
      ),
      ReimbursementModel(
        id: '9',
        title: 'Workshop Product Development',
        requesterName: 'Product',
      ),
      ReimbursementModel(
        id: '10',
        title: 'Team Building Activity',
        requesterName: 'HRD',
      ),
      ReimbursementModel(
        id: '11',
        title: 'Expo Bisnis & Networking',
        requesterName: 'Business Development',
      ),
      ReimbursementModel(
        id: '12',
        title: 'Sosialisasi Kebijakan Baru',
        requesterName: 'Management',
      ),
    ];
  }
}
