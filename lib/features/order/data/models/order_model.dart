import 'dart:convert';

import '../../domain/entities/order.dart';

class OrderModel extends Order{
  const OrderModel({
    required super.orderID,
    required super.userEmail,
    required super.orderNumber,
    required super.paymentMethod,
    required super.orderTime,
    required super.orderPrice,
    required super.deliveryAddress,
    required super.orderStatus,
});

  const OrderModel.empty() : this(
    orderID: 'orderID',
    orderNumber: 'orderNumber',
    paymentMethod: 'paymentMethod',
    orderPrice: 0.0,
    deliveryAddress: 'deliveryAddress',
    orderStatus: 'orderStatus',
    userEmail: 'userEmail',
    orderTime: 'orderTime'
  );

  OrderModel copyWith({
    String? orderID,
    String? orderNumber,
    String? userEmail,
    String? paymentMethod,
    String? orderStatus,
    double? orderPrice,
    String? orderTime,
    String? deliveryAddress,
  }) =>
      OrderModel(
        orderID: orderID ?? this.orderID,
        orderNumber: orderNumber ?? this.orderNumber,
        userEmail: userEmail ?? this.userEmail,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        orderStatus: orderStatus ?? this.orderStatus,
        orderPrice: orderPrice ?? this.orderPrice,
        orderTime: orderTime ?? this.orderTime,
        deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      );

  factory OrderModel.fromRawJson(String str) => OrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderID: json["orderID"],
    orderNumber: json["orderNumber"],
    userEmail: json["userEmail"],
    paymentMethod: json["paymentMethod"],
    orderStatus: json["orderStatus"],
    orderPrice: json["orderPrice"],
    orderTime: json["orderTime"],
    deliveryAddress: json["deliveryAddress"],
  );

  Map<String, dynamic> toJson() => {
    "orderID" : orderID,
    "orderNumber": orderNumber,
    "userEmail": userEmail,
    "paymentMethod": paymentMethod,
    "orderStatus": orderStatus,
    "orderPrice": orderPrice,
    "orderTime": orderTime,
    "deliveryAddress": deliveryAddress,
  };

}