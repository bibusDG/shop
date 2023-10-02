import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/product/domain/repositories/product_repo.dart';

class UpdateProductUseCase implements UseCasesWithParams<void, UpdateProductParams>{
  final ProductRepo productRepo;
  const UpdateProductUseCase({required this.productRepo});

  @override
  Future<Either<Failure, void>> call(UpdateProductParams params) async{
    return await productRepo.modifyProduct(
        productCategory: params.productCategory,
        productName: params.productName,
        productDescription: params.productDescription,
        productPrice: params.productPrice,
        productGallery: params.productGallery,
        productAvailability: params.productAvailability,
        productID: params.productID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class UpdateProductParams extends Equatable{
  final String productName;
  final String productDescription;
  final double productPrice;
  final int productAvailability;
  final String productID;
  final List<String> productGallery;
  final String productCategory;

  const UpdateProductParams({
    required this.productID,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productAvailability,
    required this.productGallery,
    required this.productCategory,
});

  UpdateProductParams.empty() : this(
    productCategory: 'productCategory',
    productPrice: 0.0,
    productGallery: [],
    productDescription: 'productDescription',
    productName: 'productName',
    productAvailability: 0,
    productID: 'productID'
  );

  @override
  List<Object> get props => [productID, productName];

}