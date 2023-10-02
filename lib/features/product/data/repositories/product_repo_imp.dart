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
    try{
      final result = await productDataSource.addProduct(
          productCategory: productCategory,
          productName: productName,
          productDescription: productDescription,
          productPrice: productPrice,
          productGallery: productGallery,
          productAvailability: productAvailability,
          productID: productID);
      return Right(result);
    }catch(error){
      return const Left(AddProductFailure(failureMessage: 'Unable to add new product'));
    }
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteProduct({required String productID}) async{
    try{
      final result = await productDataSource.deleteProduct(productID: productID);
      return Right(result);
    }catch(error){
      return const Left(DeleteProductFailure(failureMessage: 'Unable to delete product'));
    }
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Stream<List<Product>>>> fetchProducts({required String productCategory}) async{
    try{
      final result =  productDataSource.streamProducts(productCategory: productCategory);
      return Right(result);
    }catch(error){
      return const Left(StreamProductFailure(failureMessage: 'Unable to stream products'));
    }
    // TODO: implement fetchProducts
    throw UnimplementedError();
  }
  @override
  Future<Either<Failure, Product>> getProduct({required String productID}) async{
    try{
      final result = await productDataSource.getProduct(productID: productID);
      return Right(result);
    }catch(error){
      return const Left(GetProductFailure(failureMessage: 'Unable to get product'));
    }
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> modifyProduct({
    required String productCategory,
    required String productName,
    required String productDescription,
    required double productPrice,
    required List<String> productGallery,
    required int productAvailability,
    required String productID}) async{
    try{
      final result = await productDataSource.modifyProduct(
          productCategory: productCategory,
          productName: productName,
          productDescription: productDescription,
          productPrice: productPrice,
          productGallery: productGallery,
          productAvailability: productAvailability,
          productID: productID);
      return Right(result);
    }catch(error){
      return const Left(UpdateProductFailure(failureMessage: 'Unable to update product'));
    }

    // TODO: implement modifyProduct
    throw UnimplementedError();
  }
}