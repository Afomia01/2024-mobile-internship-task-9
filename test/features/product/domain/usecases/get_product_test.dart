import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/use_case/getProduct.dart';
import '../../../../product_repository_mock.mocks.dart';

void main() {
  late ViewProduct useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = ViewProduct(mockProductRepository);
  });

  const productId = '1';
  final product = Product(
    id: 1,
    name: 'Test Product',
    description: 'Comfy',
    price: 200.0,
    image: 'assets/boot.jpg'
  );

  test('should get product by id from the repository', () async {
    // Arrange
    when(mockProductRepository.getProductById(productId))
        .thenAnswer((_) async => Right(product));

    // Act
    final result = await useCase(productId);

    // Assert
    expect(result, Right(product));
    verify(mockProductRepository.getProductById(productId));
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return failure when repository fails to get product', () async {
    // Arrange
    const failure = ServerFailure(message: 'Unable to get product');
    when(mockProductRepository.getProductById(productId))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(productId);

    // Assert
    expect(result, Left(failure));
    verify(mockProductRepository.getProductById(productId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
