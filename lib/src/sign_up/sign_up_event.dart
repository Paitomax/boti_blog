import 'package:botiblog/src/sign_up/model/user_account_model.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpRequested extends SignUpEvent {
  final UserAccountModel account;

  SignUpRequested(this.account);

  @override
  List<Object> get props => [account];

  @override
  String toString() {
    return 'SignUpRequested{account: $account}';
  }
}
