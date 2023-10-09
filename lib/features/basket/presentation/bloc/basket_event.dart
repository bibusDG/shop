part of 'basket_bloc.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();
}

class BasketInit extends BasketEvent{
  @override
  List<Object?> get props => [];
}

class AddProductToBasket extends BasketEvent{
  final Product product;
  const AddProductToBasket({required this.product});
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}

class RemoveProductFromBasket extends BasketEvent{
  final Product product;
  const RemoveProductFromBasket({required this.product});
  @override
  // TODO: implement props
  List<Object?> get props => [product];

}
