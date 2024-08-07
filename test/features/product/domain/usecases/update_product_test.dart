// update_product_test.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/use_case/update.dart';
import '../../../../product_repository_mock.mocks.dart';

void main() {
  late UpdateProduct useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = UpdateProduct(mockProductRepository);
  });

  final product = Product(
    id: 1,
    name: 'Updated Product',
    catagory: 'Sneakers',
    description: 'Updated Description',
    price: 250,
  );

  test('should update product through the repository', () async {
    // Arrange
    when(mockProductRepository.updateProduct(any))
        .thenAnswer((_) async => Right(null));

    // Act
    final result = await useCase(product);

    // Assert
    expect(result, Right(null));
    verify(mockProductRepository.updateProduct(product));
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return failure when repository fails to update product', () async {
    // Arrange
    final failure = ServerFailure(message: 'Unable to update product');
    when(mockProductRepository.updateProduct(any))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(product);

    // Assert
    expect(result, Left(failure));
    verify(mockProductRepository.updateProduct(product));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
