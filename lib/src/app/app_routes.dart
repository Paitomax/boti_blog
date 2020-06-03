import 'package:botiblog/src/sign_in/sign_in_screen.dart';
import 'package:botiblog/src/splash/splash_screen.dart';

class AppRoutes {
  static final routes = {
    SplashScreen.routeName: (context) => SplashScreen(),
    SignInScreen.routeName: (context) => SignInScreen(),
  };
}
