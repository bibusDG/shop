import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../../../basket/domain/entities/basket.dart';
import '../entities/user_order.dart';

abstract class UserOrderRepo{
  const UserOrderRepo();

  Future<Either<Failure, void>> createOrder({
    required String userMobile,
    required String deliveryMethod,
    required List<String> orderedProducts,

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

  Future<Either<Failure, Stream<List<UserOrder>>>> streamOrders({
    required String userEmail,
    required bool isAdmin,
});

}