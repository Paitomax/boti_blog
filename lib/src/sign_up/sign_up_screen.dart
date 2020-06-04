import 'package:botiblog/src/shared/validators/email_validator.dart';
import 'package:botiblog/src/shared/validators/text_validator.dart';
import 'package:botiblog/src/shared/widgets/boti_raised_button.dart';
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
                _buildText(),
                SizedBox(height: 16),
                _buildForm(),
                SizedBox(height: 24),
                _buildButton(),
              ],
            ),
          ),
        ));
  }

  Widget _buildText() {
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
          _buildPasswordInput(_passController, _passwordFocusNode,
              SignUpScreenTexts.passwordHint, passwordValidator),
          SizedBox(height: 16),
          _buildPasswordInput(
              _passConfirmationController,
              _passwordConfirmationFocusNode,
              SignUpScreenTexts.passwordConfirmationHint,
              passwordConfirmationValidator,
              textInputAction: TextInputAction.done),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return TextFormField(
      autofocus: true,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onFieldSubmitted: (text) {
        _emailFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      decoration: const InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(fontSize: 18),
      ),
      validator: (text) {
        if (text.isEmpty)
          return SignUpScreenTexts.emailErrorMessageEnterYourEmail;

        final validEmail = EmailValidator.isValid(text);

        if (!validEmail) return SignUpScreenTexts.emailErrorMessageInvalid;
        return null;
      },
    );
  }

  Widget _buildNameInput() {
    return TextFormField(
      autofocus: true,
      controller: _nameController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (text) {
        _nameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },
      focusNode: _nameFocusNode,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
      decoration: const InputDecoration(
        hintText: 'Nome',
        hintStyle: TextStyle(fontSize: 18),
      ),
      validator: (text) {
        if (text.length < 3)
          return SignUpScreenTexts.nameErrorMessageEnterYourName;
        if (TextValidator.hasNumber(text))
          return SignUpScreenTexts.nameErrorMessageNumberDenied;

        return null;
      },
    );
  }

  Widget _buildPasswordInput(TextEditingController controller,
      FocusNode focusNode, String hintText, Function(String) passwordValidator,
      {TextInputAction textInputAction = TextInputAction.next}) {
    return TextFormField(
      textInputAction: textInputAction,
      controller: controller,
      keyboardType: TextInputType.text,
      focusNode: focusNode,
      maxLines: 1,
      onFieldSubmitted: (text) {
        if (textInputAction == TextInputAction.done) {
          _passwordConfirmationFocusNode.unfocus();
          _onButtonPressed();
        } else {
          _passwordFocusNode.unfocus();
          FocusScope.of(context).requestFocus(_passwordConfirmationFocusNode);
        }
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(24),
      ],
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 18),
      ),
      obscureText: true,
      validator: passwordValidator,
    );
  }

  String passwordValidator(String text) {
    if (text.length < 6)
      return SignUpScreenTexts.passwordErrorMessageAtLeastSixCharacters;
    return null;
  }

  String passwordConfirmationValidator(String text) {
    if (_passConfirmationController.text != _passController.text)
      return 'As senhas não batem';
    return null;
  }

  Widget _buildButton() {
    BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoadSuccess) {
          _showDialog(
              SignUpScreenTexts.successDialogTitle,
              SignUpScreenTexts.successDialogMessage,
              SignUpScreenTexts.successDialogButtonText, () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
          });
        } else if (state is SignUpLoadFailure) {
          _showDialog(SignUpScreenTexts.failureDialogTitle,
              SignUpScreenTexts.failureDialogMessage, SignUpScreenTexts.ok, () {
            Navigator.of(context).pop();
          });
        } else if (state is SignUpLoadFailureEmailAlreadyRegistered) {
          _showDialog(
              SignUpScreenTexts.failureDialogTitle,
              SignUpScreenTexts.failureDialogMessageEmailAlreadyInUse,
              SignUpScreenTexts.ok, () {
            Navigator.of(context).pop();
//            _emailController.text = '';
            FocusScope.of(context).requestFocus(_emailFocusNode);
          });
        }
      },
      builder: (context, state) {
        if (state is SignUpLoadInProgress) {
          return CircularProgressIndicator();
        } else {
          return BotiRaisedButton(
            text: SignUpScreenTexts.mainButtonText,
            onPressed: _onButtonPressed,
          );
        }
      },
    );
  }

  void _onButtonPressed() {
    if (_formKey.currentState.validate()) {}
  }

  void _showDialog(String title, String message, String buttonText,
      Function onButtonPressed) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(buttonText),
              onPressed: onButtonPressed,
            ),
          ],
        );
      },
    );
  }
}