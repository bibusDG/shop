import 'package:equatable/equatable.dart';

class UserNotification extends Equatable{
  final String mobileToken;
  final String notificationText;
  final String notificationTopic;
  const UserNotification({
    required this.mobileToken,
    required this.notificationText,
    required this.notificationTopic,
});

  const UserNotification.empty() : this(
    mobileToken: 'mobileToken',
    notificationText: "notificationText",
    notificationTopic: 'notificationTopic'
  );

  @override
  List<Object> get props => [mobileToken, notificationTopic, notificationText];

}