import 'package:shop/features/basket/data/datasources/local_data_base.dart';

import '../../../product/data/models/product_model.dart';

abstract class BasketDataSource{
  const BasketDataSource();

  Future<void> addProductToBasket({
    required String productID,
    required String productCategory,
    required String productDescription,
    required int productAvailability,
    required double productPrice,
    required List<String> productGallery,
    required String productName,
  });

  Future<void> removeProductFromBasket({
  required String productID,
});
}


class BasketDataSourceImp implements BasketDataSource{
  final LocalDataBase dataBase;
  const BasketDataSourceImp({required this.dataBase});
  // final Map<dynamic, dynamic> localDataBase = {};

  @override
  Future<void> addProductToBasket({
    required String productID,
    required String productCategory,
    required String productDescription,
    required int productAvailability,
    required double productPrice,
    required List<String> productGallery,
    required String productName}) async{
    dataBase.localDataBase[productID] =  ProductModel(
        productCategory: productCategory,
        productName: productName,
        productPrice: productPrice,
        productAvailability: productAvailability,
        productDescription: productDescription,
        productGallery: productGallery,
        productID: productID).toJson();
    print(dataBase);
    // TODO: implement addProductToBasket
    // throw UnimplementedError();
  }

  @override
  Future<void> removeProductFromBasket({required String productID}) async{
    dataBase.localDataBase.remove(productID);
    // TODO: implement removeProductFromBasket
    // throw UnimplementedError();
  }




}