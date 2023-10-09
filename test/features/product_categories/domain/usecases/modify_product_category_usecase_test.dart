import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/product_categories/domain/repositories/product_category_repo.dart';
import 'package:shop/features/product_categories/domain/usecases/modify_product_category_usecase.dart';

class MockProductCategoryRepo extends Mock implements ProductCategoryRepo{}

void main() {
  late ProductCategoryRepo repo;
  late ModifyProductCategoryUseCase useCase;

  setUp((){
    repo = MockProductCategoryRepo();
    useCase = ModifyProductCategoryUseCase(productCategoryRepo: repo);
  });

  const params = ModifyProductCategoryParams.empty();

  test('should call [ProductCategoryRepo.modifyProductCategory]', () async{
    when(() => repo.modifyProductCategory(
        categoryName: any(named: 'categoryName'),
        categoryPicture: any(named:  'categoryPicture'),
        productCategoryID: any(named: 'productCategoryID'))).thenAnswer((invocation) async => const Right(null));

    final result = await useCase(params);

    expect(result, equals(const Right(null)));
  });

}
