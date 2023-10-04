import 'package:equatable/equatable.dart';

import '../../../product/domain/entities/product.dart';

class Basket extends Equatable{
  final List<Product> basketContent;
  const Basket({
    required this.basketContent
});
  @override
  List<Object> get props => [basketContent];
}