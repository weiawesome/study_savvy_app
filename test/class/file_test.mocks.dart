// Mocks generated by Mockito 5.4.2 from annotations
// in study_savvy_app/test/class/file_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;
import 'package:study_savvy_app/models/files/model_files.dart' as _i2;

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

/// A class which mocks [File].
///
/// See the documentation for Mockito's code generation for more information.
class MockFile extends _i1.Mock implements _i2.File {
  MockFile() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get id => (super.noSuchMethod(
        Invocation.getter(#id),
        returnValue: '',
      ) as String);
  @override
  String get time => (super.noSuchMethod(
        Invocation.getter(#time),
        returnValue: '',
      ) as String);
  @override
  String get status => (super.noSuchMethod(
        Invocation.getter(#status),
        returnValue: '',
      ) as String);
  @override
  String get type => (super.noSuchMethod(
        Invocation.getter(#type),
        returnValue: '',
      ) as String);
}