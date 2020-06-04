import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:botiblog/src/shared/validators/email_validator.dart';
import 'package:botiblog/src/shared/widgets/boti_flat_button.dart';
import 'package:botiblog/src/shared/widgets/boti_raised_button.dart';
import 'package:botiblog/src/sign_in/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_in_bloc.dart';

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
    return BlocConsumer<SignInBloc, SignInState>(
        listener: (BuildContext context, SignInState state) {
      if (state is SignInLoadFailure) {
        _showErrorDialog();
      } else if (state is SignInLoadSuccess) {
        _navigateToHome();
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

  void _showErrorDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Atenção'),
          content: Text('Usuário ou senha incorreto.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToHome(){

  }
}
