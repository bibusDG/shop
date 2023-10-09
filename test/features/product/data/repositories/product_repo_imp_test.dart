import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/product/data/datasources/product_data_source.dart';
import 'package:shop/features/product/data/models/product_model.dart';
import 'package:shop/features/product/data/repositories/product_repo_imp.dart';
import 'package:shop/features/product/product_failure.dart';

class MockProductDataSource extends Mock implements ProductDataSource{}

void main() {

  late ProductDataSource dataSource;
  late ProductRepoImp repoImp;

  setUp((){
    dataSource = MockProductDataSource();
    repoImp = ProductRepoImp(productDataSource: dataSource);
  });

  const createProductFailureMessage = AddProductFailure(failureMessage: 'Unable to add new product');
  const deleteProductFailureMessage = DeleteProductFailure(failureMessage: 'Unable to delete product');
  const getProductFailureMessage = GetProductFailure(failureMessage: 'Unable to get product');
  const modifyProductFailureMessage = UpdateProductFailure(failureMessage: 'Unable to update product');
  const streamProductFailureMessage = StreamProductFailure(failureMessage: 'Unable to stream product');

  final product = ProductModel.empty();



  group('create Product', () {

    test('should call create product and finish successfully', () async{
      when(() => dataSource.addProduct(
          productCategory: any(named: 'productCategory'),
          productName: any(named: 'productName'),
          productDescription: any(named: 'productDescription'),
          productPrice: any(named: 'productPrice'),
          productGallery: any(named: 'productGallery'),
          productAvailability: any(named: 'productAvailability'),
          productID: any(named: 'productID'))).thenAnswer((_) => Future.value());

      final result = await repoImp.addProduct(
          productCategory: product.productCategory,
          productName: product.productName,
          productDescription: product.productDescription,
          productPrice: product.productPrice,
          productGallery: product.productGallery,
          productAvailability: product.productAvailability,
          productID: product.productID);

      expect(result, equals(const Right(null)));
      verify(() => dataSource.addProduct(
          productCategory: product.productCategory,
          productName: product.productName,
          productDescription: product.productDescription,
          productPrice: product.productPrice,
          productGallery: product.productGallery,
          productAvailability: product.productAvailability,
          productID: product.productID)).called(1);
      verifyNoMoreInteractions(dataSource);

    });

    test('should call create product and return failure message if failed', () async{
      when(() => dataSource.addProduct(
          productCategory: any(named: 'productCategory'),
          productName: any(named: 'productName'),
          productDescription: any(named: 'productDescription'),
          productPrice: any(named: 'productPrice'),
          productGallery: any(named: 'productGallery'),
          productAvailability: any(named: 'productAvailability'),
          productID: any(named: 'productID'))).thenThrow(createProductFailureMessage);

      final result = await repoImp.addProduct(
          productCategory: product.productCategory,
          productName: product.productName,
          productDescription: product.productDescription,
          productPrice: product.productPrice,
          productGallery: product.productGallery,
          productAvailability: product.productAvailability,
          productID: product.productID);

      expect(result, equals(Left(AddProductFailure(failureMessage: createProductFailureMessage.failureMessage))));
    });

  });

  group('delete product', () {

    test('should call delete product from data source and finish successfully', () async{
      //Arrange
      when(() => dataSource.deleteProduct(productID: any(named: 'productID'))).thenAnswer((_) => Future.value());
      //Act
      final result = await repoImp.deleteProduct(productID: product.productID);
      //Assert
      expect(result, equals(const Right(null)));
      verify(() => dataSource.deleteProduct(productID: product.productID)).called(1);
      verifyNoMoreInteractions(dataSource);

    });

    test('should call delete product and return failure message if failed', () async{
      //Arrange
      when(() => dataSource.deleteProduct(productID: any(named: 'productID'))).thenThrow(deleteProductFailureMessage);
      //Act
      final result = await repoImp.deleteProduct(productID: product.productID);
      //Assert
      expect(result, equals(Left(DeleteProductFailure(failureMessage: deleteProductFailureMessage.failureMessage))));

    });

  });

  group('get product', () {

    test('should call get product from data source and finish successfully', () async{
      //Arrange
      when(() => dataSource.getProduct(productID: any(named: 'productID'))).thenAnswer((_) async => product);
      //Act
      final result = await repoImp.getProduct(productID: product.productID);
      //Assert
      expect(result, equals(Right(product)));
      verify(() => dataSource.getProduct(productID: product.productID)).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('should call get product from data source and return fail message if failure', () async{
      //Arrange
      when(() => dataSource.getProduct(productID: any(named: 'productID'))).thenThrow(getProductFailureMessage);
      //Act
      final result = await repoImp.getProduct(productID: product.productID);
      //Assert
      expect(result, equals(Left(GetProductFailure(failureMessage: getProductFailureMessage.failureMessage))));

    });

  });

  group('stream product', () {

    test('should call stream product from data source and finish successfully', () async {
      //Arrange
      when(()=> dataSource.streamProducts(productCategory: any(named:'productCategory'))).thenAnswer((_) => Stream.value([product]));
      //Act
      final result = await dataSource.streamProducts(productCategory: product.productCategory);
      //Assert
      expect(result, emits([product]));
    });

    // test('should call get product from data source and return fail message if failure', () async{
    //   //Arrange
    //   when(() => dataSource.streamProducts(productCategory: any(named: 'productCategory'))).thenThrow(streamProductFailureMessage);
    //   //Act
    //   final result = await dataSource.streamProducts(productCategory: product.productCategory);
    //   //Assert
    //   expect(result, emits(Left(StreamProductFailure(failureMessage: streamProductFailureMessage.failureMessage))));
    //
    // });

  });

  group('modify Product', ()
  {
    test('should call modify product and finish successfully', () async {
      when(() =>
          dataSource.modifyProduct(
              productCategory: any(named: 'productCategory'),
              productName: any(named: 'productName'),
              productDescription: any(named: 'productDescription'),
              productPrice: any(named: 'productPrice'),
              productGallery: any(named: 'productGallery'),
              productAvailability: any(named: 'productAvailability'),
              productID: any(named: 'productID'))).thenAnswer((_) => Future.value());

      final result = await repoImp.modifyProduct(
          productCategory: product.productCategory,
          productName: product.productName,
          productDescription: product.productDescription,
          productPrice: product.productPrice,
          productGallery: product.productGallery,
          productAvailability: product.productAvailability,
          productID: product.productID);

      expect(result, equals(const Right(null)));
      verify(() =>
          dataSource.modifyProduct(
              productCategory: product.productCategory,
              productName: product.productName,
              productDescription: product.productDescription,
              productPrice: product.productPrice,
              productGallery: product.productGallery,
              productAvailability: product.productAvailability,
              productID: product.productID)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
    test('should call modify product failure message when failed', () async {
      when(() =>
          dataSource.modifyProduct(
              productCategory: any(named: 'productCategory'),
              productName: any(named: 'productName'),
              productDescription: any(named: 'productDescription'),
              productPrice: any(named: 'productPrice'),
              productGallery: any(named: 'productGallery'),
              productAvailability: any(named: 'productAvailability'),
              productID: any(named: 'productID'))).thenThrow(modifyProductFailureMessage);

      final result = await repoImp.modifyProduct(
          productCategory: product.productCategory,
          productName: product.productName,
          productDescription: product.productDescription,
          productPrice: product.productPrice,
          productGallery: product.productGallery,
          productAvailability: product.productAvailability,
          productID: product.productID);

      expect(result, equals(Left(UpdateProductFailure(failureMessage: modifyProductFailureMessage.failureMessage))));
      verify(() =>
          dataSource.modifyProduct(
              productCategory: product.productCategory,
              productName: product.productName,
              productDescription: product.productDescription,
              productPrice: product.productPrice,
              productGallery: product.productGallery,
              productAvailability: product.productAvailability,
              productID: product.productID)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
