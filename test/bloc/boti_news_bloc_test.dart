import 'package:bloc_test/bloc_test.dart';
import 'package:botiblog/src/home/boti_news/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';
import '../mocks.dart';

void main() {
  group(
    'BotiNewsBloc',
    () {
      BotiNewsBloc bloc;
      MockBotiNewsRepository botiNewsRepository;

      setUp(() {
        botiNewsRepository = MockBotiNewsRepository();
        bloc = BotiNewsBloc(botiNewsRepository);
      });

      tearDown(() {
        bloc.close();
      });

      test('initial state is BotiNewsLoadInProgress', () async {
        expect(bloc.initialState, BotiNewsLoadInProgress());
      });

      group('BotiNewsLoaded', () {
        blocTest(
          'emits [BotiNewsLoadInProgress, BotiNewsLoadSuccess] when BotiNewsLoaded is added',
          build: () async => bloc,
          act: (bloc) async {
            when(botiNewsRepository.fetch()).thenAnswer(
                (realInvocation) => Future.value(Mocks.postResponseModel()));
            bloc.add(BotiNewsLoaded());
          },
          skip: 0,
          expect: [
            BotiNewsLoadInProgress(),
            BotiNewsLoadSuccess(Mocks.postResponseModel().news),
          ],
        );

        blocTest(
          'emits [BotiNewsLoadInProgress, BotiNewsLoadSuccess] when BotiNewsLoaded is added',
          build: () async => bloc,
          act: (bloc) async {
            when(botiNewsRepository.fetch()).thenAnswer((realInvocation) =>
                Future.value(Mocks.botiNewsResponseModelEmpty()));
            bloc.add(BotiNewsLoaded());
          },
          skip: 0,
          expect: [BotiNewsLoadInProgress(), BotiNewsLoadSuccessEmpty()],
        );

        blocTest(
          'emits [PostLoadInProgress, PostLoadFailure] when BotiNewsLoaded is added',
          build: () async => bloc,
          act: (bloc) async {
            when(botiNewsRepository.fetch())
                .thenAnswer((realInvocation) => throw Exception());
            bloc.add(BotiNewsLoaded());
          },
          skip: 0,
          expect: [BotiNewsLoadInProgress(), BotiNewsLoadFailure()],
        );
      });
    },
  );
}
