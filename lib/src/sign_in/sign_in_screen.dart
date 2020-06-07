import 'package:botiblog/src/shared/boti_assets.dart';
import 'package:botiblog/src/shared/consts/app_keys.dart';
import 'package:botiblog/src/shared/widgets/buttons/boti_flat_button.dart';
import 'package:botiblog/src/shared/widgets/buttons/boti_raised_button.dart';
import 'package:botiblog/src/shared/widgets/inputs/boti_email_input.dart';
import 'package:botiblog/src/shared/widgets/inputs/boti_password_input.dart';
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
  final String savedUser;

  static final String routeName = '/sign_in';

  const SignInScreen({Key key, this.savedUser}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  bool _saveUser = false;

  @override
  void initState() {
    if (widget.savedUser != null) {
      _saveUser = true;
      _emailController.text = widget.savedUser;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 16),
                  _buildTitle(),
                  SizedBox(height: 24),
                  _buildInputs(),
                  SizedBox(height: 24),
                  _buildButtons(),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: <Widget>[
        ClipOval(
          child: Image(
            image: BotiAssets.logo(),
            semanticLabel: 'logo',
            filterQuality: FilterQuality.high,
            width: 100,
            height: 100,
          ),
        ),
        SizedBox(height: 8),
        Text(
          AppKeys.appName,
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
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
          SizedBox(height: 8),
          _buildCheckbox(),
        ],
      ),
    );
  }

  Widget _buildCheckbox() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        children: <Widget>[
          Switch(
            key: Key(SignInScreenTexts.saveUserSwitchKey),
            value: _saveUser,
            onChanged: (bool value) {
              setState(() {
                _saveUser = value;
              });
            },
          ),
          Text(SignInScreenTexts.rememberUser),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return BotiEmailInput(
      key: Key(SignInScreenTexts.emailTextFormFieldKey),
      controller: _emailController,
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (text) {
        _emailFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_passFocusNode);
      },
    );
  }

  Widget _buildPasswordInput() {
    return BotiPasswordInput(
      key: Key(SignInScreenTexts.passwordTextFormFieldKey),
      controller: _passController,
      focusNode: _passFocusNode,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (text) {
        _passFocusNode.unfocus();
        _onEnterButtonPressed();
      },
    );
  }

  Widget _buildButtons() {
    return BlocConsumer<SignInBloc, SignInState>(listener: (context, state) {
      if (state is SignInLoadFailure) {
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
      key: Key(SignInScreenTexts.loginButtonKey),
      text: SignInScreenTexts.loginButtonText,
      onPressed: _onEnterButtonPressed,
    );
  }

  void _onEnterButtonPressed() {
    _emailFocusNode.unfocus();
    _passFocusNode.unfocus();
    if (_formKey.currentState.validate()) {
      final email = _emailController.text.trim();
      final pass = _passController.text;
      context
          .bloc<SignInBloc>()
          .add(SignInRequested(email, pass, remember: _saveUser));
    }
  }

  Widget _buildSignUpButton() {
    return BotiFlatButton(
      key: Key(SignInScreenTexts.signUpButtonKey),
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
          key: Key(SignInScreenTexts.errorAlertDialog),
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
}
