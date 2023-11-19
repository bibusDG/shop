import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/stripe_payments/domain/repositories/payment_repo.dart';

class DisplayPaymentSheetUseCase implements UseCasesWithParams<void, DisplaySheetParams>{
  final PaymentRepo repo;
  const DisplayPaymentSheetUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(DisplaySheetParams params) async{
    return await repo.displayPaymentSheet(
        successText: params.successText,
        failureText: params.failureText);
    // TODO: implement call
    throw UnimplementedError();
  }
}


class DisplaySheetParams extends Equatable{
  final String successText;
  final String failureText;
  const DisplaySheetParams({
    required this.failureText,
    required this.successText,
});

  const DisplaySheetParams.empty() : this(
    successText: 'successText',
    failureText: 'failureText',
  );

  @override
  List<Object> get props => [failureText, successText];
}
