import 'package:get/get.dart';
import 'package:shop/features/notifications/data/datasources/user_notification_datasource.dart';
import 'package:shop/features/notifications/data/repositories/user_notification_repo_imp.dart';
import 'package:shop/features/notifications/domain/repositories/user_notification_repo.dart';
import 'package:shop/features/notifications/domain/usecases/send_notification_usecase.dart';
import 'package:shop/features/notifications/domain/usecases/update_user_token_usecase.dart';
import 'package:shop/features/notifications/presentation/getx/user_notification_controller.dart';

class NotificationBindings implements Bindings{
  @override
  void dependencies() {

    Get.lazyPut<UserNotificationDataSource>(() => UserNotificationDataSourceImp());
    Get.lazyPut<UserNotificationRepo>(() => UserNotificationRepoImp(dataSource: Get.find()));
    Get.lazyPut(() => UpdateUserTokenUseCase(repo: Get.find()));
    Get.lazyPut(()=> SendNotificationUseCase(repo: Get.find()));
    Get.lazyPut(() => UserNotificationController(
        sendNotificationUseCase: Get.find(),
        updateUserTokenUseCase: Get.find()));
    // TODO: implement dependencies
  }

}