import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../../../product/domain/entities/product.dart';

abstract class BasketRepo{
  const BasketRepo();

  Future<Either<Failure, void>> removeElementFromBasket({
    required String productID,
  });

  Future<Either<Failure, void>> addElementToBasket({
    required String productCategory,
    required String productName,
    required String productDescription,
    required double productPrice,
    required List<String> productGallery,
    required int productAvailability,
    required String productID
});

}

