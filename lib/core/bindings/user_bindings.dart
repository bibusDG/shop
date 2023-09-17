import 'package:get/get.dart';
import 'package:shop/features/user_auth/data/datasources/user_firebase_data_source.dart';
import 'package:shop/features/user_auth/data/repositories/user_repo_imp.dart';
import 'package:shop/features/user_auth/domain/repositories/user_repo.dart';
import 'package:shop/features/user_auth/domain/usecases/create_user_usecase.dart';
import 'package:shop/features/user_auth/presentation/getx/user_controller.dart';

class UserBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserFirebaseDataSource>(() => UserFirebaseDataSourceImp());
    Get.lazyPut<UserRepo>(() => UserRepoImp(userFirebaseDataSource: Get.find()));
    Get.lazyPut(() => CreateUserUseCase(userRepo: Get.find()));
    Get.lazyPut(() => UserController(createUserUseCase: Get.find()));
    // TODO: implement dependencies
  }

}