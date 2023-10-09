import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/product/domain/entities/product.dart';
import 'package:shop/features/product/domain/repositories/product_repo.dart';
import 'package:shop/features/product/domain/usecases/stream_product_usecase.dart';

class MockProductRepo extends Mock  implements ProductRepo{}

void main() {

  late ProductRepo repo;
  late StreamProductUseCase useCase;

  setUp((){
    repo = MockProductRepo();
    useCase = StreamProductUseCase(productRepo: repo);
  });

  const params = StreamProductParams.empty();

  Stream<List<Product>> dummyData() async*{
    yield [Product.empty()];
  }
  final testResponse = dummyData();

  test('should call stream product', () async{
    when(() => repo.fetchProducts(productCategory: any(named:'productCategory'))).thenAnswer((invocation) async => Right(testResponse));

    final result = await useCase(params);

    expect(result, equals(Right(testResponse)));
    verify(() => repo.fetchProducts(productCategory: params.productCategory)).called(1);
    verifyNoMoreInteractions(repo);
  });

}
