import 'package:equatable/equatable.dart';

class Product extends Equatable{

  final String productCategory;
  final String productName;
  final String productDescription;
  final int productAvailability;
  final List<String> productGallery;
  final String productID;
  final double productPrice;

  const Product({
    required this.productCategory,
    required this.productName,
    required this.productPrice,
    required this.productAvailability,
    required this.productDescription,
    required this.productGallery,
    required this.productID
});

  Product.empty() : this(
    productID: 'productID',
    productAvailability: 0,
    productName: 'productName',
    productCategory: 'productCategory',
    productDescription: 'productDescription',
    productGallery: [],
    productPrice: 0.0
  );

  @override
  List<Object> get props => [productID, productName];
}