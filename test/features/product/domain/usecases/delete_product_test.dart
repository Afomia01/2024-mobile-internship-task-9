// delete_product_test.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/features/product/use_case/delete.dart';
import '../../../../product_repository_mock.mocks.dart';
import 'package:myapp/core/failure/failure.dart'; // Ensure this path is correct

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
        .thenAnswer((_) async => Right(null));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, Right(null));
    verify(mockProductRepository.deleteProduct(params.id));
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return failure when repository fails to delete product', () async {
    // Arrange
    final failure = ServerFailure(message: 'Unable to delete product');
    when(mockProductRepository.deleteProduct(any))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, Left(failure));
    verify(mockProductRepository.deleteProduct(params.id));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
