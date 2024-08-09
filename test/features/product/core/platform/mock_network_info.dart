// test/mocks/mock_network_info.dart
import 'package:mockito/mockito.dart';
import 'package:myapp/core/platform/network_info.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {
  @override
  Future<bool> get isConnected => super.noSuchMethod(
    Invocation.getter(#isConnected),
    returnValue: Future.value(true),
    returnValueForMissingStub: Future.value(true),
  );
}
