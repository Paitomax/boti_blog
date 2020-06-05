import 'package:botiblog/src/app/app_routes.dart';
import 'package:botiblog/src/home/boti_news/boti_news_bloc.dart';
import 'package:botiblog/src/home/boti_news/boti_news_data_provider.dart';
import 'package:botiblog/src/home/boti_news/boti_news_repository_interface.dart';
import 'package:botiblog/src/home/boti_news/boti_repository.dart';
import 'package:botiblog/src/home/home_screen.dart';
import 'package:botiblog/src/home/post_editor/post_bloc.dart';
import 'package:botiblog/src/home/post_editor/post_data_provider.dart';
import 'package:botiblog/src/home/post_editor/post_repository.dart';
import 'package:botiblog/src/home/post_editor/post_repository_interface.dart';
import 'package:botiblog/src/home/user_news/user_news_bloc.dart';
import 'package:botiblog/src/shared/auth/auth_bloc.dart';
import 'package:botiblog/src/shared/auth/auth_event.dart';
import 'package:botiblog/src/shared/auth/auth_state.dart';
import 'package:botiblog/src/shared/current_datetime/current_date.dart';
import 'package:botiblog/src/shared/current_datetime/current_date_interface.dart';
import 'package:botiblog/src/shared/user/user_repository.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';
import 'package:botiblog/src/sign_in/sign_in_bloc.dart';
import 'package:botiblog/src/sign_in/sign_in_data_provider.dart';
import 'package:botiblog/src/sign_in/sign_in_repository.dart';
import 'package:botiblog/src/sign_in/sign_in_repository_interface.dart';
import 'package:botiblog/src/sign_in/sign_in_screen.dart';
import 'package:botiblog/src/sign_up/sign_up_bloc.dart';
import 'package:botiblog/src/sign_up/sign_up_data_provider.dart';
import 'package:botiblog/src/sign_up/sign_up_repository.dart';
import 'package:botiblog/src/sign_up/sign_up_repository_interface.dart';
import 'package:botiblog/src/splash/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BotiAppGlobalProvider extends StatelessWidget {
  final Widget child;

  const BotiAppGlobalProvider({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepositoryInterface>(
      create: (BuildContext context) => UserRepository(),
      child: BlocProvider<AuthBloc>(
        create: (BuildContext context) => AuthBloc(
          RepositoryProvider.of<UserRepositoryInterface>(context),
        ),
        child: child,
      ),
    );
  }
}

class BotiApp extends StatefulWidget {
  const BotiApp({Key key}) : super(key: key);

  @override
  _BotiAppState createState() => _BotiAppState();
}

class _BotiAppState extends State<BotiApp> {
  @override
  void initState() {
    context.bloc<AuthBloc>().add(AuthAppInitiated());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
        title: 'Boti Blog',
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _buildHome(),
        routes: AppRoutes.routes);
    return _providers(
      child: materialApp,
    );
  }

  Widget _buildHome() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state is AuthInitial) {
          return SplashScreen();
        } else if (state is AuthUnauthenticated) {
          return SignInScreen(
            savedUser: state.email,
          );
        } else if (state is AuthAuthenticated) {
          return HomeScreen();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  MultiRepositoryProvider _providers({Widget child}) {
    final Dio dio = Dio();

    final SignInDataProvider signInDataProvider = SignInDataProvider();
    final SignUpDataProvider signUpDataProvider = SignUpDataProvider();
    final PostDataProvider userNewsDataProvider = PostDataProvider();
    final CurrentDateTimeInterface currentDateTime = CurrentDateTime();
    final BotiNewsDataProvider botiNewsDataProvider = BotiNewsDataProvider(dio);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SignInRepositoryInterface>(
          create: (context) => SignInRepository(signInDataProvider),
        ),
        RepositoryProvider<SignUpRepositoryInterface>(
          create: (context) => SignUpRepository(signUpDataProvider),
        ),
        RepositoryProvider<PostRepositoryInterface>(
          create: (context) => PostRepository(userNewsDataProvider),
        ),
        RepositoryProvider<BotiNewsRepositoryInterface>(
          create: (context) => BotiNewsRepository(botiNewsDataProvider),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignInBloc(
              RepositoryProvider.of<SignInRepositoryInterface>(context),
              BlocProvider.of<AuthBloc>(context),
            ),
          ),
          BlocProvider(
            create: (context) => SignUpBloc(
              RepositoryProvider.of<SignUpRepositoryInterface>(context),
              RepositoryProvider.of<UserRepositoryInterface>(context),
            ),
          ),
          BlocProvider(
            create: (context) => PostBloc(
              RepositoryProvider.of<PostRepositoryInterface>(context),
              RepositoryProvider.of<UserRepositoryInterface>(context),
              currentDateTime,
            ),
          ),
          BlocProvider(
            create: (context) => UserNewsBloc(
              BlocProvider.of<PostBloc>(context),
              RepositoryProvider.of<PostRepositoryInterface>(context),
              RepositoryProvider.of<UserRepositoryInterface>(context),
              currentDateTime,
            ),
          ),
          BlocProvider(
            create: (context) => BotiNewsBloc(
              RepositoryProvider.of<BotiNewsRepositoryInterface>(context),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
