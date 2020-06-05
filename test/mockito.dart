import 'package:bloc_test/bloc_test.dart';
import 'package:botiblog/src/shared/auth/auth_bloc.dart';
import 'package:botiblog/src/shared/auth/auth_event.dart';
import 'package:botiblog/src/shared/auth/auth_state.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';
import 'package:botiblog/src/sign_in/sign_in_repository_interface.dart';
import 'package:botiblog/src/sign_up/sign_up_repository_interface.dart';
import 'package:mockito/mockito.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}
class MockUserRepository extends Mock implements UserRepositoryInterface {}
class MockSignInRepository extends Mock implements SignInRepositoryInterface {}
class MockSignUpRepository extends Mock implements SignUpRepositoryInterface {}