// product_repository_impl_test.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/error/exception.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/core/platform/network_info.dart';
import 'package:myapp/features/product/data/datasource/local_data_source.dart';
import 'package:myapp/features/product/data/datasource/remote_data_source.dart';
import 'package:myapp/features/product/data/model/product_model.dart';
import 'package:myapp/features/product/data/repository/product_repository_impl.dart';

import 'product_repository_impl_test.mocks.dart';


@GenerateMocks([
  RemoteDataSource,
  LocalDataSource,
  NetworkInfo,
])
void main() {
  late ProductRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getAllProducts', () {
    final testProductModelList = [
      const ProductModel(
        id: '1',
        name: 'Product 1',
        description: 'Description 1',
        price: 10.0,
        imageUrl: 'url1.png',
      ),
      const ProductModel(
        id: '2',
        name: 'Product 2',
        description: 'Description 2',
        price: 20.0,
        imageUrl: 'url2.png',
      ),
    ];

    final List<ProductModel> testProductList = testProductModelList;

    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // Act
      repository.getAllProducts();

      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when the call to remote data source is successful', () async {
        // Arrange
        when(mockRemoteDataSource.getAllProducts()).thenAnswer((_) async => testProductModelList);

        // Act
        final result = await repository.getAllProducts();

        // Assert
        verify(mockRemoteDataSource.getAllProducts());
        expect(result, equals(Right(testProductList)));
      });

      test('should cache the data locally when the call to remote data source is successful', () async {
        // Arrange
        when(mockRemoteDataSource.getAllProducts()).thenAnswer((_) async => testProductModelList);

        // Act
        await repository.getAllProducts();

        // Assert
        verify(mockLocalDataSource.cacheProducts(testProductModelList));
      });

      test('should return server failure when the call to remote data source is unsuccessful', () async {
        // Arrange
        when(mockRemoteDataSource.getAllProducts()).thenThrow(const ServerException());

        // Act
        final result = await repository.getAllProducts();

        // Assert
        verify(mockRemoteDataSource.getAllProducts());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(const Left(ServerFailure(message: 'Failed to fetch products from server.'))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return locally cached data when the cached data is present', () async {
        // Arrange
        when(mockLocalDataSource.getAllProducts()).thenAnswer((_) async => testProductModelList);

        // Act
        final result = await repository.getAllProducts();

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getAllProducts());
        expect(result, equals(Right(testProductList)));
      });

      test('should return CacheFailure when there is no cached data present', () async {
        // Arrange
        when(mockLocalDataSource.getAllProducts()).thenThrow(const CacheException());

        // Act
        final result = await repository.getAllProducts();

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getAllProducts());
        expect(result, equals(const Left(CacheFailure(message: 'No cached data available.'))));
      });
    });
  });
}
