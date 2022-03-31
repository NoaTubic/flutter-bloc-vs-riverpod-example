// Mocks generated by Mockito 5.0.17 from annotations
// in bloc_vs_riverpod_example/test/bloc/facts_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:bloc_vs_riverpod_example/common/models/api_response.dart'
    as _i2;
import 'package:bloc_vs_riverpod_example/data/models/fact.dart' as _i5;
import 'package:bloc_vs_riverpod_example/domain/api_repository.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeApiResponse_0<T> extends _i1.Fake implements _i2.ApiResponse<T> {}

/// A class which mocks [ApiRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiRepository extends _i1.Mock implements _i3.ApiRepository {
  MockApiRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ApiResponse<_i5.Fact>> fetchFact() =>
      (super.noSuchMethod(Invocation.method(#fetchFact, []),
              returnValue: Future<_i2.ApiResponse<_i5.Fact>>.value(
                  _FakeApiResponse_0<_i5.Fact>()))
          as _i4.Future<_i2.ApiResponse<_i5.Fact>>);
}
