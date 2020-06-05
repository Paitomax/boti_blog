import 'package:botiblog/src/home/home_screen.dart';
import 'package:botiblog/src/shared/consts/limits.dart';
import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:botiblog/src/shared/validators/email_validator.dart';
import 'package:botiblog/src/shared/widgets/boti_flat_button.dart';
import 'package:botiblog/src/shared/widgets/boti_raised_button.dart';
import 'package:botiblog/src/sign_in/sign_in_event.dart';
import 'package:botiblog/src/sign_in/sign_in_screen_texts.dart';
import 'package:botiblog/src/sign_in/sign_in_state.dart';
import 'package:botiblog/src/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_in_bloc.dart';

class SignInScreen extends StatefulWidget {
  static final String routeName = '/sign_in';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController.text = 'jose@boticario.com.br';
    _passController.text = '123456';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildTitle(),
              SizedBox(height: 32),
              _buildInputs(),
              SizedBox(height: 16),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "Boti Blog",
      style: TextStyle(
          fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.blue),
    );
  }

  Widget _buildInputs() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildEmailInput(),
          SizedBox(height: 8),
          _buildPasswordInput(),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: SignInScreenTexts.emailHint,
        hintStyle: TextStyle(fontSize: 18),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(Limits.emailLimits),
      ],
      onFieldSubmitted: (text) {
        _emailFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_passFocusNode);
      },
      validator: (text) {
        if (text.isEmpty)
          return SignInScreenTexts.emailErrorMessageEnterYourEmail;

        final validEmail = EmailValidator.isValid(text);

        if (!validEmail) return SignInScreenTexts.emailErrorMessageInvalid;
        return null;
      },
    );
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      controller: _passController,
      focusNode: _passFocusNode,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (text) {
        _passFocusNode.unfocus();
        _onEnterButtonPressed();
      },
      maxLines: 1,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Limits.passwordLimits),
      ],
      decoration: InputDecoration(
        hintText: SignInScreenTexts.passwordHint,
        hintStyle: TextStyle(fontSize: 18),
      ),
      obscureText: true,
    );
  }

  Widget _buildButtons() {
    return BlocConsumer<SignInBloc, SignInState>(listener: (context, state) {
      if (state is SignInLoadSuccess) {
        _navigateToHome();
      } else if (state is SignInLoadFailure) {
        _showErrorDialog(SignInScreenTexts.failureDialogTitle,
            SignInScreenTexts.failureDialogMessage);
      } else if (state is SignInLoadFailureWrongUserOrPass) {
        _showErrorDialog(
            SignInScreenTexts.attention, SignInScreenTexts.wrongUserOrPass);
      }
    }, builder: (BuildContext context, state) {
      if (state is SignInLoadInProgress) {
        return CircularProgressIndicator();
      }
      return Column(
        children: <Widget>[
          _buildEnterButton(),
          _buildSignUpButton(),
        ],
      );
    });
  }

  Widget _buildEnterButton() {
    return BotiRaisedButton(
      text: SignInScreenTexts.loginButtonText,
      onPressed: _onEnterButtonPressed,
    );
  }

  void _onEnterButtonPressed() {
    _emailFocusNode.unfocus();
    _passFocusNode.unfocus();
    if (_formKey.currentState.validate()) {
      final email = _emailController.text;
      final pass = _passController.text;
      context.bloc<SignInBloc>().add(SignInRequested(email, pass));
    }
  }

  Widget _buildSignUpButton() {
    return BotiFlatButton(
      text: SignInScreenTexts.signUp,
      onPressed: () {
        Navigator.pushNamed(context, SignUpScreen.routeName);
      },
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(SignInScreenTexts.ok),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
