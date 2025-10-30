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
    return {
      'id': id,
      'title': title,
      'requesterName': requesterName,
    };
  }

  // Dummy data
  static List<ReimbursementItem> getDummyData() {
    return [
      ReimbursementModel(
        id: '1',
        title: 'Pembelian Alat Kantor',
        requesterName: 'John Doe',
      ),
      ReimbursementModel(
        id: '2',
        title: 'Transportasi Meeting Client',
        requesterName: 'Jane Smith',
      ),
      ReimbursementModel(
        id: '3',
        title: 'Akomodasi Perjalanan Dinas',
        requesterName: 'Bob Johnson',
      ),
      ReimbursementModel(
        id: '4',
        title: 'Pembelian Laptop',
        requesterName: 'Alice Williams',
      ),
      ReimbursementModel(
        id: '5',
        title: 'Biaya Internet Bulanan',
        requesterName: 'Charlie Brown',
      ),
      ReimbursementModel(
        id: '6',
        title: 'Konsumsi Rapat Tim',
        requesterName: 'David Lee',
      ),
      ReimbursementModel(
        id: '7',
        title: 'Pembelian Alat Tulis',
        requesterName: 'Emma Davis',
      ),
      ReimbursementModel(
        id: '8',
        title: 'Biaya Parkir Kantor',
        requesterName: 'Frank Miller',
      ),
    ];
  }
}
