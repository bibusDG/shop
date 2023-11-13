import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/notifications/domain/repositories/user_notification_repo.dart';

class SendNotificationUseCase implements UseCasesWithParams<void, NotificationParams>{
  final UserNotificationRepo repo;
  const SendNotificationUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(NotificationParams params) async{
    return await repo.sendNotificationToUser(
        mobileToken: params.mobileToken,
        notificationTopic: params.notificationTopic,
        notificationText: params.notificationText);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class NotificationParams extends Equatable{
  final String notificationTopic;
  final String notificationText;
  final String mobileToken;
  const NotificationParams({
    required this.mobileToken,
    required this.notificationTopic,
    required this.notificationText,
});

  const NotificationParams.empty() : this(
    mobileToken: 'mobileToken',
    notificationText: 'notificationText',
    notificationTopic: 'notificationTopic'
  );

  @override
  List<Object> get props => [mobileToken, notificationText, notificationTopic];

}