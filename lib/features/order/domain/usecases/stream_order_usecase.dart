import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/order/domain/repositories/user_order_repo.dart';

class StreamOrdersUseCase implements UseCasesWithParams<Stream, StreamOrderParams>{
  final UserOrderRepo repo;
  StreamOrdersUseCase({required this.repo});

  @override
  Future<Either<Failure, Stream>> call(params) async{
    return await repo.streamOrders(
        userEmail: params.userEmail,
        isAdmin: params.isAdmin);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class StreamOrderParams extends Equatable{
  final String userEmail;
  final bool isAdmin;
  const StreamOrderParams({
    required this.userEmail,
    required this.isAdmin});

  const StreamOrderParams.empty() : this(
    userEmail: 'userEmail',
    isAdmin: true,
  );

  @override
  List<Object> get props => [userEmail, isAdmin];

}