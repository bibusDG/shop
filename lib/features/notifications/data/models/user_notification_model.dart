import 'dart:convert';
import '../../domain/entities/user_notification.dart';

class UserNotificationModel extends UserNotification{
  const UserNotificationModel({
    required super.notificationText,
    required super.notificationTopic,
    required super.mobileToken,
});
  UserNotificationModel copyWith({
    String? mobileToken,
    String? notificationText,
    String? notificationTopic,
  }) =>
      UserNotificationModel(
        mobileToken: mobileToken ?? this.mobileToken,
        notificationText: notificationText ?? this.notificationText,
        notificationTopic: notificationTopic ?? this.notificationTopic,
      );

  factory UserNotificationModel.fromRawJson(String str) => UserNotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserNotificationModel.fromJson(Map<String, dynamic> json) => UserNotificationModel(
    mobileToken: json["mobileToken"],
    notificationText: json["notificationText"],
    notificationTopic: json["notificationTopic"],
  );

  Map<String, dynamic> toJson() => {
    "mobileToken": mobileToken,
    "notificationText": notificationText,
    "notificationTopic": notificationTopic,
  };

  const UserNotificationModel.empty() : this(
    mobileToken: 'mobileToken',
    notificationTopic: 'notificationTopic',
    notificationText: 'notificationText',
  );

}