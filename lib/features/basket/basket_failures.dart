import 'package:shop/core/failures/failure.dart';

class AddToBasketFailure extends Failure{
  const AddToBasketFailure({required super.failureMessage});
}

class RemoveFromBasketFailure extends Failure{
  const RemoveFromBasketFailure({required super.failureMessage});
}