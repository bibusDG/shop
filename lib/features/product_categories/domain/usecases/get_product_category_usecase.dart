import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/product_categories/domain/repositories/product_category_repo.dart';
import '../entities/product_category.dart';

class GetProductCategoryUseCase implements UseCasesWithParams<ProductCategory, GetProductCategoryParams>{
  final ProductCategoryRepo productCategoryRepo;
  const GetProductCategoryUseCase({required this.productCategoryRepo});

  @override
  Future<Either<Failure, ProductCategory>> call(GetProductCategoryParams params) async{
    return await productCategoryRepo.getProductCategory(productCategoryID: params.productCategoryID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class GetProductCategoryParams extends Equatable{
  final String productCategoryID;
  const GetProductCategoryParams({required this.productCategoryID});

  const GetProductCategoryParams.empty() : this(
    productCategoryID: 'productCategoryID'
  );

  @override
  List<Object> get props => [productCategoryID];

}