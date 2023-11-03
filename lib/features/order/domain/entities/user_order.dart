import 'package:equatable/equatable.dart';

import '../../../basket/domain/entities/basket.dart';

class UserOrder extends Equatable{
  final String userID;
  final String userMobile;
  final String deliveryMethod;
  final List<String> orderedProducts;


  final String orderID;
  final String userEmail;
  final String orderNumber;
  final String orderStatus;
  final String orderTime;
  final double orderPrice;
  final String paymentMethod;
  final String deliveryAddress;

  const UserOrder({
    required this.userMobile,
    required this.deliveryMethod,
    required this.orderedProducts,
    required this.userID,


    required this.orderID,
    required this.userEmail,
    required this.orderStatus,
    required this.orderNumber,
    required this.deliveryAddress,
    required this.orderPrice,
    required this.orderTime,
    required this.paymentMethod,
});

  const UserOrder.empty() : this(
    userID: 'userID',
    orderTime: 'orderTime',
    orderStatus: 'orderStatus',
    orderPrice: 0.0,
    orderNumber: 'orderNumber',
    orderID: 'orderID',
    paymentMethod: 'paymentMethod',
    deliveryAddress: 'deliveryAddress',
    userEmail: 'userEmail',


    userMobile: 'userMobile',
    deliveryMethod: 'deliveryMethod',
    orderedProducts: const [],
  );

  @override
  List<Object> get props => [orderNumber, orderID];

}