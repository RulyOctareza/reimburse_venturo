import 'package:get/get.dart';
import 'package:reimburse_venturo/app/data/models/reimbursement_model.dart';
import 'package:reimburse_venturo/app/domain/entities/reimbursement_item.dart';

class ReimbursementListController extends GetxController {
  final RxList<ReimbursementItem> reimbursements = <ReimbursementItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadReimbursements();
  }

  void loadReimbursements() {
    reimbursements.value = ReimbursementModel.getDummyData();
  }
}
