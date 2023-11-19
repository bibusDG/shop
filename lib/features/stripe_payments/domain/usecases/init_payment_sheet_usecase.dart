import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/stripe_payments/domain/repositories/payment_repo.dart';

class InitPaymentSheetUseCase implements UseCasesWithParams<void, PaymentInitParams>{
  final PaymentRepo repo;
  const InitPaymentSheetUseCase({required this.repo});
  @override
  Future<Either<Failure, void>> call(PaymentInitParams params) async{
    return await repo.initPaymentSheet(
        clientSecretKey: params.clientSecretKey,
        merchantDisplayName: params.merchantDisplayName);
    // TODO: implement call
    throw UnimplementedError();
  }

}

class PaymentInitParams extends Equatable{
  final String clientSecretKey;
  final String merchantDisplayName;
  const PaymentInitParams({
    required this.clientSecretKey,
    required this.merchantDisplayName,
});

  const PaymentInitParams.empty() : this(
    clientSecretKey: 'clientSecretKey',
    merchantDisplayName: 'merchantDisplayName'
  );
  @override
  List<Object> get props => [clientSecretKey, merchantDisplayName];
}