import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/stripe_payments/domain/repositories/payment_repo.dart';

class UpdateUserOrderPaymentStatusUseCase implements UseCasesWithParams<void, PaymentParams>{
  final PaymentRepo repo;
  UpdateUserOrderPaymentStatusUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(PaymentParams params) async{
    return await repo.updateUserOrderPaymentStatus(
        userOrderID: params.userOrderID,
        paymentStatus: params.paymentStatus);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class PaymentParams extends Equatable{
  final String userOrderID;
  final String paymentStatus;
  const PaymentParams({
    required this.paymentStatus,
    required this.userOrderID,
});

  const PaymentParams.empty() : this(
    paymentStatus: 'paymentStatus',
    userOrderID: 'userOrderID'
  );

  @override
  List<Object> get props => [paymentStatus, userOrderID];
}