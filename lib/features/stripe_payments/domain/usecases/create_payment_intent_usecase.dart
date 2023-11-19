import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/stripe_payments/domain/repositories/payment_repo.dart';

class CreatePaymentIntentUseCase implements UseCasesWithParams<dynamic, IntentParams>{
  final PaymentRepo repo;
  CreatePaymentIntentUseCase({required this.repo});

  @override
  Future<Either<Failure, dynamic>> call(IntentParams params) async{
    return await repo.createPaymentIntent(
        intentAmount: params.intentAmount,
        intentCurrency: params.intentCurrency,
        authTestKey: params.authTestKey,
        contentType: params.contentType);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class IntentParams extends Equatable{
  final String intentAmount;
  final String intentCurrency;
  final String authTestKey;
  final String contentType;
  const IntentParams({
    required this.contentType,
    required this.authTestKey,
    required this.intentCurrency,
    required this.intentAmount,
});

  const IntentParams.empty() : this(
    contentType: 'contentType',
    authTestKey: 'authTestKey',
    intentAmount: 'intentAmount',
    intentCurrency: 'intentCurrency',
  );

  @override
  List<Object> get props =>[contentType, authTestKey, intentAmount, intentCurrency];

}