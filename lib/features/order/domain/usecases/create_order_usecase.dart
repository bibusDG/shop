import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/order/domain/repositories/user_order_repo.dart';

class CreateOrderUseCase implements UseCasesWithParams<void, CreateOrderParams>{
  final UserOrderRepo orderRepo;
  const CreateOrderUseCase({required this.orderRepo});

  @override
  Future<Either<Failure, void>> call(params) async{
    return await orderRepo.createOrder(
        orderID: params.orderID,
        userEmail: params.userEmail,
        orderNumber: params.orderNumber,
        orderStatus: params.orderStatus,
        orderTime: params.orderTime,
        orderPrice: params.orderPrice,
        paymentMethod: params.paymentMethod,
        deliveryAddress: params.deliveryAddress);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class CreateOrderParams extends Equatable{
  final String orderNumber;
  final String orderID;
  final String orderTime;
  final double orderPrice;
  final String userEmail;
  final String orderStatus;
  final String paymentMethod;
  final String deliveryAddress;
  const CreateOrderParams({
    required this.orderNumber,
    required this.orderStatus,
    required this.orderID,
    required this.orderPrice,
    required this.paymentMethod,
    required this.userEmail,
    required this.orderTime,
    required this.deliveryAddress,
  });

  const CreateOrderParams.empty() : this(
    orderID: 'orderID',
    orderNumber: 'orderNumber',
    orderPrice: 0.0,
    orderStatus: 'orderStatus',
    orderTime: 'orderTime',
    paymentMethod: 'paymentMethod',
    userEmail: 'userEmail',
    deliveryAddress: 'deliveryAddress',
  );

  @override
  List<Object?> get props => [orderNumber, orderID];
}