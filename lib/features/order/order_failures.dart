import 'package:shop/core/failures/failure.dart';

class CreateOrderFailure extends Failure{
  const CreateOrderFailure({required super.failureMessage});
}

class UpdateOrderByAdminFailure extends Failure{
  const UpdateOrderByAdminFailure({required super.failureMessage});
}