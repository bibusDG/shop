import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/product_categories/domain/repositories/product_category_repo.dart';

class ModifyProductCategoryUseCase implements UseCasesWithParams<void, ModifyProductCategoryParams>{
  final ProductCategoryRepo productCategoryRepo;
  const ModifyProductCategoryUseCase({required this.productCategoryRepo});

  @override
  Future<Either<Failure, void>> call(params) async{

    return await productCategoryRepo.modifyProductCategory(
        categoryName: params.productCategoryName,
        categoryPicture: params.productCategoryPicture,
        productCategoryID: params.productCategoryID);

    // TODO: implement call
    throw UnimplementedError();
  }
}

class ModifyProductCategoryParams extends Equatable{
  final String productCategoryName;
  final String productCategoryPicture;
  final String productCategoryID;
  const ModifyProductCategoryParams({
    required this.productCategoryID,
    required this.productCategoryPicture,
    required this.productCategoryName,
  });

  const ModifyProductCategoryParams.empty() : this(
    productCategoryID: 'productCategoryID',
    productCategoryPicture: 'productCategoryPicture',
    productCategoryName: 'productCategoryName'
  );

  @override
  List<Object> get props => [productCategoryID];

}