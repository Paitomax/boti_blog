import 'package:bloc_test/bloc_test.dart';
import 'package:botiblog/src/sign_up/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';
import '../mocks.dart';

void main() {
  group('SignUpBloc', () {
    SignUpBloc bloc;
    MockSignUpRepository signUpRepository;
    MockUserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
      signUpRepository = MockSignUpRepository();
      bloc = SignUpBloc(signUpRepository, userRepository);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is SignUpInitial', () async {
      expect(bloc.initialState, SignUpInitial());
    });

    blocTest(
      'emits [SignUpLoadInProgress, SignUpLoadSuccess] when SignUpRequested is added',
      build: () async => bloc,
      act: (bloc) async {
        when(signUpRepository.requestSignUp(any))
            .thenAnswer((realInvocation) => Future.value(Mocks.userModel()));
        bloc.add(SignUpRequested(Mocks.accountUserModel()));
      },
      expect: [SignUpLoadInProgress(), SignUpLoadSuccess(Mocks.userModel())],
    );

    blocTest(
      'emits [SignUpLoadInProgress, SignUpLoadFailureEmailAlreadyRegistered] when SignUpRequested is added',
      build: () async => bloc,
      act: (bloc) async {
        when(signUpRepository.requestSignUp(any))
            .thenAnswer((realInvocation) => Future.value(null));
        bloc.add(SignUpRequested(Mocks.accountUserModel()));
      },
      expect: [
        SignUpLoadInProgress(),
        SignUpLoadFailureEmailAlreadyRegistered()
      ],
    );

    blocTest(
      'emits [SignUpLoadInProgress, SignUpLoadFailure] when SignUpRequested is added',
      build: () async => bloc,
      act: (bloc) async {
        when(signUpRepository.requestSignUp(any))
            .thenAnswer((realInvocation) => throw Exception());
        bloc.add(SignUpRequested(Mocks.accountUserModel()));
      },
      expect: [SignUpLoadInProgress(), SignUpLoadFailure()],
    );
  });
}
