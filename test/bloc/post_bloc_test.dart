import 'package:bloc_test/bloc_test.dart';
import 'package:botiblog/src/home/post_editor/post_bloc.dart';
import 'package:botiblog/src/home/post_editor/post_event.dart';
import 'package:botiblog/src/home/post_editor/post_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';
import '../mocks.dart';

void main() {
  group(
    'PostBloc',
    () {
      PostBloc bloc;
      MockUserRepository userRepository;
      MockPostRepository postRepository;
      MockCurrentDateTime currentDateTime;

      setUp(() {
        userRepository = MockUserRepository();
        postRepository = MockPostRepository();
        currentDateTime = MockCurrentDateTime();
        bloc = PostBloc(postRepository, userRepository, currentDateTime);

        when(currentDateTime.now())
            .thenAnswer((realInvocation) => DateTime(2020, 1, 1));

        when(userRepository.get())
            .thenAnswer((realInvocation) => Future.value(Mocks.userModel()));
      });

      tearDown(() {
        bloc.close();
      });

      test('initial state is PostInitial', () async {
        expect(bloc.initialState, PostInitial());
      });

      group('PostAdded', () {
        blocTest(
          'emits [PostLoadInProgress, PostLoadSuccess] when PostAdded is added',
          build: () async => bloc,
          act: (bloc) async {
            bloc.add(PostAdded(Mocks.userPost().text));
          },
          expect: [PostLoadInProgress(), PostLoadSuccess()],
        );

        blocTest(
          'emits [PostLoadInProgress, PostLoadFailure] when PostAdded is added',
          build: () async => bloc,
          act: (bloc) async {
            when(postRepository.add(any))
                .thenAnswer((realInvocation) => throw Exception());
            bloc.add(PostAdded(Mocks.userPost().text));
          },
          expect: [PostLoadInProgress(), PostLoadFailure()],
        );
      });

      group('PostRemoved', () {
        blocTest(
          'emits [PostLoadInProgress, PostLoadSuccess] when PostRemoved is added',
          build: () async => bloc,
          act: (bloc) async {
            bloc.add(PostRemoved(Mocks.userPostResponseModel()));
          },
          expect: [PostLoadInProgress(), PostLoadSuccess()],
        );

        blocTest(
          'emits [PostLoadInProgress, PostLoadFailure] when PostRemoved is added',
          build: () async => bloc,
          act: (bloc) async {
            when(postRepository.remove(any))
                .thenAnswer((realInvocation) => throw Exception());
            bloc.add(PostRemoved(Mocks.userPostResponseModel()));
          },
          expect: [PostLoadInProgress(), PostLoadFailure()],
        );
      });

      group('PostUpdated', () {
        blocTest(
          'emits [PostLoadInProgress, PostLoadSuccess] when PostUpdated is added',
          build: () async => bloc,
          act: (bloc) async {
            bloc.add(PostUpdated(Mocks.userPostResponseModel(),'updated'));
          },
          expect: [PostLoadInProgress(), PostLoadSuccess()],
        );

        blocTest(
          'emits [PostLoadInProgress, PostLoadFailure] when PostUpdated is added',
          build: () async => bloc,
          act: (bloc) async {
            when(postRepository.update(any))
                .thenAnswer((realInvocation) => throw Exception());
            bloc.add(PostUpdated(Mocks.userPostResponseModel(),'updated'));
          },
          expect: [PostLoadInProgress(), PostLoadFailure()],
        );
      });
    },
  );
}
