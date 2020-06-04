import 'package:botiblog/src/app/app_routes.dart';
import 'package:botiblog/src/home/user_news/user_news_bloc.dart';
import 'package:botiblog/src/home/user_news/user_news_data_provider.dart';
import 'package:botiblog/src/home/user_news/user_news_repository.dart';
import 'package:botiblog/src/home/user_news/user_news_repository_interface.dart';
import 'package:botiblog/src/shared/user/user_repository.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';
import 'package:botiblog/src/sign_in/sign_in_bloc.dart';
import 'package:botiblog/src/sign_in/sign_in_data_provider.dart';
import 'package:botiblog/src/sign_in/sign_in_repository.dart';
import 'package:botiblog/src/sign_in/sign_in_repository_interface.dart';
import 'package:botiblog/src/sign_up/sign_up_bloc.dart';
import 'package:botiblog/src/sign_up/sign_up_data_provider.dart';
import 'package:botiblog/src/sign_up/sign_up_repository.dart';
import 'package:botiblog/src/sign_up/sign_up_repository_interface.dart';
import 'package:botiblog/src/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BotiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
        title: 'Boti Blog',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreen.routeName,
        routes: AppRoutes.routes);
    return _providers(
      child: materialApp,
    );
  }

  MultiRepositoryProvider _providers({Widget child}) {
    final SignInDataProvider signInDataProvider = SignInDataProvider();
    final SignUpDataProvider signUpDataProvider = SignUpDataProvider();
    final UserNewsDataProvider userNewsDataProvider = UserNewsDataProvider();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SignInRepositoryInterface>(
          create: (context) => SignInRepository(signInDataProvider),
        ),
        RepositoryProvider<UserRepositoryInterface>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<SignUpRepositoryInterface>(
          create: (context) => SignUpRepository(signUpDataProvider),
        ),
        RepositoryProvider<UserNewsRepositoryInterface>(
          create: (context) => UserNewsRepository(userNewsDataProvider),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignInBloc(
              RepositoryProvider.of<SignInRepositoryInterface>(context),
              RepositoryProvider.of<UserRepositoryInterface>(context),
            ),
          ),
          BlocProvider(
            create: (context) => SignUpBloc(
              RepositoryProvider.of<SignUpRepositoryInterface>(context),
              RepositoryProvider.of<UserRepositoryInterface>(context),
            ),
          ),
          BlocProvider(
            create: (context) => UserNewsBloc(
              RepositoryProvider.of<UserNewsRepositoryInterface>(context),
              RepositoryProvider.of<UserRepositoryInterface>(context),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
