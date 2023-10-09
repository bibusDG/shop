import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/product_categories/data/datasources/product_category_data_source.dart';
import 'package:shop/features/product_categories/data/models/product_category_model.dart';
import 'package:shop/features/product_categories/data/repositories/product_category_repo_imp.dart';
import 'package:shop/features/product_categories/product_category_failure.dart';

class MockProductCategoryDataSource extends Mock implements ProductCategoryDataSource{}

void main() {

  late ProductCategoryDataSource dataSource;
  late ProductCategoryRepoImp repo;

  setUp((){
    dataSource = MockProductCategoryDataSource();
    repo = ProductCategoryRepoImp(productCategoryDataSource: dataSource);
  });

  const createFailureMessage = CreateProductCategoryFailure(failureMessage: 'Unable to create product category');
  const deleteFailureMessage = DeleteProductCategoryFailure(failureMessage: 'Unable to delete product category');
  const modifyFailure = UpdateProductCategoryFailure(failureMessage: 'Unable to update product category');
  const streamFailure = StreamProductCategoryFailure(failureMessage: 'Unable to stream category');

  group('create Category', () {

    const String productCategoryName = 'productCategoryName';
    const String productCategoryPicture = 'productCategoryPicture';
    const String productCategoryID = 'productCategoryID';

    test('should call create function from data source and finish successfully', () async{

      when(()=> dataSource.createProductCategory(
          productCategoryName: any(named: 'productCategoryName'),
          productCategoryPicture: any(named: 'productCategoryPicture'),
          productCategoryID: any(named: 'productCategoryID'))).thenAnswer((_) => Future.value());

      final result = await repo.addNewCategory(
          productCategoryID: productCategoryID,
          categoryName: productCategoryName,
          categoryPicture: productCategoryPicture);

      expect(result, equals(const Right(null)));
      verify(() => dataSource.createProductCategory(
          productCategoryName: productCategoryName,
          productCategoryPicture: productCategoryPicture,
          productCategoryID: productCategoryID)).called(1);
      verifyNoMoreInteractions(dataSource);

    });

    test('should give failure message when calling function failed', () async{
      //Arrange
      when(()=> dataSource.createProductCategory(
          productCategoryName: any(named: 'productCategoryName'),
          productCategoryPicture: any(named: 'productCategoryPicture'),
          productCategoryID: any(named: 'productCategoryID'))).thenThrow(createFailureMessage);
      //Act
      final result = await repo.addNewCategory(
          productCategoryID: productCategoryID,
          categoryName: productCategoryName,
          categoryPicture: productCategoryPicture);
      //Assert
      expect(result, equals(Left(CreateProductCategoryFailure(failureMessage: createFailureMessage.failureMessage))));
    });
  });

  group('delete product category', () {

    const String productCategoryID = 'productCategoryID';

    test('should call delete function and finish successfully', () async{

      //Arrange
      when(()=>dataSource.deleteProductCategory(productCategoryID: any(named:'productCategoryID')))
          .thenAnswer((_) => Future.value());
      //Act
      final result = await repo.deleteProductCategory(productCategoryID: productCategoryID);
      //Assert
      expect(result, equals(const Right(null)));
      verify(()=>dataSource.deleteProductCategory(productCategoryID: productCategoryID)).called(1);
      verifyNoMoreInteractions(dataSource);

    });

    test('should return failure when delete function not called', () async{

      //Arrange
      when(()=>dataSource.deleteProductCategory(productCategoryID: any(named:'productCategoryID')))
          .thenThrow(deleteFailureMessage);
      //Act
      final result = await repo.deleteProductCategory(productCategoryID: productCategoryID);
      //Assert
      expect(result, equals(Left(DeleteProductCategoryFailure(failureMessage: deleteFailureMessage.failureMessage))));
    });

  });

  group('modify product category', () {

    const String productCategoryID = 'productCategoryID';
    const String productCategoryName = 'productCategoryName';
    const String productCategoryPicture = 'productCategoryPicture';

    test('should call modify function and finish successfully', () async{

      //Arrange
      when(()=>dataSource.modifyProductCategory(
          productCategoryName: any(named: 'productCategoryName'),
          productCategoryPicture: any(named:'productCategoryPicture'),
          productCategoryID: any(named: 'productCategoryID'))).thenAnswer((_) => Future.value());
      //Act
      final result = await repo.modifyProductCategory(
          categoryName: productCategoryName,
          categoryPicture: productCategoryPicture,
          productCategoryID: productCategoryID);
      //Assert
      expect(result, equals(const Right(null)));
      verify(()=>dataSource.modifyProductCategory(
          productCategoryID: productCategoryID,
        productCategoryName: productCategoryName,
        productCategoryPicture: productCategoryPicture)).called(1);
      verifyNoMoreInteractions(dataSource);

    });

    test('should return failure when delete function not called', () async{

      //Arrange
      when(()=>dataSource.modifyProductCategory(
          productCategoryName: any(named: 'productCategoryName'),
          productCategoryPicture: any(named: 'productCategoryPicture'),
          productCategoryID: any(named: 'productCategoryID'))).thenThrow(modifyFailure);
      //Act
      final result = await repo.modifyProductCategory(
          categoryName: productCategoryName,
          categoryPicture: productCategoryPicture,
          productCategoryID: productCategoryID);
      //Assert
      expect(result, equals(Left(UpdateProductCategoryFailure(failureMessage: modifyFailure.failureMessage))));
    });
  });

  group('stream product category', () {


    test('should call stream function and finish successfully', () async {

      const List<ProductCategoryModel> myList = [ProductCategoryModel.empty()];
      // print(myData.stream);

      //Arrange
      when(()=>dataSource.streamProductCategory()).thenAnswer((_)  => Stream.value(myList));
      //Act
      final result =  await dataSource.streamProductCategory();
      //Assert
      expect(result, emits(myList));

    });

    // test('should return failure when delete function not called', () async{
    //
    //   //Arrange
    //   when(()=>dataSource.modifyProductCategory(
    //       productCategoryName: any(named: 'productCategoryName'),
    //       productCategoryPicture: any(named: 'productCategoryPicture'),
    //       productCategoryID: any(named: 'productCategoryID'))).thenThrow(modifyFailure);
    //   //Act
    //   final result = await repo.modifyProductCategory(
    //       categoryName: productCategoryName,
    //       categoryPicture: productCategoryPicture,
    //       productCategoryID: productCategoryID);
    //   //Assert
    //   expect(result, equals(Left(UpdateProductCategoryFailure(failureMessage: modifyFailure.failureMessage))));
    // });
  });



}
