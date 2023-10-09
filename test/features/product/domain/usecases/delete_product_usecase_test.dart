import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/product/domain/repositories/product_repo.dart';
import 'package:shop/features/product/domain/usecases/delete_product_usecase.dart';

class MockProductRepo extends Mock implements ProductRepo{}

void main() {

  late ProductRepo repo;
  late DeleteProductUseCase useCase;

  setUp((){
    repo = MockProductRepo();
    useCase = DeleteProductUseCase(productRepo: repo);
  });

  const params = DeleteProductParams.empty();

  test('should call delete', () async{

    when(()=>repo.deleteProduct(productID: any(named: 'productID'))).thenAnswer((invocation) async => const Right(null));

    final result = await useCase(params);

    expect(result, equals(const Right(null)));
    verify(()=>repo.deleteProduct(productID: params.productID)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
