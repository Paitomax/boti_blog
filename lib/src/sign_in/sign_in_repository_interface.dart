abstract class SignInRepositoryInterface {
  Future<bool> requestLogin(String user, String password);
}
