abstract class SignInEvent {
  const SignInEvent();
}

class SignInRequested extends SignInEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}
