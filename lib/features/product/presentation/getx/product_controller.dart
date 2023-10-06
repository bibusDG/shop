import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/features/product/domain/usecases/stream_product_usecase.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../../domain/usecases/get_product_usecase.dart';

class ProductController extends GetxController{
  final StreamProductUseCase streamProductUseCase;
  final GetProductUseCase getProductUseCase;
  final CreateProductUseCase createProductUseCase;
  ProductController({
    required this.streamProductUseCase,
    required this.getProductUseCase,
    required this.createProductUseCase,
});

  // String productID = '';
  String productCategory = '';
  Product productData = const Product.empty();


  Future<Product> getProduct({productID}) async{
    final result = await getProductUseCase(GetProductParams(productID: productID));
    result.fold((failure){
      return Get.defaultDialog();
    }, (result) async{
      productData = result;
    });
    return productData;
  }


  Stream<List<Product>> streamProducts() async*{
    // print(productCategory);
    final result = await streamProductUseCase(
        StreamProductParams(productCategory: productCategory));
    yield* result.fold((failure){
      return Stream.value([]);
    }, (stream){
      return stream;
    });
  }

  Future<void> addProduct() async {
    final result = await createProductUseCase(
        const CreateProductParams(
            productCategory: 'did',
            productID: 'productID',
            productGallery: [],
            productAvailability: 10,
            productPrice: 11.2,
            productDescription: 'productDescription',
            productName: 'productName'));
    result.fold((failure){
      return Get.snackbar('title', 'message');
    }, (result) async {
      return Get.snackbar('title', 'message');
    });
  }
}