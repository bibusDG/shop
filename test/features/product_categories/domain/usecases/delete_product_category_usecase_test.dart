import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/product_categories/data/models/product_category_model.dart';
import 'package:shop/features/product_categories/domain/repositories/product_category_repo.dart';
import 'package:shop/features/product_categories/domain/usecases/delete_product_category_usecase.dart';

class MockProductCategoryRepo extends Mock implements ProductCategoryRepo{}

void main() {

  late ProductCategoryRepo repo;
  late DeleteProductCategoryUseCase useCase;

  setUp((){
    repo = MockProductCategoryRepo();
    useCase = DeleteProductCategoryUseCase(productCategoryRepo: repo);
  });

  const params = DeleteProductCategoryParams.empty();

  test('should call [ProductCategoryUseCase.deleteProduct]', () async{
    //Arrange
    when(() => repo.deleteProductCategory(productCategoryID: any(named:'productCategoryID'))).
    thenAnswer((_) async => const Right(null));
    //Act
    final result = await useCase(params);
    //Assert
    expect(result, equals(const Right(null)));

  });
}
