import 'package:dartz/dartz.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/features/product/product_failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repo.dart';
import '../datasources/product_data_source.dart';

class ProductRepoImp implements ProductRepo{
  final  ProductDataSource productDataSource;
  const ProductRepoImp({required this.productDataSource});

  @override
  Future<Either<Failure, void>> addProduct({
    required String productCategory, 
    required String productName, 
    required String productDescription, 
    required double productPrice, 
    required List<String> productGallery, 
    required int productAvailability, 
    required String productID}) async{
    final result = productDataSource.addProduct(
        productCategory: productCategory, 
        productName: productName, 
        productDescription: productDescription, 
        productPrice: productPrice, 
        productGallery: productGallery, 
        productAvailability: productAvailability, 
        productID: productID);
    try{
      return Right(result);
    }catch(error){
      return const Left(AddProductFailure(failureMessage: 'Unable to add new product'));
    }
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteProduct({required String productID}) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Stream<List<Product>>>> fetchProducts({required String productCategory}) {
    // TODO: implement fetchProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> getProduct({required String productID}) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> modifyProduct({required String productCategory, required String productName, required String productDescription, required double productPrice, required List<String> productGallery, required int productAvailability, required String productID}) {
    // TODO: implement modifyProduct
    throw UnimplementedError();
  }
}