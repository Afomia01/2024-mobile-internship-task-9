import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/features/product/data/datasource/local_data_source.dart';
import 'package:myapp/features/product/data/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_data_source_test.mocks.dart'; // Import the generated mocks

@GenerateMocks([SharedPreferences])
void main() {
  late LocalDataSourceImpl localDataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = LocalDataSourceImpl(sharedPreferences: mockSharedPreferences);

    // Stub for setString to do nothing
    when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);
  });

  final List<ProductModel> tProductList = [
    const ProductModel(id: '1', name: 'PC', description: 'long description', price: 123, imageUrl: 'image.png'),
    const ProductModel(id: '2', name: 'Laptop', description: 'short description', price: 456, imageUrl: 'image2.png'),
  ];

  group('getAllProducts', () {
    test('should return a list of ProductModel when there is cached data', () async {
      // Arrange
      final jsonList = tProductList.map((product) => product.toJson()).toList();
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(json.encode(jsonList));

      // Act
      final result = await localDataSource.getAllProducts();

      // Assert
      expect(result, equals(tProductList));
    });

    test('should return an empty list when there is no cached data', () async {
      // Arrange
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);

      // Act
      final result = await localDataSource.getAllProducts();

      // Assert
      expect(result, equals([]));
    });
  });

  group('getProductById', () {
    test('should return a ProductModel when there is a cached product with the given ID', () async {
      // Arrange
      final jsonList = tProductList.map((product) => product.toJson()).toList();
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(json.encode(jsonList));

      // Act
      final result = await localDataSource.getProductById('1');

      // Assert
      expect(result, equals(tProductList[0]));
    });

    test('should throw an exception when there is no cached product with the given ID', () async {
      // Arrange
      final jsonList = tProductList.map((product) => product.toJson()).toList();
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(json.encode(jsonList));

      // Act
      final call = localDataSource.getProductById;

      // Assert
      expect(() => call('999'), throwsA(isA<Exception>()));
    });

    test('should throw an exception when there are no cached products', () async {
      // Arrange
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);

      // Act
      final call = localDataSource.getProductById;

      // Assert
      expect(() => call('1'), throwsA(isA<Exception>()));
    });
  });

  group('addProduct', () {
    test('should add a new product and return it', () async {
      // Arrange
      const newProduct = ProductModel(id: '3', name: 'Tablet', description: 'new tablet', price: 789, imageUrl: 'tablet.png');
      final jsonList = tProductList.map((product) => product.toJson()).toList();
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(json.encode(jsonList));

      // Act
      final result = await localDataSource.addProduct(newProduct);

      // Assert
      final updatedList = [...tProductList, newProduct];
      final updatedJsonList = updatedList.map((product) => product.toJson()).toList();
      verify(mockSharedPreferences.setString(
        cachedProductsKey,
        json.encode(updatedJsonList),
      )).called(1);
      expect(result, equals(newProduct));
    });

    test('should add a new product when there is no cached data', () async {
      // Arrange
      const newProduct = ProductModel(id: '3', name: 'Tablet', description: 'new tablet', price: 789, imageUrl: 'tablet.png');
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);

      // Act
      final result = await localDataSource.addProduct(newProduct);

      // Assert
      final updatedList = [newProduct];
      final updatedJsonList = updatedList.map((product) => product.toJson()).toList();
      verify(mockSharedPreferences.setString(
        cachedProductsKey,
        json.encode(updatedJsonList),
      )).called(1);
      expect(result, equals(newProduct));
    });
  });

  group('updateProduct', () {
    test('should update an existing product and return it', () async {
      // Arrange
      const updatedProduct = ProductModel(id: '1', name: 'Updated PC', description: 'updated description', price: 1234, imageUrl: 'updated_image.png');
      final jsonList = tProductList.map((product) => product.toJson()).toList();
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(json.encode(jsonList));

      // Act
      await localDataSource.updateProduct(updatedProduct);

      // Assert
      final updatedList = tProductList.map((product) => product.id == updatedProduct.id ? updatedProduct : product).toList();
      final updatedJsonList = updatedList.map((product) => product.toJson()).toList();
      verify(mockSharedPreferences.setString(
        cachedProductsKey,
        json.encode(updatedJsonList),
      )).called(1);
    });

    test('should throw an exception when the product ID is not found', () async {
      // Arrange
      const updatedProduct = ProductModel(id: '999', name: 'Non-existent Product', description: 'description', price: 0, imageUrl: 'image.png');
      final jsonList = tProductList.map((product) => product.toJson()).toList();
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(json.encode(jsonList));

      // Act
      final call = localDataSource.updateProduct;

      // Assert
      expect(() => call(updatedProduct), throwsA(isA<Exception>()));
    });

    test('should throw an exception when there are no cached products', () async {
      // Arrange
      const updatedProduct = ProductModel(id: '1', name: 'Updated PC', description: 'updated description', price: 1234, imageUrl: 'updated_image.png');
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);

      // Act
      final call = localDataSource.updateProduct;

      // Assert
      expect(() => call(updatedProduct), throwsA(isA<Exception>()));
    });
  });

  group('deleteProduct', () {
    test('should delete a product when the product ID is found in the cached list', () async {
      // Arrange
      final jsonList = tProductList.map((product) => product.toJson()).toList();
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(json.encode(jsonList));

      // Act
      await localDataSource.deleteProduct('1');

      // Assert
      final updatedList = jsonList.where((json) => json['id'] != '1').toList();
      verify(mockSharedPreferences.setString(
        cachedProductsKey,
        json.encode(updatedList),
      )).called(1);
    });

    test('should throw an exception when there are no cached products', () async {
      // Arrange
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);

      // Act
      final call = localDataSource.deleteProduct;

      // Assert
      expect(() => call('1'), throwsA(isA<Exception>()));
    });
  });
}
