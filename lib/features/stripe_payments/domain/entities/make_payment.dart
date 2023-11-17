// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
//
// class MakePayment extends Equatable{
//   final String intentAmount;
//   final String intentCurrency;
//   final String? gPayCountryCode;
//   final String? gPayCurrencyCode;
//   const MakePayment({
//     required this.intentAmount,
//     required this.intentCurrency,
//     this.gPayCountryCode,
//     this.gPayCurrencyCode
// });
//
//   const MakePayment.empty() : this(
//     intentAmount: 'intentAmount',
//     intentCurrency: 'intentCurrency',
//     gPayCurrencyCode: 'gPayCurrencyCode',
//     gPayCountryCode: 'gPayCountryCode',
//   );
//
//   @override
//   List<Object> get props => [intentAmount, intentCurrency];
// }