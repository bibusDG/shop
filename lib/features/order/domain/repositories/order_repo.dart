import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';

abstract class OrderRepo{
  const OrderRepo();

  Future<Either<Failure, void>> createOrder({
    required String orderID,
    required String userEmail,
    required String orderNumber,
    required String orderStatus,
    required String orderTime,
    required double orderPrice,
    required String paymentMethod,
    required String deliveryAddress,
});


  Future<Either<Failure, void>> modifyOrderByAdmin({
    required String orderStatus,
    required String orderID,
});

}