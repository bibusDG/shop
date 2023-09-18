import 'package:get/get.dart';
import 'package:shop/features/user_auth/data/datasources/user_firebase_data_source.dart';
import 'package:shop/features/user_auth/data/repositories/user_repo_imp.dart';
import 'package:shop/features/user_auth/domain/repositories/user_repo.dart';
import 'package:shop/features/user_auth/domain/usecases/create_user_usecase.dart';
import 'package:shop/features/user_auth/domain/usecases/logout_user_usecase.dart';
import 'package:shop/features/user_auth/domain/usecases/user_login_usecase.dart';
import 'package:shop/features/user_auth/presentation/getx/create_user_controller.dart';

class UserBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserFirebaseDataSource>(() => UserFirebaseDataSourceImp());
    Get.lazyPut<UserRepo>(() => UserRepoImp(userFirebaseDataSource: Get.find()));
    Get.lazyPut(() => CreateUserUseCase(userRepo: Get.find()));
    // Get.lazyPut(()=> LoginUserUseCase(userRepo: Get.find()));
    // Get.lazyPut(() => LogOutUserUseCase(userRepo: Get.find()));
    Get.lazyPut(() => CreateUserController(
        createUserUseCase: Get.find(),
        // loginUserUseCase: Get.find(),
        // logOutUserUseCase: Get.find(),
    ));
    // TODO: implement dependencies
  }

}