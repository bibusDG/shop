import 'package:dartz/dartz.dart';
import 'package:shop/features/product_categories/domain/entities/product_category.dart';

import '../../../../core/failures/failure.dart';

abstract class ProductCategoryRepo{
  const ProductCategoryRepo();

  Future<Either<Failure, void>> addNewCategory({
    required String categoryName,
    required String categoryPicture,
});

  Stream<Either<Failure, List<ProductCategory>>> streamProductCategories();

  Future<Either<Failure, void>> modifyProductCategory({
    required String categoryName,
    required String categoryPicture,
    required String productCategoryID,
});

  Future<Either<Failure, void>> deleteProductCategory({
    required String productCategoryID,
});

}