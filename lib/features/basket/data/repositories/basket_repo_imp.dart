import 'package:dartz/dartz.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/features/basket/basket_failures.dart';
import 'package:shop/features/basket/data/datasources/basket_data_source.dart';
import 'package:shop/features/basket/domain/repositories/basket_repo.dart';

import '../../../product/domain/entities/product.dart';

class BasketRepoImp implements BasketRepo{
  final BasketDataSource basketDataSource;
  const BasketRepoImp({required this.basketDataSource});

  @override
  Future<Either<Failure, void>> addElementToBasket({
    required String productID,
    required String productCategory,
    required String productName,
    required String productDescription,
    required double productPrice,
    required List<String> productGallery,
    required int productAvailability}) async{
    try{
      final result = await basketDataSource.addProductToBasket(
          productID: productID,
          productCategory: productCategory,
          productDescription: productDescription,
          productAvailability: productAvailability,
          productPrice: productPrice,
          productGallery: productGallery,
          productName: productName);
      return Right(result);
    }catch(error){
      return const Left(AddToBasketFailure(failureMessage: 'Unable to add product to basket'));
    }
    // TODO: implement addElementToBasket
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> removeElementFromBasket({
    required String productID}) async{
    try{
      final result = await basketDataSource.removeProductFromBasket(productID: productID);
      return Right(result);
    }catch(error){
      return const Left(RemoveFromBasketFailure(failureMessage: 'Unable to remove product from basket'));
    }
    // TODO: implement removeElementFromBasket
    throw UnimplementedError();
  }




}