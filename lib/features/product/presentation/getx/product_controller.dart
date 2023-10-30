import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';
import 'package:shop/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:shop/features/product/domain/usecases/stream_product_usecase.dart';
import 'package:shop/features/product/domain/usecases/update_product_usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../../domain/usecases/get_product_usecase.dart';

class ProductController extends GetxController{
  final DeleteProductUseCase deleteProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final StreamProductUseCase streamProductUseCase;
  final GetProductUseCase getProductUseCase;
  final CreateProductUseCase createProductUseCase;
  ProductController({
    required this.deleteProductUseCase,
    required this.updateProductUseCase,
    required this.streamProductUseCase,
    required this.getProductUseCase,
    required this.createProductUseCase,
});

  // String productID = '';
  String productCategory = '';
  Product productData = const Product.empty();
  RxInt availability = 0.obs;
  RxList<String> listOfImages = <String>[].obs;

  ///TextFields for product
  TextEditingController productName = TextEditingController();
  TextEditingController productAvailability = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDescription = TextEditingController();



  Future<void> deleteProduct({productID}) async{
    final result = await deleteProductUseCase(DeleteProductParams(productID: productID));
    result.fold((failure){
      return Get.snackbar('Błąd', 'Nie można usunąć produktu');
    }, (result){
      return Get.snackbar('Udało się', 'Produkt usunięty pomyślnie');
    });
  }

  Future<Product> getProduct({productID}) async{
    final result = await getProductUseCase(GetProductParams(productID: productID));
    result.fold((failure){
      return Get.defaultDialog();
    }, (result) async{
      productData = result;
      availability.value = result.productAvailability;
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
        CreateProductParams(
            productCategory: productCategory,
            productID: '',
            productGallery: listOfImages,
            productAvailability: int.parse(productAvailability.text),
            productPrice: double.parse(productPrice.text),
            productDescription: productDescription.text,
            productName: productName.text));
    result.fold((failure){
      return Get.snackbar('title', 'message');
    }, (result) async {
      Get.back();
      return Get.snackbar('Udało się', 'nowy produkt został utworzony');
    });
  }

  ///function, that updates product availability
  ///(existing availability - chosen amount of product in basket)
  ///after final order (based on list of products in basket controller)
  Future<void> updateAvailability() async{
    BasketController basketController = Get.find();
    for(var item in basketController.listOfProducts.values){
        final result = await updateProductUseCase(
            UpdateProductParams(
                productID: item.productID,
                productName: item.productName,
                productDescription: item.productDescription,
                productPrice: item.productPrice,
                productAvailability: item.productAvailability - basketController.productCounter[item.productID]!,
                productGallery: item.productGallery,
                productCategory: item.productCategory));
        result.fold((error) async{
        }, (update) async{
        });
    }
  }
}