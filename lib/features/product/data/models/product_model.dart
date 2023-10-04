import 'dart:convert';

import '../../domain/entities/product.dart';

class ProductModel extends Product{
 const  ProductModel({
   required super.productCategory,
   required super.productName,
   required super.productPrice,
   required super.productAvailability,
   required super.productDescription,
   required super.productGallery,
   required super.productID});

 const ProductModel.empty() : this(
   productID: 'productID',
   productAvailability: 0,
   productName: 'productName',
   productDescription: 'productDescription',
   productGallery: const [],
   productPrice: 0.0,
   productCategory: 'productCategory'
 );

 ProductModel copyWith({
   String? productName,
   String? productID,
   List<String>? productGallery,
   String? productDescription,
   int? productAvailability,
   double? productPrice,
   String? productCategory,
 }) =>
     ProductModel(
       productName: productName ?? this.productName,
       productID: productID ?? this.productID,
       productGallery: productGallery ?? this.productGallery,
       productDescription: productDescription ?? this.productDescription,
       productAvailability: productAvailability ?? this.productAvailability,
       productPrice: productPrice ?? this.productPrice,
       productCategory: productCategory ?? this.productCategory,
     );

 factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

 String toRawJson() => json.encode(toJson());

 factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
   productName: json["productName"],
   productID: json["productID"],
   productGallery: List<String>.from(json["productGallery"].map((x) => x)),
   productDescription: json["productDescription"],
   productAvailability: json["productAvailability"],
   productPrice: json["productPrice"]?.toDouble(),
   productCategory: json["productCategory"],
 );

 Map<String, dynamic> toJson() => {
   "productName": productName,
   "productID": productID,
   "productGallery": List<dynamic>.from(productGallery.map((x) => x)),
   "productDescription": productDescription,
   "productAvailability": productAvailability,
   "productPrice": productPrice,
   "productCategory": productCategory,
 };

 // factory ProductModel.fromMap(Map<String, dynamic> map) {
 //   return ProductModel(
 //     productName: map['productName'] as String,
 //     productAvailability: map['productAvailability'] as int,
 //     productCategory: map['productCategory'] as String,
 //     productDescription: map['productDescription'] as String,
 //     productGallery: map['productGallery'] as List<String>,
 //     productID: map['productID'] as String,
 //     productPrice: map['productPrice'] as double,
 //   );
 // }

}