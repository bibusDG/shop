import 'package:get/get.dart';
import 'package:shop/features/user_auth/domain/usecases/modify_user_voucher_value_usecase.dart';

import '../../features/user_auth/data/datasources/user_firebase_data_source.dart';
import '../../features/user_auth/data/repositories/user_repo_imp.dart';
import '../../features/user_auth/domain/repositories/user_repo.dart';
import '../../features/user_auth/domain/usecases/modify_user_usecase.dart';
import '../../features/user_auth/presentation/getx/modify_user_controller.dart';

class ModifyUserBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserFirebaseDataSource>(() => UserFirebaseDataSourceImp());
    Get.lazyPut<UserRepo>(() => UserRepoImp(userFirebaseDataSource: Get.find()));
    Get.lazyPut(() => ModifyUserUseCase(userRepo: Get.find()));
    Get.lazyPut(() => ModifyUserVoucherValueUseCase(userRepo: Get.find()));
    Get.lazyPut(() => ModifyUserController(
        modifyUserUseCase: Get.find(),
        modifyUserVoucherValueUseCase: Get.find(),
    ));
    // TODO: implement dependencies
  }
}