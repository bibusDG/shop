import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/product/domain/repositories/product_repo.dart';

class CreateProductUseCase implements UseCasesWithParams<void, CreateProductParams>{
  final ProductRepo productRepo;
  const CreateProductUseCase({required this.productRepo});

  @override
  Future<Either<Failure, void>> call(CreateProductParams params) async{
    return await productRepo.addProduct(
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

class CreateProductParams extends Equatable{
  final String productName;
  final String productCategory;
  final double productPrice;
  final  String productDescription;
  final int productAvailability;
  final List<String> productGallery;
  final String productID;
  const CreateProductParams({
    required this.productCategory,
    required this.productID,
    required this.productGallery,
    required this.productAvailability,
    required this.productPrice,
    required this.productDescription,
    required this.productName,
});

  CreateProductParams.empty() : this(
    productPrice: 0.0,
    productID: 'productID',
    productGallery: [],
    productDescription: 'productDescription',
    productCategory: 'productCategory',
    productName: 'productName',
    productAvailability: 0
  );

  @override
  List<Object> get props => [productID, productName];
}