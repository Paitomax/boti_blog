import 'package:bloc_test/bloc_test.dart';
import 'package:botiblog/src/sign_in/sign_in_bloc.dart';
import 'package:botiblog/src/sign_in/sign_in_event.dart';
import 'package:botiblog/src/sign_in/sign_in_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';
import '../mocks.dart';

void main() {
  group('SignInBloc', () {
    SignInBloc bloc;
    MockAuthBloc authBloc;
    MockSignInRepository signInRepository;

    setUp(() {
      authBloc = MockAuthBloc();
      signInRepository = MockSignInRepository();
      bloc = SignInBloc(signInRepository, authBloc);
    });

    tearDown(() {
      bloc.close();
      authBloc.close();
    });

    test('initial state is SignInInitial', () async {
      expect(bloc.initialState, SignInInitial());
    });

    blocTest(
      'emits [SignInLoadInProgress, SignInInitial] when SignInRequested is added',
      build: () async => bloc,
      act: (bloc) async {
        when(signInRepository.requestLogin(any, any))
            .thenAnswer((realInvocation) => Future.value(Mocks.userModel()));
        bloc.add(SignInRequested('', '', remember: false));
      },
      expect: [SignInLoadInProgress(), SignInInitial()],
    );

    blocTest(
      'emits [SignInLoadInProgress, SignInLoadFailureWrongUserOrPass] when SignInRequested is added',
      build: () async => bloc,
      act: (bloc) async {
        when(signInRepository.requestLogin(any, any))
            .thenAnswer((realInvocation) => Future.value(null));
        bloc.add(SignInRequested('', '', remember: false));
      },
      expect: [SignInLoadInProgress(), SignInLoadFailureWrongUserOrPass()],
    );

    blocTest(
      'emits [SignInLoadInProgress, SignInLoadFailure] when SignInRequested is added',
      build: () async => bloc,
      act: (bloc) async {
        when(signInRepository.requestLogin(any, any))
            .thenAnswer((realInvocation) => throw Exception());
        bloc.add(SignInRequested('', '', remember: true));
      },
      expect: [SignInLoadInProgress(), SignInLoadFailure()],
    );
  });
}
