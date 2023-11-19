import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';

abstract class PaymentRepo{
  const PaymentRepo();

  Future<Either<Failure, dynamic>> createPaymentIntent({
    required String intentAmount,
    required String intentCurrency,
    required String authTestKey,
    required String contentType,
});

  Future<Either<Failure, void>> displayPaymentSheet({
    required String successText,
    required String failureText,
});

  Future<Either<Failure, void>> initPaymentSheet({
    required String clientSecretKey,
    required String merchantDisplayName,
});

  Future<Either<Failure, void>> updateUserOrderPaymentStatus({
    required String userOrderID,
    required String paymentStatus,
});

}