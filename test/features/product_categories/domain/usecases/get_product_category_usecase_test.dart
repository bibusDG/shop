import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/product_categories/domain/entities/product_category.dart';
import 'package:shop/features/product_categories/domain/repositories/product_category_repo.dart';
import 'package:shop/features/product_categories/domain/usecases/get_product_category_usecase.dart';

class MockProductCategoryRepo extends Mock implements ProductCategoryRepo{}

void main() {
  late GetProductCategoryUseCase useCase;
  late ProductCategoryRepo repo;

  setUp((){
    repo = MockProductCategoryRepo();
    useCase = GetProductCategoryUseCase(productCategoryRepo: repo);
  });

  const params = GetProductCategoryParams.empty();
  const testResponse = ProductCategory.empty();

  test('should call get product category', () async{
    //Arrange
    when(()=> repo.getProductCategory(productCategoryID: any(named : 'productCategoryID')))
        .thenAnswer((_) async => const Right(testResponse));
    //Act
    final result = await useCase(params);
    //Assert
    expect(result, equals(const Right(testResponse)));
  });

}
