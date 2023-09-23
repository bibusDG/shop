import 'package:equatable/equatable.dart';

class ProductCategory extends Equatable{
  final String productCategoryName;
  final String productCategoryPicture;
  final String productCategoryID;
  const ProductCategory({
    required this.productCategoryName,
    required this.productCategoryPicture,
    required this.productCategoryID
});

  const ProductCategory.empty() : this(
    productCategoryName: 'productCategoryName',
    productCategoryPicture: 'productCategoryPicture',
    productCategoryID: 'productCategoryID'
  );


  @override
  List<Object>  get props => [productCategoryID];
}