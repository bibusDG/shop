import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/constants/constants.dart';

import '../models/product_model.dart';

abstract class ProductDataSource{
  const ProductDataSource();

  Future<void> addProduct({
    required String productCategory,
    required String productName,
    required String productDescription,
    required double productPrice,
    required List<String> productGallery,
    required int productAvailability,
    required String productID,
});

  Future<void> deleteProduct({
    required String productID,
});

  Future<ProductModel> getProduct({
    required String productID,
});

  Stream<List<ProductModel>> streamProducts({
    required String productCategory,
});

  Future<void> modifyProduct({
    required String productCategory,
    required String productName,
    required String productDescription,
    required double productPrice,
    required List<String> productGallery,
    required int productAvailability,
    required String productID,
  });

}

class ProductDataSourceImp implements ProductDataSource{
  @override
  Future<void> addProduct({
    required String productCategory,
    required String productName,
    required String productDescription,
    required double productPrice,
    required List<String> productGallery,
    required int productAvailability,
    required String productID}) async{

    final addProduct = await FirebaseFirestore.instance.
          collection('company').
          doc(COMPANY_NAME).
          collection('products').add(
        ProductModel(
            productCategory: productCategory,
            productName: productName,
            productPrice: productPrice,
            productAvailability: productAvailability,
            productDescription: productDescription,
            productGallery: productGallery,
            productID: productID).toJson());

    final docID = addProduct.id;

    await FirebaseFirestore.instance.collection('company').
          doc(COMPANY_NAME).
          collection('products').
          doc(docID).update({"productID" : docID});

    // TODO: implement addProduct
    // throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct({
    required String productID}) async{
    await FirebaseFirestore.instance.
        collection('company').
        doc(COMPANY_NAME).
        collection('products').
        doc(productID).
        delete();
    // TODO: implement deleteProduct
    // throw UnimplementedError();
  }

  @override
  Future<ProductModel> getProduct({required String productID}) async{
    final answer = await FirebaseFirestore.instance.
        collection('company').
        doc(COMPANY_NAME).
        collection('products').
        doc(productID).
        get();
    ProductModel product = ProductModel.fromJson(answer.data()!);
    return product;
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<void> modifyProduct({
    required String productCategory,
    required String productName,
    required String productDescription,
    required double productPrice,
    required List<String> productGallery,
    required int productAvailability,
    required String productID}) async{
    await FirebaseFirestore.instance.collection('company').
      doc(COMPANY_NAME).
      collection('products').
      doc(productID).
      update({
      "productCategory": productCategory,
      "productName": productName,
      "productDescription": productDescription,
      "productPrice": productPrice,
      "productAvailability": productAvailability,
      "productGallery": productGallery,
      "productID": productID,
      });
    // TODO: implement modifyProduct
    throw UnimplementedError();
  }

  @override
  Stream<List<ProductModel>> streamProducts({
    required String productCategory}) async* {

    yield* FirebaseFirestore.instance.collection('company').doc(COMPANY_NAME).collection('products').
    where('productCategory', isEqualTo: productCategory).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();
      });
    // TODO: implement streamProducts
    // throw UnimplementedError();
  }

}