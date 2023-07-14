import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/blocs/bloc_access_methods.dart';
import 'package:study_savvy_app/services/api_profile.dart';
import 'package:study_savvy_app/utils/exception.dart';
import 'bloc_access_methods_test.mocks.dart';

@GenerateMocks([ProfileService])
void main() {
  group("AccessMethodBloc", () {
    test('emit null when AccessMethodEventAccessToken build', () async {
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc();
      expect(accessMethodBloc.state, null);
    });
  });
  group('AccessMethodBloc ApiKey Event', () {
    test('emits [PENDING, SUCCESS] when AccessMethodEventApiKey succeeded', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setApiKey(any)).thenAnswer((_) async => '');

      final expectedStates = [
        AccessMethodState("PENDING", null).toString(),
        AccessMethodState("SUCCESS", null).toString(),
      ];
      accessMethodBloc.add(AccessMethodEventApiKey('apiKey'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );

      await untilCalled(mockProfileService.setApiKey(any));
      verify(mockProfileService.setApiKey(any)).called(1);

    });
    test('emits [PENDING, FAILURE-Client] when AccessMethodEventApiKey fail', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setApiKey(any)).thenThrow(ClientException("Client's error"));

      final expectedStates = [
        AccessMethodState("PENDING", null).toString(),
        AccessMethodState("FAILURE", "CLIENT").toString(),
      ];
      accessMethodBloc.add(AccessMethodEventApiKey('apiKey'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockProfileService.setApiKey(any));
      verify(mockProfileService.setApiKey(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Exist] when AccessMethodEventApiKey fail', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setApiKey(any)).thenThrow(ExistException("Source not exist"));

      final expectedStates = [
        AccessMethodState("PENDING", null).toString(),
        AccessMethodState("FAILURE", "EXIST").toString(),
      ];
      accessMethodBloc.add(AccessMethodEventApiKey('apiKey'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockProfileService.setApiKey(any));
      verify(mockProfileService.setApiKey(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Auth] when AccessMethodEventApiKey fail', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setApiKey(any)).thenThrow(AuthException("JWT invalid"));

      final expectedStates = [
        AccessMethodState("PENDING", null).toString(),
        AccessMethodState("FAILURE", "AUTH").toString(),
      ];
      accessMethodBloc.add(AccessMethodEventApiKey('apiKey'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockProfileService.setApiKey(any));
      verify(mockProfileService.setApiKey(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Server] when AccessMethodEventApiKey fail', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setApiKey(any)).thenThrow(ServerException("Server's error"));

      final expectedStates = [
        AccessMethodState("PENDING", null).toString(),
        AccessMethodState("FAILURE", "SERVER").toString(),
      ];
      accessMethodBloc.add(AccessMethodEventApiKey('apiKey'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockProfileService.setApiKey(any));
      verify(mockProfileService.setApiKey(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Unknown] when AccessMethodEventApiKey fail', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setApiKey(any)).thenThrow(Exception("Failed in unknown reason"));

      final expectedStates = [
        AccessMethodState("PENDING", null).toString(),
        AccessMethodState("FAILURE", "UNKNOWN").toString(),
      ];
      accessMethodBloc.add(AccessMethodEventApiKey('apiKey'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockProfileService.setApiKey(any));
      verify(mockProfileService.setApiKey(any)).called(1);
    });
  });
  group('AccessMethodBloc AccessToken Event', () {
    test('emits [PENDING, SUCCESS] when AccessMethodEventAccessToken succeeded', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setAccessToken(any)).thenAnswer((_) async => '');

      final expectedStates = [
        AccessMethodState("PENDING", null).toString(),
        AccessMethodState("SUCCESS", null).toString(),
      ];
      accessMethodBloc.add(AccessMethodEventAccessToken('AccessToken'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );

      await untilCalled(mockProfileService.setAccessToken(any));
      verify(mockProfileService.setAccessToken(any)).called(1);

    });
    test('emits [PENDING, FAILURE-Client] when AccessMethodEventAccessToken fail', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setAccessToken(any)).thenThrow(ClientException("Client's error"));

      final expectedStates = [
        AccessMethodState("PENDING", null).toString(),
        AccessMethodState("FAILURE", "CLIENT").toString(),
      ];
      accessMethodBloc.add(AccessMethodEventAccessToken('AccessToken'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockProfileService.setAccessToken(any));
      verify(mockProfileService.setAccessToken(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Exist] when AccessMethodEventAccessToken fail', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setAccessToken(any)).thenThrow(ExistException("Source not exist"));

      final expectedStates = [
        AccessMethodState("PENDING", null).toString(),
        AccessMethodState("FAILURE", "EXIST").toString(),
      ];
      accessMethodBloc.add(AccessMethodEventAccessToken('AccessToken'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockProfileService.setAccessToken(any));
      verify(mockProfileService.setAccessToken(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Auth] when AccessMethodEventAccessToken fail', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setAccessToken(any)).thenThrow(AuthException("JWT invalid"));

      final expectedStates = [
        AccessMethodState("PENDING", null).toString(),
        AccessMethodState("FAILURE", "AUTH").toString(),
      ];
      accessMethodBloc.add(AccessMethodEventAccessToken('AccessToken'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockProfileService.setAccessToken(any));
      verify(mockProfileService.setAccessToken(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Server] when AccessMethodEventAccessToken fail', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setAccessToken(any)).thenThrow(ServerException("Server's error"));

      final expectedStates = [
        AccessMethodState("PENDING", null).toString(),
        AccessMethodState("FAILURE", "SERVER").toString(),
      ];
      accessMethodBloc.add(AccessMethodEventAccessToken('AccessToken'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockProfileService.setAccessToken(any));
      verify(mockProfileService.setAccessToken(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Unknown] when AccessMethodEventAccessToken fail', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setAccessToken(any)).thenThrow(Exception("Failed in unknown reason"));

      final expectedStates = [
        AccessMethodState("PENDING", null).toString(),
        AccessMethodState("FAILURE", "UNKNOWN").toString(),
      ];
      accessMethodBloc.add(AccessMethodEventAccessToken('AccessToken'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockProfileService.setAccessToken(any));
      verify(mockProfileService.setAccessToken(any)).called(1);
    });
  });
  group("AccessMethodBloc Reset Event", () {
    test('emits null when Reset', () async {
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc();
      accessMethodBloc.add(AccessMethodEventReset());
      expect(accessMethodBloc.state, null);
    });
  });
  group("AccessMethodBloc Unknown Event", () {
    test('throw exception when Unknown happen', () async {
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc();
      accessMethodBloc.add(AccessMethodEventUnknown());
      // expectLater(()=>), throwsException);
    });
  });
}
