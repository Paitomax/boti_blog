import 'package:bloc_test/bloc_test.dart';
import 'package:botiblog/src/home/boti_news/boti_news_repository_interface.dart';
import 'package:botiblog/src/home/post_editor/post_bloc.dart';
import 'package:botiblog/src/home/post_editor/post_event.dart';
import 'package:botiblog/src/home/post_editor/post_repository_interface.dart';
import 'package:botiblog/src/home/post_editor/post_state.dart';
import 'package:botiblog/src/home/user_news/bloc.dart';
import 'package:botiblog/src/shared/auth/auth_bloc.dart';
import 'package:botiblog/src/shared/auth/auth_event.dart';
import 'package:botiblog/src/shared/auth/auth_state.dart';
import 'package:botiblog/src/shared/current_datetime/current_date_interface.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';
import 'package:botiblog/src/sign_in/bloc.dart';
import 'package:botiblog/src/sign_in/sign_in_repository_interface.dart';
import 'package:botiblog/src/sign_up/bloc.dart';
import 'package:botiblog/src/sign_up/sign_up_repository_interface.dart';
import 'package:mockito/mockito.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}
class MockPostBloc extends MockBloc<PostEvent, PostState> implements PostBloc {}
class MockSignInBloc extends MockBloc<SignInEvent, SignInState> implements SignInBloc {}
class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState> implements SignUpBloc {}
class MockUserNewsBloc extends MockBloc<UserNewsEvent, UserNewsState> implements UserNewsBloc {}

class MockUserRepository extends Mock implements UserRepositoryInterface {}
class MockSignInRepository extends Mock implements SignInRepositoryInterface {}
class MockSignUpRepository extends Mock implements SignUpRepositoryInterface {}
class MockPostRepository extends Mock implements PostRepositoryInterface {}
class MockCurrentDateTime extends Mock implements CurrentDateTimeInterface {}
class MockBotiNewsRepository extends Mock implements BotiNewsRepositoryInterface {}
