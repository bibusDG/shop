import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/product_categories/domain/entities/product_category.dart';
import 'package:shop/features/product_categories/domain/repositories/product_category_repo.dart';
import 'package:shop/features/product_categories/domain/usecases/stream_product_category_usecase.dart';

class MockProductCategoryRepo extends Mock implements ProductCategoryRepo{}

void main() {

  late ProductCategoryRepo repo;
  late StreamProductCategoryUseCase useCase;

  setUp((){
    repo = MockProductCategoryRepo();
    useCase = StreamProductCategoryUseCase(productCategoryRepo: repo);
  });

  // const myData = ProductCategory.empty();

  Stream<List<ProductCategory>> dummyData() async* {
    yield [const ProductCategory.empty()];
  }

  var fakeStreamData = dummyData();

  test('should compare fake stream with data', () async{
    //Arrange
    when(() => repo.streamProductCategories()).thenAnswer((_) async => Right(fakeStreamData));
    //Act
    final result = await useCase();
    //Assert
    expect(result, equals(Right(fakeStreamData)));
  });
}
