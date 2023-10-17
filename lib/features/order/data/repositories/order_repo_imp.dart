import 'package:dartz/dartz.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/features/order/data/datasources/order_data_source.dart';
import 'package:shop/features/order/domain/repositories/order_repo.dart';
import 'package:shop/features/order/order_failures.dart';

class OrderRepoImp implements OrderRepo{
  final OrderDataSource dataSource;
  OrderRepoImp({required this.dataSource});

  @override
  Future<Either<Failure, void>> createOrder({
    required String orderID,
    required String userEmail,
    required String orderNumber,
    required String orderStatus,
    required String orderTime,
    required double orderPrice,
    required String paymentMethod,
    required String deliveryAddress}) async{
      try{
        final result = dataSource.createOrder(
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
      final result = dataSource.modifyOrderByAdmin(
          orderStatus: orderStatus,
          orderID: orderID);
      return Right(result);
    }catch(error){
      return const Left(UpdateOrderByAdminFailure(failureMessage: 'Unable to update failure status'));
    };
    // TODO: implement modifyOrderByAdmin
    throw UnimplementedError();
  }
}