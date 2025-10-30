import 'package:get/get.dart';

class ReimbursementFormController extends GetxController {
  // Form fields will be added in later phases
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxString selectedClaimType = ''.obs;
  final RxString detail = ''.obs;
}
