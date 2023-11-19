import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:http/http.dart' as http;

abstract class PaymentDataSource{
  const PaymentDataSource();

  Future<void> updateUserOrderPaymentStatus({
    required String userOrderID,
    required String paymentStatus,
});

  Future<dynamic> createPaymentIntent({
    required String intentAmount,
    required String intentCurrency,
    required String authTestKey,
    required String contentType,
});

}

class PaymentDataSourceImp implements PaymentDataSource{
  @override
  Future<dynamic> createPaymentIntent({
    required String intentAmount,
    required String intentCurrency,
    required String authTestKey,
    required String contentType}) async{
    Map<String, dynamic> body = {
      "amount": intentAmount,
      "currency": intentCurrency,
      "payment_method_types[0]": 'blik',
      "payment_method_types[1]": 'card',
      "payment_method_types[2]": 'paypal',
    };
    final result = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': authTestKey,
        'Content-Type': contentType,
      },
      body: body,

    );
    print(json.decode(result.body));
    return json.decode(result.body);

    // TODO: implement createPaymentIntent
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserOrderPaymentStatus({
    required String paymentStatus,
    required String userOrderID}) async{
    await FirebaseFirestore.instance.collection('company').
    doc(COMPANY_NAME).
    collection('orders').doc(userOrderID).update({'paymentStatus' : paymentStatus});
    // TODO: implement updateUserOrderPaymentStatus
    throw UnimplementedError();
  }
}