import 'package:dartz/dartz.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/features/product_categories/data/datasources/product_category_data_source.dart';
import 'package:shop/features/product_categories/domain/entities/product_category.dart';
import 'package:shop/features/product_categories/domain/repositories/product_category_repo.dart';
import 'package:shop/features/product_categories/product_category_failure.dart';

class ProductCategoryRepoImp implements ProductCategoryRepo{
  final ProductCategoryDataSource productCategoryDataSource;
  const ProductCategoryRepoImp({required this.productCategoryDataSource});

  @override
  Future<Either<Failure, void>> addNewCategory({
    required String productCategoryID,
    required String categoryName,
    required String categoryPicture}) async{
    try{
      final result = await productCategoryDataSource.createProductCategory(
          productCategoryName: categoryName,
          productCategoryPicture: categoryPicture,
          productCategoryID: productCategoryID);
      return Right(result);
    }catch(error){
      return const Left(CreateProductCategoryFailure(failureMessage: 'Unable to create product category'));
    }
    // TODO: implement addNewCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteProductCategory({required String productCategoryID}) async{
    try{
      final result = await productCategoryDataSource.deleteProductCategory(productCategoryID: productCategoryID);
      return Right(result);
    }catch(error){
      return const Left(DeleteProductCategoryFailure(failureMessage: 'Unable to delete product category'));
    }
    // TODO: implement deleteProductCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> modifyProductCategory({
    required String categoryName,
    required String categoryPicture,
    required String productCategoryID}) async{
    try{
      final result = await productCategoryDataSource.modifyProductCategory(
          productCategoryName: categoryName,
          productCategoryPicture: categoryPicture,
          productCategoryID: productCategoryID);
      return Right(result);
    }catch(error){
      return const Left(UpdateProductCategoryFailure(failureMessage: 'Unable to update product category'));
    }
    // TODO: implement modifyProductCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Stream<List<ProductCategory>>>> streamProductCategories() async{
    try{
      final result = productCategoryDataSource.streamProductCategory();
      return Right(result);
    }catch(error){
      return const Left(StreamProductCategoryFailure(failureMessage: 'Unable to stream product categories'));
    }
    // TODO: implement streamProductCategories
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProductCategory>> getProductCategory({required String productCategoryID}) async{
    try{
      final result = await productCategoryDataSource.getProduct(productCategoryID: productCategoryID);
      return Right(result);
    }catch(error){
      return const Left(GetProductCategoryFailure(failureMessage: 'Unable to get product category'));
    }
    // TODO: implement getProductCategory
    throw UnimplementedError();
  }
}