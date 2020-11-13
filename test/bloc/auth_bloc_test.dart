import 'package:bloc_test/bloc_test.dart';
import 'package:botiblog/src/shared/auth/bloc.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';

void main() {
  group('AuthBloc', () {
    final String email = 'jose@teste.com.br';
    AuthBloc authBloc;

    setUp(() {
      UserRepositoryInterface userRepository = MockUserRepository();
      authBloc = AuthBloc(userRepository);

      when(userRepository.save(any))
          .thenAnswer((realInvocation) => Future.value());
      when(userRepository.logout())
          .thenAnswer((realInvocation) => Future.value(true));
      when(userRepository.getLastUser())
          .thenAnswer((realInvocation) => Future.value(email));
      when(userRepository.rememberUser(email))
          .thenAnswer((realInvocation) => Future.value());
    });

    tearDown(() {
      authBloc.close();
    });

    test('initial state is AuthInitial', () async {
      expect(authBloc.initialState, AuthInitial());
    });

    blocTest(
      'emits [AuthUnauthenticated] when AuthAppInitiated is added',
      build: () async => authBloc,
      act: (bloc) async => bloc.add(AuthAppInitiated()),
      expect: [AuthUnauthenticated(email)],
    );

    blocTest(
      'emits [AuthUnauthenticated] when AuthLoggedIn(userModel, true) is added',
      build: () async => authBloc,
      act: (bloc) async => bloc.add(AuthLoggedIn(UserModel(''), true)),
      expect: [AuthAuthenticated()],
    );

    blocTest(
      'emits [AuthUnauthenticated] when AuthLoggedIn(null, false) is added',
      build: () async => authBloc,
      act: (bloc) async => bloc.add(AuthLoggedIn(null, false)),
      expect: [AuthAuthenticated()],
    );

    blocTest(
      'emits [AuthUnauthenticated] when AuthLoggedOut() is added',
      build: () async => authBloc,
      act: (bloc) async => bloc.add(AuthLoggedOut()),
      expect: [AuthUnauthenticated(email)],
    );
  });
}
