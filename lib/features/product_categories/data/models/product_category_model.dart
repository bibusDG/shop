import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/features/product_categories/domain/entities/product_category.dart';

class ProductCategoryModel extends ProductCategory{
  const ProductCategoryModel({
    required super.productCategoryName,
    required super.productCategoryPicture,
    required super.productCategoryID,
  });

  const ProductCategoryModel.empty() : this(
    productCategoryName: 'productName',
    productCategoryPicture: 'productPicture',
    productCategoryID: 'productCategoryID'
  );

  ProductCategoryModel copyWith({
    String? productCategoryName,
    String? productCategoryPicture,
    String? productCategoryID,
  }) =>
      ProductCategoryModel(
        productCategoryName: productCategoryName ?? this.productCategoryName,
        productCategoryPicture: productCategoryPicture ?? this.productCategoryPicture,
        productCategoryID: productCategoryID ?? this.productCategoryID,
      );

  factory ProductCategoryModel.fromRawJson(String str) => ProductCategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) => ProductCategoryModel(
    productCategoryName: json["productCategoryName"],
    productCategoryPicture: json["productCategoryPicture"],
    productCategoryID: json["productCategoryID"]
  );

  Map<String, dynamic> toJson() => {
    "productCategoryName": productCategoryName,
    "productCategoryPicture": productCategoryPicture,
    "productCategoryID": productCategoryID,
  };

  // factory ProductCategoryModel.fromMap(Map<String, dynamic> map) {
  //   return ProductCategoryModel(
  //       productCategoryName: map['productCategoryName'] as String,
  //       productCategoryPicture: map['productCategoryPicture'] as String,
  //       productCategoryID: map['productCategoryID'] as String,
  //   );
  // }

  factory ProductCategoryModel.fromDocument(DocumentSnapshot document) {
    final data = document.data()! as Map<String, dynamic>;
    return ProductCategoryModel(
        productCategoryName: data['productCategoryModel'] as String,
        productCategoryPicture: data['productCategoryPicture'] as String,
        productCategoryID: data['productCategoryID'] as String,

    );
  }

}