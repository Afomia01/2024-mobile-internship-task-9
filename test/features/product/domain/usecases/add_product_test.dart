// add_product_test.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/use_case/add.dart';
import '../../../../product_repository_mock.mocks.dart';

void main() {
  late addProduct useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = addProduct(mockProductRepository);
  });

  final product = Product(
    id: 1,
    name: 'New Product',
    catagory: 'Sneakers',
    description: 'Comfortable',
    price: 100,
  );

  test('should add product through the repository', () async {
    // Arrange
    when(mockProductRepository.addProduct(any))
        .thenAnswer((_) async => Right(product));

    // Act
    final result = await useCase(product);

    // Assert
    expect(result, Right(product));
    verify(mockProductRepository.addProduct(product));
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return failure when repository fails to add product', () async {
    // Arrange
    final failure = ServerFailure(message: 'Unable to add product');
    when(mockProductRepository.addProduct(any))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(product);

    // Assert
    expect(result, Left(failure));
    verify(mockProductRepository.addProduct(product));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
