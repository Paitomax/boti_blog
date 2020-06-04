import 'package:botiblog/src/app/app_routes.dart';
import 'package:botiblog/src/shared/user/user_repository.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';
import 'package:botiblog/src/sign_in/sign_in_bloc.dart';
import 'package:botiblog/src/sign_in/sign_in_data_provider.dart';
import 'package:botiblog/src/sign_in/sign_in_repository.dart';
import 'package:botiblog/src/sign_in/sign_in_repository_interface.dart';
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
          primarySwatch: Colors.deepOrange,
        ),
        initialRoute: SplashScreen.routeName,
        routes: AppRoutes.routes);
    return _providers(
      child: materialApp,
    );
  }

  MultiRepositoryProvider _providers({Widget child}) {
    final SignInDataProvider signInDataProvider = SignInDataProvider();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SignInRepositoryInterface>(
          create: (context) => SignInRepository(signInDataProvider),
        ),
        RepositoryProvider<UserRepositoryInterface>(
          create: (context) => UserRepository(),
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
        ],
        child: child,
      ),
    );
  }
}
