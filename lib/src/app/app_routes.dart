import 'package:botiblog/src/home/home_screen.dart';
import 'package:botiblog/src/sign_in/sign_in_screen.dart';
import 'package:botiblog/src/sign_up/sign_up_screen.dart';
import 'package:botiblog/src/splash/splash_screen.dart';

class AppRoutes {
  static final routes = {
    SplashScreen.routeName: (context) => SplashScreen(),
    SignInScreen.routeName: (context) => SignInScreen(),
    SignUpScreen.routeName: (context) => SignUpScreen(),
    HomeScreen.routeName: (context) => HomeScreen(),
  };
}
