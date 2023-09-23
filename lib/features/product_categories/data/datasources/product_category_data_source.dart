import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:shop/features/product_categories/data/models/product_category_model.dart';

abstract class ProductCategoryDataSource{
  const ProductCategoryDataSource();

  Future<void> createProductCategory({
    required String productCategoryName,
    required String productCategoryPicture,
    required String productCategoryID,
});

  Stream<List<ProductCategoryModel>> streamProductCategory();

  Future<void> modifyProductCategory({
    required String productCategoryName,
    required String productCategoryPicture,
    required String productCategoryID,
});

  Future<void> deleteProductCategory({
    required String productCategoryID,
});

}

class ProductCategoryDataSourceImp implements ProductCategoryDataSource{

  @override
  Future<void> createProductCategory({
    required String productCategoryName,
    required String productCategoryPicture,
    required String productCategoryID,
  }) async{

    final addProductCategory = await FirebaseFirestore.instance.
          collection('company').
          doc(COMPANY_NAME).
          collection('productCategory').add(
        ProductCategoryModel(
            productCategoryName: productCategoryName,
            productCategoryPicture: productCategoryPicture,
            productCategoryID: productCategoryID).toJson());

    final categoryID = addProductCategory.id;
    await FirebaseFirestore.instance.collection('company').
          doc(COMPANY_NAME).
          collection('productCategory').
          doc(categoryID).update({'productCategoryID': categoryID});

    // TODO: implement createProductCategory
    // throw UnimplementedError();
  }

  @override
  Future<void> modifyProductCategory({
    required String productCategoryID,
    required String productCategoryName,
    required String productCategoryPicture}) async{

    await FirebaseFirestore.instance.collection('company').
          doc(COMPANY_NAME).
          collection('productCategories').
          doc(productCategoryID).update({
      'productCategoryName' : productCategoryName,
      'productCategoryPicture' :productCategoryPicture});


    // TODO: implement modifyProductCategory
    // throw UnimplementedError();
  }

  @override
  Stream<List<ProductCategoryModel>> streamProductCategory() {
    // TODO: implement streamProductCategory
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProductCategory({
    required String productCategoryID}) async{

    await FirebaseFirestore.instance.collection('company').
          doc(COMPANY_NAME).
          collection('productCategory').
          doc(productCategoryID).delete();

    // TODO: implement deleteProductCategory
    // throw UnimplementedError();
  }
}