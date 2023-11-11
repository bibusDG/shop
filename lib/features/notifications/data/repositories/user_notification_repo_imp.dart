import 'package:dartz/dartz.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/features/notifications/data/datasources/user_notification_datasource.dart';
import 'package:shop/features/notifications/user_notification_failures.dart';

import '../../domain/repositories/user_notification_repo.dart';

class UserNotificationRepoImp implements UserNotificationRepo{
  final UserNotificationDataSource dataSource;
  const UserNotificationRepoImp({required this.dataSource});

  @override
  Future<Either<Failure, void>> sendNotificationToUser({
    required String mobileToken,
    required String notificationTopic,
    required String notificationText}) async{
    try{
      final result = dataSource.sendNotificationToUser(
          mobileToken: mobileToken,
          notificationText: notificationText,
          notificationTopic: notificationTopic);
      return Right(result);
    }catch(error){
      return const Left(SendUserNotificationFailure(failureMessage: "Unable to send notification"));
    }
    // TODO: implement sendNotificationToUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateUserMobileToken({
    required String userID,
    required String mobileToken}) async{
    try{
      final result = dataSource.updateUserMobileToken(
          userID: userID,
          mobileToken: mobileToken);
      return Right(result);
    }catch(error){
      return const Left(UpdateUserMobileToken(failureMessage: 'Unable to update user mobile token'));
    }


    // TODO: implement updateUserMobileToken
    throw UnimplementedError();
  }
}