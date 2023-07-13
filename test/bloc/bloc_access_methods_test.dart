import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/blocs/bloc_access_methods.dart';
import 'package:study_savvy_app/services/api_profile.dart';
import 'bloc_access_methods_test.mocks.dart';

@GenerateMocks([ProfileService])
void main() {
  // group('AccessMethodBloc', () {
  //   late AccessMethodBloc accessMethodBloc;
  //   late MockProfileService mockProfileService;
  //
  //   setUp(() {
  //     mockProfileService = MockProfileService();
  //     accessMethodBloc = AccessMethodBloc(profileService: mockProfileService);
  //   });
  //
  //   tearDown(() {
  //     accessMethodBloc.close();
  //   });
  //
  //   test('emits [PENDING, SUCCESS] when AccessMethodEventApiKey succeeded', () async {
  //     const expectedResponse = 'success';
  //     when(mockProfileService.setApiKey(any)).thenAnswer((_) async => expectedResponse);
  //
  //     final expectedStates = [
  //       AccessMethodState("PENDING", null),
  //       AccessMethodState("SUCCESS", null),
  //     ];
  //
  //     expectLater(
  //       accessMethodBloc.stream,
  //       emitsInOrder(expectedStates),
  //     );
  //
  //     accessMethodBloc.add(AccessMethodEventApiKey('apiKey'));
  //   });
  // });
}
