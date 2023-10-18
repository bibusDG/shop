import 'dart:convert';

import '../../domain/entities/user_order.dart';

class UserOrderModel extends UserOrder{
  const UserOrderModel({
    required super.orderID,
    required super.userEmail,
    required super.orderNumber,
    required super.paymentMethod,
    required super.orderTime,
    required super.orderPrice,
    required super.deliveryAddress,
    required super.orderStatus,
});

  const UserOrderModel.empty() : this(
    orderID: 'orderID',
    orderNumber: 'orderNumber',
    paymentMethod: 'paymentMethod',
    orderPrice: 0.0,
    deliveryAddress: 'deliveryAddress',
    orderStatus: 'orderStatus',
    userEmail: 'userEmail',
    orderTime: 'orderTime'
  );

  UserOrderModel copyWith({
    String? orderID,
    String? orderNumber,
    String? userEmail,
    String? paymentMethod,
    String? orderStatus,
    double? orderPrice,
    String? orderTime,
    String? deliveryAddress,
  }) =>
      UserOrderModel(
        orderID: orderID ?? this.orderID,
        orderNumber: orderNumber ?? this.orderNumber,
        userEmail: userEmail ?? this.userEmail,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        orderStatus: orderStatus ?? this.orderStatus,
        orderPrice: orderPrice ?? this.orderPrice,
        orderTime: orderTime ?? this.orderTime,
        deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      );

  factory UserOrderModel.fromRawJson(String str) => UserOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserOrderModel.fromJson(Map<String, dynamic> json) => UserOrderModel(
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