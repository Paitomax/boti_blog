import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:botiblog/src/shared/validators/email_validator.dart';
import 'package:botiblog/src/shared/widgets/boti_flat_button.dart';
import 'package:botiblog/src/shared/widgets/boti_raised_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignInScreen extends StatefulWidget {
  static final routeName = '/sign_in';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

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
      decoration: const InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(fontSize: 18),
      ),
      validator: (text) {
        if (text.isEmpty) return 'Informe seu email';

        final validEmail = EmailValidator.isValid(text);

        if (!validEmail) return 'Email Invalido';
        return null;
      },
    );
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Senha',
        hintStyle: TextStyle(fontSize: 18),
      ),
      obscureText: true,
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        _buildEnterButton(),
        _buildSignUpButton(),
      ],
    );
  }

  Widget _buildEnterButton() {
    return BotiRaisedButton(
      text: 'Entrar',
      onPressed: () {
        if (_formKey.currentState.validate()) {}
      },
    );
  }

  Widget _buildSignUpButton() {
    return BotiFlatButton(
      text: 'Cadastre-se',
      onPressed: () {},
    );
  }
}
