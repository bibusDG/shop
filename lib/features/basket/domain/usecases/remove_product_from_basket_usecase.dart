import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/basket/domain/repositories/basket_repo.dart';

class RemoveProductFromBasketUseCase implements UseCasesWithParams<void, RemoveBasketParams>{
  final BasketRepo repo;
  RemoveProductFromBasketUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(RemoveBasketParams params) async{
    return await repo.removeElementFromBasket(productID: params.productID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class RemoveBasketParams extends Equatable{
  final String productID;
  const RemoveBasketParams({required this.productID});

  const RemoveBasketParams.empty() : this(
    productID: 'productID',
  );

  @override
  List<Object> get props => [productID];

}