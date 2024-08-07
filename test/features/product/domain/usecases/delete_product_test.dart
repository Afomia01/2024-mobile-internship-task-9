// delete_product_test.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart'; // Ensure this path is correct
import 'package:myapp/features/product/domain/use_case/delete.dart';

import '../../../../product_repository_mock.mocks.dart';

void main() {
  late DeleteProduct useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = DeleteProduct(mockProductRepository);
  });

  final params = DeleteProductParams(id: '1');

  test('should delete product through the repository', () async {
    // Arrange
    when(mockProductRepository.deleteProduct(any))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, const Right(null));
    verify(mockProductRepository.deleteProduct(params.id));
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return failure when repository fails to delete product', () async {
    // Arrange
    const failure = ServerFailure(message: 'Unable to delete product');
    when(mockProductRepository.deleteProduct(any))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, const Left(failure));
    verify(mockProductRepository.deleteProduct(params.id));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
