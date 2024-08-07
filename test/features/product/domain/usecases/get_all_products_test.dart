// get_all_products_test.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/use_case/getAllProducts.dart';
import '../../../../product_repository_mock.mocks.dart';

void main() {
  late GetAllProducts useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = GetAllProducts(mockProductRepository);
  });

  final productList = [
    Product(id: 1, name: 'Test Product 1',  description: 'Comfy', price: 200, image: 'assets/boot.jpg'),
    Product(id: 2, name: 'Test Product 2',  description: 'Stylish', price: 150, image: 'assets/boot.jpg'),
  ];

  test('should get all products from the repository', () async {
    // Arrange
    when(mockProductRepository.getAllProducts())
        .thenAnswer((_) async => Right(productList));

    // Act
    final result = await useCase();

    // Assert
    expect(result, Right(productList));
    verify(mockProductRepository.getAllProducts());
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return failure when repository fails to get products', () async {
    // Arrange
    const failure = ServerFailure(message: 'Unable to fetch products');
    when(mockProductRepository.getAllProducts())
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase();

    // Assert
    expect(result, Left(failure));
    verify(mockProductRepository.getAllProducts());
    verifyNoMoreInteractions(mockProductRepository);
  });
}
