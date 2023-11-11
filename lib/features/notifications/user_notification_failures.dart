import 'package:shop/core/failures/failure.dart';

class SendUserNotificationFailure extends Failure{
  const SendUserNotificationFailure({required super.failureMessage});
}

class UpdateUserMobileToken extends Failure{
  const UpdateUserMobileToken({required super.failureMessage});
}