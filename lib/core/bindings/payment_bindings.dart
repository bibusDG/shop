import 'package:get/get.dart';
import 'package:shop/features/stripe_payments/data/datasources/payment_data_source.dart';
import 'package:shop/features/stripe_payments/data/repositories/payment_repo_imp.dart';
import 'package:shop/features/stripe_payments/domain/repositories/payment_repo.dart';
import 'package:shop/features/stripe_payments/domain/usecases/create_payment_intent_usecase.dart';
import 'package:shop/features/stripe_payments/domain/usecases/display_payment_sheet_usecase.dart';
import 'package:shop/features/stripe_payments/domain/usecases/init_payment_sheet_usecase.dart';
import 'package:shop/features/stripe_payments/domain/usecases/update_user_order_payment_status_usecase.dart';
import 'package:shop/features/stripe_payments/presentation/getx/payment_controller.dart';

class PaymentBindings implements Bindings{
  @override
  void dependencies() {

    Get.lazyPut<PaymentDataSource>(() => PaymentDataSourceImp());
    Get.lazyPut<PaymentRepo>(() => PaymentRepoImp(dataSource: Get.find()));
    Get.lazyPut(() => CreatePaymentIntentUseCase(repo: Get.find()));
    Get.lazyPut(() => DisplayPaymentSheetUseCase(repo: Get.find()));
    Get.lazyPut(() => InitPaymentSheetUseCase(repo: Get.find()));
    Get.lazyPut(() => UpdateUserOrderPaymentStatusUseCase(repo: Get.find()));
    Get.lazyPut(() => PaymentController(
        createPaymentIntentUseCase: Get.find(),
        displayPaymentSheetUseCase: Get.find(),
        initPaymentSheetUseCase: Get.find(),
        updateUserOrderPaymentStatusUseCase: Get.find()));
    // TODO: implement dependencies
  }

}