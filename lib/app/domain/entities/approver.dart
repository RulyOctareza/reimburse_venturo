class Approver {
  final String id;
  final String name;
  final String jobTitle;
  final String status; // 'pending' or 'approved'
  final String? approvalDate; // for approved status

  Approver({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.status,
    this.approvalDate,
  });
}
