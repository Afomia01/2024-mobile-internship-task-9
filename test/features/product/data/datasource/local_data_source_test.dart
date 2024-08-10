import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/features/product/data/datasource/local_data_source.dart';
import 'package:myapp/features/product/data/model/product_model.dart';
import 'local_data_source_test.mocks.dart'; // Import the generated mocks

@GenerateMocks([SharedPreferences])
void main() {
  late LocalDataSourceImpl localDataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = LocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  final List<ProductModel> tProductList = [
    ProductModel(id: '1', name: 'PC', description: 'long description', price: 123, imageUrl: 'image.png'),
    ProductModel(id: '2', name: 'Laptop', description: 'short description', price: 456, imageUrl: 'image2.png'),
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
}
