import 'package:reimburse_venturo/app/domain/entities/approver.dart';

class ApproverModel extends Approver {
  ApproverModel({
    required super.id,
    required super.name,
    required super.jobTitle,
    required super.status,
    super.approvalDate,
  });

  // Dummy data
  static List<Approver> getDummyData() {
    return [
      ApproverModel(
        id: '1',
        name: 'Yokema Meyer Van Persie',
        jobTitle: 'General Manager',
        status: 'approved',
        approvalDate: 'Sab, 1 Jun 2025',
      ),
      ApproverModel(
        id: '2',
        name: 'Francois Gigi Santo',
        jobTitle: 'Finance Head',
        status: 'pending',
      ),
      ApproverModel(
        id: '3',
        name: 'Ahmad Subarjo',
        jobTitle: 'Director',
        status: 'pending',
      ),
    ];
  }
}
