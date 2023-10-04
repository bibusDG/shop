import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../../../product/domain/entities/product.dart';

abstract class BasketRepo{
  const BasketRepo();

  Future<Either<Failure, Stream<List<Product>>>> removeElementFromBasket({
    required String productID,
  });

  Future<Either<Failure, void>> addElementToBasket({
    required String productID,
});

}