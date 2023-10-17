import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/order/domain/repositories/order_repo.dart';

class UpdateOrderByAdminUseCase implements UseCasesWithParams<void, UpdateOrderParams>{
  final OrderRepo orderRepo;
  UpdateOrderByAdminUseCase({required this.orderRepo});

  @override
  Future<Either<Failure, void>> call(params) async{
    return await orderRepo.modifyOrderByAdmin(
        orderStatus: params.orderStatus,
        orderID: params.orderID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class UpdateOrderParams extends Equatable{
  final String orderID;
  final String orderStatus;
  const UpdateOrderParams({
    required this.orderID,
    required this.orderStatus,
});

  const UpdateOrderParams.empty() : this(
    orderStatus: 'orderStatus',
    orderID: 'orderID'
  );

  @override
  List<Object> get props => [orderStatus, orderID];

}