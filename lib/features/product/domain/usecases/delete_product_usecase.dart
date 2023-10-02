import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/product/domain/repositories/product_repo.dart';

class DeleteProductUseCase implements UseCasesWithParams<void, DeleteProductParams>{
  final ProductRepo productRepo;
  const DeleteProductUseCase({required this.productRepo});

  @override
  Future<Either<Failure, void>> call(DeleteProductParams params) async{
    return await productRepo.deleteProduct(productID: params.productID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class DeleteProductParams extends Equatable{
  final String productID;
  const DeleteProductParams({required this.productID});
  const DeleteProductParams.empty() : this(
    productID: 'productID'
  );

  @override
  List<Object> get props => [productID];

}