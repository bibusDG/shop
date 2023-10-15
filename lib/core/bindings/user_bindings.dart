import 'package:get/get.dart';
import 'package:shop/features/user_auth/data/datasources/user_firebase_data_source.dart';
import 'package:shop/features/user_auth/data/repositories/user_repo_imp.dart';
import 'package:shop/features/user_auth/domain/repositories/user_repo.dart';
import 'package:shop/features/user_auth/domain/usecases/create_user_usecase.dart';
import 'package:shop/features/user_auth/domain/usecases/logout_user_usecase.dart';
import 'package:shop/features/user_auth/domain/usecases/user_login_usecase.dart';
import 'package:shop/features/user_auth/presentation/getx/create_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/login_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/logout_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';
import 'package:shop/features/user_auth/presentation/pages/registration_page.dart';

class UserBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserFirebaseDataSource>(() => UserFirebaseDataSourceImp());
    Get.lazyPut<UserRepo>(() => UserRepoImp(userFirebaseDataSource: Get.find()));
    Get.lazyPut(() => CreateUserUseCase(userRepo: Get.find()));
    Get.lazyPut(()=> LoginUserUseCase(userRepo: Get.find()));
    Get.lazyPut(() => LogOutUserUseCase(userRepo: Get.find()));
    Get.lazyPut(() => CreateUserController(createUserUseCase: Get.find()),);
    Get.lazyPut(() => LoginUserController(loginUserUseCase: Get.find()));
    Get.lazyPut(() => LogOutUserController(useCase: Get.find()));
    Get.lazyPut(()=> UserDataController());
    // TODO: implement dependencies
  }

}