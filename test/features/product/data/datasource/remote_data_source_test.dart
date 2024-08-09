import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/core/error/exception.dart';
import 'package:myapp/features/product/data/datasource/remote_data_source.dart';
import '../../../../helper/dummy_data.dart'; // Import the dummy data
import 'remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late RemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getAllProducts', () {
    test('should return a list of ProductModels when the response code is 200',
        () async {
      // Arrange
      final uri = Uri.parse(RemoteDataSourceImpl.baseUrl);
      when(mockHttpClient.get(uri)).thenAnswer(
        (_) async => http.Response(
          json.encode(dummy_data),
          200,
        ),
      );

      // Act
      final result = await dataSource.getAllProducts();

      // Assert
      expect(result, equals(dummyProducts));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
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
