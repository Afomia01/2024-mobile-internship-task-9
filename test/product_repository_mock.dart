import 'package:mockito/annotations.dart';
import 'package:myapp/features/product/domain/repository/productrepository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/domain/use_case/getAllProducts.dart';
import 'product_repository_mock.mocks.dart'; // Import the mock

@GenerateMocks([ProductRepository])


void main() {
  late GetAllProducts useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = GetAllProducts(mockProductRepository);
  });

  final tProductList = [
    Product(id: 1, name: 'Test Product 1', description: 'Test Description 1', price: 9.99, image: 'image1.jpg'),
    Product(id: 2, name: 'Test Product 2', description: 'Test Description 2', price: 19.99, image: 'image2.jpg'),
  ];

  test('should get all products from the repository', () async {
    // Arrange
    when(mockProductRepository.getAllProducts())
        .thenAnswer((_) async => Right(tProductList));

    // Act
    final result = await useCase();

    // Assert
    expect(result, Right(tProductList));
    verify(mockProductRepository.getAllProducts());
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return failure when unable to retrieve products', () async {
    // Arrange
    when(mockProductRepository.getAllProducts())
        .thenAnswer((_) async => Left(ServerFailure(message: 'Server error occurred.')));

    // Act
    final result = await useCase();

    // Assert
    expect(result, Left(ServerFailure(message: 'Server error occurred.')));
    verify(mockProductRepository.getAllProducts());
    verifyNoMoreInteractions(mockProductRepository);
  });
}

