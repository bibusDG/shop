import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/features/stripe_payments/data/datasources/payment_data_source.dart';
import 'package:shop/features/stripe_payments/domain/repositories/payment_repo.dart';
import 'package:shop/features/stripe_payments/stripe_failures.dart';

class PaymentRepoImp implements PaymentRepo{
 final PaymentDataSource dataSource;
 const PaymentRepoImp({required this.dataSource});

  @override
  Future<Either<Failure, dynamic>> createPaymentIntent({
    required String intentAmount,
    required String intentCurrency,
    required String authTestKey,
    required String contentType}) async{
    try{
      final result = await dataSource.createPaymentIntent(
          intentAmount: intentAmount,
          intentCurrency: intentCurrency,
          authTestKey: authTestKey,
          contentType: contentType);
      return Right(result);
    }catch(error){
      return const Left(CreatePaymentIntentFailure(failureMessage: 'Unable to create stripe intent'));
    }
    // TODO: implement createPaymentIntent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> displayPaymentSheet({
    required String successText,
    required String failureText}) async{
    try{
      await Stripe.instance.presentPaymentSheet().then((value){
        print(successText);
      });
      return const Right(null);
    }catch(error){
      return Left(DisplayPaymentSheetFailure(failureMessage: failureText));
    }
    // TODO: implement displayPaymentSheet
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> initPaymentSheet({
    required String clientSecretKey,
    required String merchantDisplayName}) async{
    try{
      var gPay = const PaymentSheetGooglePay(merchantCountryCode: 'PL', currencyCode: 'PLN', testEnv: true);
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecretKey,
        style: ThemeMode.light,
        merchantDisplayName: merchantDisplayName,
        googlePay: gPay
      )).then((value){});
      return const Right(null);
    }catch(error){
      return const Left(InitPaymentSheetFailure(failureMessage: 'Unable to init payment sheet'));
    }

    // TODO: implement initPaymentSheet
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateUserOrderPaymentStatus({
    required String userOrderID,
    required String paymentStatus}) async{
    try{
      final result = await dataSource.updateUserOrderPaymentStatus(
          userOrderID: userOrderID,
          paymentStatus: paymentStatus);
      return Right(result);
    }catch(error){
      return const Left(UpdateUserOrderPaymentStatusFailure(failureMessage: 'Unable to update order payment status'));
    }
    // TODO: implement updateUserOrderPaymentStatus
    throw UnimplementedError();
  }
}