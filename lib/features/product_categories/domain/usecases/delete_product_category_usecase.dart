import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/product_categories/domain/repositories/product_category_repo.dart';

class DeleteProductCategoryUseCase implements UseCasesWithParams<void, DeleteProductCategoryParams>{
  final ProductCategoryRepo productCategoryRepo;
  const DeleteProductCategoryUseCase({required this.productCategoryRepo});

  @override
  Future<Either<Failure, void>> call(DeleteProductCategoryParams params) async{

    return await productCategoryRepo.deleteProductCategory(
        productCategoryID: params.productCategoryID);

    // TODO: implement call
    // throw UnimplementedError();
  }}

class DeleteProductCategoryParams extends Equatable{
  final String productCategoryID;
  const DeleteProductCategoryParams({
    required this.productCategoryID,
});

  const DeleteProductCategoryParams.empty() : this(
    productCategoryID: 'productCategoryID'
  );

  @override
  List<Object> get props => [productCategoryID];

}