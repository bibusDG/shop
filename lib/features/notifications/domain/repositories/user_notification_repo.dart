import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';

abstract class UserNotificationRepo{
  const UserNotificationRepo();

  Future<Either<Failure, void>> sendNotificationToUser({
    required String mobileToken,
    required String notificationTopic,
    required String notificationText,
});

  Future<Either<Failure, void>> updateUserMobileToken({
   required String userID,
   required String mobileToken,
});

}