import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/error/exception.dart';
import 'package:myapp/features/product/data/datasource/remote_data_source.dart';
import '../../../../helper/dummy_data.dart';
import '../datasource/remote_data_source_test.mocks.dart'; // Import the dummy data

// Mock class for http.Client

@GenerateMocks([http.Client])
void main() {
  late RemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getAllProducts', () {
    test('should perform a GET request on a URL', () async {
      // Arrange
      final uri = Uri.parse(RemoteDataSourceImpl.baseUrl);
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(
          json.encode(
              dummyProducts.map((product) => product.toJson()).toList()),
          200,
        ),
      );

      // Act
      final result = await dataSource.getAllProducts();

      // Assert
      verify(mockHttpClient.get(uri));
      expect(result, equals(dummyProducts));
    });

    test('should throw a ServerException for non-200 response', () async {
      // Arrange
      final uri = Uri.parse(RemoteDataSourceImpl.baseUrl);
      when(mockHttpClient.get(uri)).thenAnswer(
        (_) async => http.Response('Something went wrong', 404),
      );

      // Act
      final call = dataSource.getAllProducts;

      // Assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
