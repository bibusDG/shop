import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/basket/domain/repositories/basket_repo.dart';
import 'package:shop/features/product/domain/entities/product.dart';


class AddProductToBasketUseCase implements UseCasesWithParams<void, AddBasketParams>{
  final BasketRepo repo;
  const AddProductToBasketUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(AddBasketParams params) async{
    return await repo.addElementToBasket(
        productID: params.productID,
        productCategory: params.productCategory,
        productName: params.productName,
        productDescription: params.productDescription,
        productPrice: params.productPrice,
        productGallery: params.productGallery,
        productAvailability: params.productAvailability);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class AddBasketParams extends Equatable{
  final String productID;
  final String productDescription;
  final int productAvailability;
  final double productPrice;
  final List<String> productGallery;
  final String productCategory;
  final String productName;
  const AddBasketParams({
    required this.productID,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productAvailability,
    required this.productGallery,
    required this.productCategory,
  });

  const AddBasketParams.empty() : this(
    productID: 'productID',
    productCategory: 'productCategory',
    productPrice: 0.0,
    productGallery: const [],
    productDescription: 'productDescription',
    productName: 'productName',
    productAvailability: 0,
  );

  @override
  List<Object> get props => [productID];

}