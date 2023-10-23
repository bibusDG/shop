import 'package:dartz/dartz.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/features/order/data/datasources/user_order_data_source.dart';
import 'package:shop/features/order/domain/repositories/user_order_repo.dart';
import 'package:shop/features/order/order_failures.dart';
import 'package:shop/features/order/domain/entities/user_order.dart';

import '../../../basket/data/models/basket_model.dart';
import '../../../basket/domain/entities/basket.dart';

class UserOrderRepoImp implements UserOrderRepo{
  final UserOrderDataSource dataSource;
  UserOrderRepoImp({required this.dataSource});

  @override
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
    required String deliveryAddress}) async{
    try{
      final result = await dataSource.createOrder(

          userMobile: userMobile,
          deliveryMethod: deliveryMethod,
          orderedProducts: orderedProducts,

          orderID: orderID,
          userEmail: userEmail,
          orderNumber: orderNumber,
          orderStatus: orderStatus,
          orderTime: orderTime,
          orderPrice: orderPrice,
          paymentMethod: paymentMethod,
          deliveryAddress: deliveryAddress);
      return Right(result);
    }catch(error){
      return const Left(CreateOrderFailure(failureMessage: 'Unable to create new order'));
    }
    // TODO: implement createOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> modifyOrderByAdmin({
    required String orderStatus,
    required String orderID}) async{
    try{
      final result = await dataSource.modifyOrderByAdmin(
          orderStatus: orderStatus,
          orderID: orderID);
      return Right(result);
    }catch(error){
      return const Left(UpdateOrderByAdminFailure(failureMessage: 'Unable to update failure status'));
    }
    // TODO: implement modifyOrderByAdmin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Stream<List<UserOrder>>>> streamOrders({
    required String userEmail, required bool isAdmin}) async {
    try{
      final result = dataSource.streamOrders(userEmail: userEmail, isAdmin: isAdmin);
      return Right(result);
    }catch(error){
      return const Left(StreamOrderFailure(failureMessage: 'Unable to stream orders'));
    }

    // TODO: implement streamOrders
    throw UnimplementedError();
  }
}