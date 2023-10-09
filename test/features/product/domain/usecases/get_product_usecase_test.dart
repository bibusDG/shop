import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/product/domain/entities/product.dart';
import 'package:shop/features/product/domain/repositories/product_repo.dart';
import 'package:shop/features/product/domain/usecases/get_product_usecase.dart';

class MockProductRepo extends Mock implements ProductRepo{}

void main() {

  late GetProductUseCase useCase;
  late ProductRepo repo;

  setUp((){
    repo = MockProductRepo();
    useCase = GetProductUseCase(productRepo: repo);
  });

  const params = GetProductParams.empty();
  final testResponse = Product.empty();
  test('should call get product', () async{

    when(()=> repo.getProduct(productID: any(named: 'productID'))).thenAnswer((_) async => Right(testResponse));

    final result = await useCase(params);

    expect(result, equals(Right(testResponse)));
    verify(()=> repo.getProduct(productID: params.productID)).called(1);
    verifyNoMoreInteractions(repo);
  });

}
