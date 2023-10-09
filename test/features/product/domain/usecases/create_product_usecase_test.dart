import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/product/domain/repositories/product_repo.dart';
import 'package:shop/features/product/domain/usecases/create_product_usecase.dart';

class MockProductRepo extends Mock implements ProductRepo{}

void main() {
  late ProductRepo repo;
  late CreateProductUseCase useCase;

  setUp((){
    repo = MockProductRepo();
    useCase = CreateProductUseCase(productRepo: repo);
  });

   final params = CreateProductParams.empty();

   test('should call create product usecase', () async{

     when(()=>repo.addProduct(
         productCategory: any(named: 'productCategory'),
         productName: any(named: 'productName'),
         productDescription: any(named: 'productDescription'),
         productPrice: any(named: 'productPrice'),
         productGallery: any(named: 'productGallery'),
         productAvailability: any(named: 'productAvailability'),
         productID: any(named: 'productID'))).thenAnswer((_) async => const Right(null));

     final result = await useCase(params);

     expect(result, equals(const Right(null)));
     verify(()=>repo.addProduct(
         productCategory: params.productCategory,
         productName: params.productName,
         productDescription: params.productDescription,
         productPrice: params.productPrice,
         productGallery: params.productGallery,
         productAvailability: params.productAvailability,
         productID: params.productID)).called(1);
     verifyNoMoreInteractions(repo);

   });



}
