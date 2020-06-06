import 'package:botiblog/src/shared/auth/auth_bloc.dart';
import 'package:botiblog/src/shared/auth/auth_event.dart';
import 'package:botiblog/src/shared/widgets/boti_email_input.dart';
import 'package:botiblog/src/shared/widgets/boti_name_input.dart';
import 'package:botiblog/src/shared/widgets/boti_password_input.dart';
import 'package:botiblog/src/shared/widgets/boti_raised_button.dart';
import 'package:botiblog/src/shared/widgets/dialog/boti_alert_dialog.dart';
import 'package:botiblog/src/sign_up/model/user_account_model.dart';
import 'package:botiblog/src/sign_up/sign_up_event.dart';
import 'package:botiblog/src/sign_up/sign_up_screen_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_bloc.dart';
import 'sign_up_state.dart';

class SignUpScreen extends StatefulWidget {
  static final String routeName = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _passConfirmationController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordConfirmationFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(SignUpScreenTexts.appBarTitle),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 16),
                _buildFormMessage(),
                SizedBox(height: 16),
                _buildForm(),
                SizedBox(height: 24),
                _buildButton(),
              ],
            ),
          ),
        ));
  }

  Widget _buildFormMessage() {
    return Text(
      SignUpScreenTexts.formMessage,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildNameInput(),
          SizedBox(height: 16),
          _buildEmailInput(),
          SizedBox(height: 16),
          BotiPasswordInput(
            key: Key(SignUpScreenTexts.passwordTextFormFieldKey),
            controller: _passController,
            focusNode: _passwordFocusNode,
            onFieldSubmitted: (text) {
              _passwordFocusNode.unfocus();
              FocusScope.of(context)
                  .requestFocus(_passwordConfirmationFocusNode);
            },
          ),
          SizedBox(height: 16),
          BotiPasswordInput(
            key: Key(SignUpScreenTexts.passwordConfirmationTextFormFieldKey),
            controller: _passConfirmationController,
            controllerCompare: _passController,
            focusNode: _passwordConfirmationFocusNode,
            onFieldSubmitted: (text) {
              _passwordConfirmationFocusNode.unfocus();
              _onButtonPressed();
            },
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return BotiEmailInput(
      key: Key(SignUpScreenTexts.emailTextFormFieldKey),
      autofocus: true,
      controller: _emailController,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onFieldSubmitted: (text) {
        _emailFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  Widget _buildNameInput() {
    return BotiNameInput(
      key: Key(SignUpScreenTexts.nameTextFormFieldKey),
      autofocus: true,
      focusNode: _nameFocusNode,
      controller: _nameController,
      textInputAction: TextInputAction.next,
      hintText: SignUpScreenTexts.nameHint,
      onFieldSubmitted: (text) {
        _nameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },
    );
  }

  Widget _buildButton() {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoadSuccess) {
          _showAlertDialog(
              SignUpScreenTexts.successDialogTitle,
              SignUpScreenTexts.successDialogMessage,
              SignUpScreenTexts.successDialogButtonText, () {
            context.bloc<AuthBloc>().add(AuthLoggedIn(state.user, true));
            Navigator.of(context).popUntil((route) => route.isFirst);
          });
        } else if (state is SignUpLoadFailure) {
          _showAlertDialog(SignUpScreenTexts.failureDialogTitle,
              SignUpScreenTexts.failureDialogMessage, SignUpScreenTexts.ok, () {
            Navigator.of(context).pop();
          });
        } else if (state is SignUpLoadFailureEmailAlreadyRegistered) {
          _showAlertDialog(
              SignUpScreenTexts.failureDialogTitle,
              SignUpScreenTexts.failureDialogMessageEmailAlreadyInUse,
              SignUpScreenTexts.ok, () {
            _emailController.text = '';
            Navigator.of(context).pop();
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_emailFocusNode);
          });
        }
      },
      builder: (context, state) {
        if (state is SignUpLoadInProgress) {
          return CircularProgressIndicator();
        } else {
          return BotiRaisedButton(
            key: Key(SignUpScreenTexts.signUpButtonKey),
            text: SignUpScreenTexts.mainButtonText,
            onPressed: _onButtonPressed,
          );
        }
      },
    );
  }

  void _onButtonPressed() {
    if (_formKey.currentState.validate()) {
      final userAccount = UserAccountModel(_nameController.text.trim(),
          _emailController.text.trim(), _passController.text);

      context.bloc<SignUpBloc>().add(SignUpRequested(userAccount));
    }
  }

  void _showAlertDialog(String title, String message, String buttonText,
      Function onButtonPressed) {
    BotiAlertDialog(
      key: Key(SignUpScreenTexts.alertDialogKey),
      parentContext: context,
      title: title,
      message: message,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    ).show(dismissible: false);
  }
}
