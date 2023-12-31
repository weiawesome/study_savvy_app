// Mocks generated by Mockito 5.4.2 from annotations
// in study_savvy_app/test/bloc/bloc_access_methods_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:http/http.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:study_savvy_app/models/profile/model_profile.dart' as _i4;
import 'package:study_savvy_app/services/profile/api_profile.dart' as _i5;
import 'package:study_savvy_app/services/utils/jwt_storage.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeJwtService_0 extends _i1.SmartFake implements _i2.JwtService {
  _FakeJwtService_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeClient_1 extends _i1.SmartFake implements _i3.Client {
  _FakeClient_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeProfile_2 extends _i1.SmartFake implements _i4.Profile {
  _FakeProfile_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProfileService].
///
/// See the documentation for Mockito's code generation for more information.
class MockProfileService extends _i1.Mock implements _i5.ProfileService {
  MockProfileService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.JwtService get jwtService => (super.noSuchMethod(
        Invocation.getter(#jwtService),
        returnValue: _FakeJwtService_0(
          this,
          Invocation.getter(#jwtService),
        ),
      ) as _i2.JwtService);
  @override
  set jwtService(_i2.JwtService? _jwtService) => super.noSuchMethod(
        Invocation.setter(
          #jwtService,
          _jwtService,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.Client get httpClient => (super.noSuchMethod(
        Invocation.getter(#httpClient),
        returnValue: _FakeClient_1(
          this,
          Invocation.getter(#httpClient),
        ),
      ) as _i3.Client);
  @override
  set httpClient(_i3.Client? _httpClient) => super.noSuchMethod(
        Invocation.setter(
          #httpClient,
          _httpClient,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Future<_i4.Profile> getProfile() => (super.noSuchMethod(
        Invocation.method(
          #getProfile,
          [],
        ),
        returnValue: _i6.Future<_i4.Profile>.value(_FakeProfile_2(
          this,
          Invocation.method(
            #getProfile,
            [],
          ),
        )),
      ) as _i6.Future<_i4.Profile>);
  @override
  _i6.Future<void> setApiKey(String? apikey) => (super.noSuchMethod(
        Invocation.method(
          #setApiKey,
          [apikey],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setAccessToken(String? accessToken) => (super.noSuchMethod(
        Invocation.method(
          #setAccessToken,
          [accessToken],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> resetPassword(_i4.UpdatePwd? data) => (super.noSuchMethod(
        Invocation.method(
          #resetPassword,
          [data],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}
