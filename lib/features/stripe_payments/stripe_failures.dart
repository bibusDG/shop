import 'package:shop/core/failures/failure.dart';

class CreatePaymentIntentFailure extends Failure{
  const CreatePaymentIntentFailure({required super.failureMessage});
}

class DisplayPaymentSheetFailure extends Failure{
  const DisplayPaymentSheetFailure({required super.failureMessage});
}

class InitPaymentSheetFailure extends Failure{
  const InitPaymentSheetFailure({required super.failureMessage});
}

class UpdateUserOrderPaymentStatusFailure extends Failure{
  const UpdateUserOrderPaymentStatusFailure({required super.failureMessage});
}