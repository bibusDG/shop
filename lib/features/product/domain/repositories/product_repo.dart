import 'package:dartz/dartz.dart';

import '../../../../../core/failures/failure.dart';
import '../entities/product.dart';

abstract class ProductRepo{
  const ProductRepo();

  Future<Either<Failure, void>> addProduct({
    required String productCategory,
    required String productName,
    required String productDescription,
    required double productPrice,
    required List<String> productGallery,
    required int productAvailability,
    required String productID,});

  Future<Either<Failure, void>> deleteProduct({
    required String productID,
  });

  Future<Either<Failure, void>> modifyProduct({
    required String productCategory,
    required String productName,
    required String productDescription,
    required double productPrice,
    required List<String> productGallery,
    required int productAvailability,
    required String productID,
  });

  Future<Either<Failure, Product>> getProduct({
  required String productID,
  });

  Future<Either<Failure, Stream<List<Product>>>> fetchProducts({
    required String productCategory,
  });

}