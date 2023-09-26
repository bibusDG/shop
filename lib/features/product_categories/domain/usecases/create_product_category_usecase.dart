import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/product_categories/domain/repositories/product_category_repo.dart';

class CreateProductCategoryUseCase implements UseCasesWithParams<void, CreateProductCategoryUseCaseParams>{
  final ProductCategoryRepo productCategoryRepo;
  const CreateProductCategoryUseCase({required this.productCategoryRepo});
  @override
  Future<Either<Failure, void>> call(CreateProductCategoryUseCaseParams params) async{
    return await productCategoryRepo.addNewCategory(
        categoryName: params.productCategoryName,
        categoryPicture: params.productCategoryPicture,
        productCategoryID: params.productCategoryID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class CreateProductCategoryUseCaseParams extends Equatable{
  final String productCategoryName;
  final String productCategoryPicture;
  final String productCategoryID;
  const CreateProductCategoryUseCaseParams({
    required this.productCategoryName,
    required this.productCategoryPicture,
    required this.productCategoryID,
});

  const CreateProductCategoryUseCaseParams.empty() : this(
    productCategoryID: 'productCategoryID',
    productCategoryName: 'productCategoryName',
    productCategoryPicture: 'productCategoryPicture',
  );

  @override
  List<Object> get props =>[productCategoryID];
}