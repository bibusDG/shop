import 'package:dartz/dartz.dart';
import 'package:shop/core/failures/failure.dart';

class AddProductFailure extends Failure {
  const AddProductFailure({required super.failureMessage});
}

class DeleteProductFailure extends Failure{
  const DeleteProductFailure({required super.failureMessage});
}

class UpdateProductFailure extends Failure{
  const UpdateProductFailure({required super.failureMessage});
}

class GetProductFailure extends Failure{
  const GetProductFailure({required super.failureMessage});
}

class StreamProductFailure extends Failure{
  const StreamProductFailure({required super.failureMessage});
}