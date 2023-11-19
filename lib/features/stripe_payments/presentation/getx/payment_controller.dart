import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:shop/features/stripe_payments/domain/usecases/create_payment_intent_usecase.dart';
import 'package:shop/features/stripe_payments/domain/usecases/display_payment_sheet_usecase.dart';
import 'package:shop/features/stripe_payments/domain/usecases/init_payment_sheet_usecase.dart';
import 'package:shop/features/stripe_payments/domain/usecases/update_user_order_payment_status_usecase.dart';

class PaymentController extends GetxController{
  final CreatePaymentIntentUseCase createPaymentIntentUseCase;
  final DisplayPaymentSheetUseCase displayPaymentSheetUseCase;
  final UpdateUserOrderPaymentStatusUseCase updateUserOrderPaymentStatusUseCase;
  final InitPaymentSheetUseCase initPaymentSheetUseCase;
  PaymentController({
    required this.initPaymentSheetUseCase,
    required this.updateUserOrderPaymentStatusUseCase,
    required this.displayPaymentSheetUseCase,
    required this.createPaymentIntentUseCase,
});

  dynamic intent = '';

  Future<dynamic> createPaymentIntent() async{
    final result = await createPaymentIntentUseCase(
          IntentParams(
            contentType: '${dotenv.env['CONTENT_TYPE']}',
            authTestKey: 'Bearer ${dotenv.env['AUTH_KEY']}',
            intentCurrency: INTENT_CURRENCY,
            intentAmount: INTENT_AMOUNT));
    result.fold((failure){
      return Get.snackbar('title', 'message');
    }, (result){
      intent = result;
      // return result;
    });
  }

  Future<void> displayPaymentSheet() async{
    final result = await displayPaymentSheetUseCase(const DisplaySheetParams(
        failureText: 'payment failed',
        successText: 'OK'));
    result.fold((failed){}, (result){});
  }

  Future<void> initPaymentSheet({paymentIntent}) async{
    final result = await initPaymentSheetUseCase(
        PaymentInitParams(
            clientSecretKey: paymentIntent!['client_secret'],
            merchantDisplayName: 'mal0ry'));
    result.fold((failure){}, (result){});
  }

}