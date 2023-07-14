import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/blocs/bloc_access_methods.dart';
import 'package:study_savvy_app/services/api_profile.dart';
import 'bloc_access_methods_test.mocks.dart';

@GenerateMocks([ProfileService])
void main() {
  group('AccessMethodBloc', () {
    test('emits [PENDING, SUCCESS] when AccessMethodEventApiKey succeeded', () async {
      final MockProfileService mockProfileService=MockProfileService();
      final AccessMethodBloc accessMethodBloc=AccessMethodBloc(apiService: mockProfileService);

      when(mockProfileService.setApiKey(any)).thenAnswer((_) async => '');

      final expectedStates = [
        AccessMethodState("PENDING", null),
        AccessMethodState("SUCCESS", null),
      ];

      accessMethodBloc.add(AccessMethodEventApiKey('apiKey'));
      await expectLater(
        accessMethodBloc.stream.map((event) => event),
        emitsInOrder(expectedStates),
      );

      // await untilCalled(mockProfileService.setApiKey(any));
      // verify(mockProfileService.setApiKey(any)).called(1);
    });
  });
}
