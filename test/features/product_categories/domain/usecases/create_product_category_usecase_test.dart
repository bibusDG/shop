import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/product_categories/domain/repositories/product_category_repo.dart';
import 'package:shop/features/product_categories/domain/usecases/create_product_category_usecase.dart';

class MockProductCategoryRepo extends Mock implements ProductCategoryRepo{}

void main() {
  late CreateProductCategoryUseCase useCase;
  late ProductCategoryRepo repo;

  setUp((){
    repo = MockProductCategoryRepo();
    useCase = CreateProductCategoryUseCase(productCategoryRepo: repo);
  });

  const params = CreateProductCategoryUseCaseParams.empty();

  test('should call [CreateProductCategoryUseCase.addNewCategory', () async{
    //Arrange
    when(()=>repo.addNewCategory(
        categoryName: any(named: 'categoryName'),
        categoryPicture: any(named: 'categoryPicture'),
        productCategoryID: any(named: 'productCategoryID'))).thenAnswer((_) async => const Right(null));
    //Act
    final result = await useCase(params);

    //Assert
    expect(result, equals(const Right(null)));
    verify(()=>repo.addNewCategory(
        categoryName: params.productCategoryName,
        categoryPicture: params.productCategoryPicture,
        productCategoryID: params.productCategoryID)).called(1);
    verifyNoMoreInteractions(repo);
  });

}
