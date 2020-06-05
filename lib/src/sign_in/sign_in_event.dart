abstract class SignInEvent {
  const SignInEvent();
}

class SignInRequested extends SignInEvent {
  final String email;
  final String password;
  final bool remember;

  SignInRequested(this.email, this.password, {this.remember = false});

  @override
  String toString() {
    return 'SignInRequested{email: $email, password: $password, remember: $remember}';
  }
}
