import 'package:bloc_test/bloc_test.dart';
import 'package:botiblog/src/home/post_editor/post_state.dart';
import 'package:botiblog/src/home/user_news/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';
import '../mocks.dart';

void main() {
  group(
    'UserNewsBloc',
    () {
      UserNewsBloc bloc;

      MockUserRepository userRepository;
      MockPostRepository postRepository;
      MockPostBloc postBloc;

      setUp(() {
        userRepository = MockUserRepository();
        postRepository = MockPostRepository();
        postBloc = MockPostBloc();
        bloc = UserNewsBloc(postBloc, postRepository, userRepository);

        when(userRepository.get())
            .thenAnswer((realInvocation) => Future.value(Mocks.userModel()));
      });

      tearDown(() {
        bloc.close();
      });

      test('initial state is UserNewsLoadInProgress', () async {
        expect(bloc.initialState, UserNewsLoadInProgress());
      });

      blocTest(
        'emits [UserNewsLoadSuccess] when UserNewsLoaded is added',
        build: () async => bloc,
        act: (bloc) async {
          when(postRepository.fetch(any)).thenAnswer((realInvocation) =>
              Future.value(Mocks.listPostModel()));
          bloc.add(UserNewsLoaded());
        },
        expect: [
          UserNewsLoadSuccess(
              Mocks.listPostModel(), Mocks.userModel())
        ],
      );
      blocTest(
        'emits [UserNewsLoadSuccessEmpty] when UserNewsLoaded is added',
        build: () async => bloc,
        act: (bloc) async {
          when(postRepository.fetch(any))
              .thenAnswer((realInvocation) => Future.value([]));
          bloc.add(UserNewsLoaded());
        },
        expect: [UserNewsLoadSuccessEmpty()],
      );
      blocTest(
        'emits [UserNewsLoadFailure] when UserNewsLoaded is added',
        build: () async => bloc,
        act: (bloc) async {
          when(postRepository.fetch(any))
              .thenAnswer((realInvocation) => throw Exception());
          bloc.add(UserNewsLoaded());
        },
        expect: [UserNewsLoadFailure()],
      );
      blocTest(
        'emits [UserNewsLoadSuccessEmpty] when PostLoadSuccess is added',
        build: () async {
          whenListen(postBloc, Stream.fromIterable([PostLoadSuccess()]));
          when(postRepository.fetch(any))
              .thenAnswer((realInvocation) => Future.value([]));
          return UserNewsBloc(postBloc, postRepository, userRepository);
        },
        expect: [UserNewsLoadSuccessEmpty()],
      );
      blocTest(
        'emits [] when PostLoadSuccess is added',
        build: () async {
          whenListen(postBloc,
              Stream.fromIterable([PostLoadSuccess(hadChanges: false)]));
          when(postRepository.fetch(any))
              .thenAnswer((realInvocation) => Future.value([]));
          return UserNewsBloc(postBloc, postRepository, userRepository);
        },
        expect: [],
      );
    },
  );
}
