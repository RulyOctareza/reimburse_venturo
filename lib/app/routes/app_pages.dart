import 'package:get/get.dart';
import 'package:reimburse_venturo/app/presentation/controllers/reimbursement_list_controller.dart';
import 'package:reimburse_venturo/app/presentation/pages/reimbursement_list_page.dart';
import 'package:reimburse_venturo/app/routes/app_routes.dart';

class AppPages {
  static const initial = AppRoutes.reimbursementList;

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.reimbursementList,
      page: () => const ReimbursementListPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ReimbursementListController>(
          () => ReimbursementListController(),
        );
      }),
    ),
  ];
}
