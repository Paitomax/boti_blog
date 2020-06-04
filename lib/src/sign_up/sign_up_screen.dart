import 'package:botiblog/src/shared/validators/email_validator.dart';
import 'package:botiblog/src/shared/validators/text_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de usuário'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                _buildForm(),
              ],
            ),
          ),
        ));
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
          _buildPasswordInput(_passController, 'Senha', passwordValidator),
          SizedBox(height: 16),
          _buildPasswordInput(_passConfirmationController, 'Confirme sua Senha',
              passwordConfirmationValidator),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return TextFormField(
      autofocus: true,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
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

  Widget _buildNameInput() {
    return TextFormField(
      autofocus: true,
      controller: _nameController,
      keyboardType: TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
      decoration: const InputDecoration(
        hintText: 'Nome',
        hintStyle: TextStyle(fontSize: 18),
      ),
      validator: (text) {
        if (text.length < 3) return 'Informe seu nome';
        if (TextValidator.hasNumber(text))
          return 'Não é permitido informar número';

        return null;
      },
    );
  }

  Widget _buildPasswordInput(TextEditingController controller, String hintText,
      Function(String) passwordValidator) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: 1,
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
      return 'Informe uma senha de pelo menos 6 caracteres e no maximo 24';
    return null;
  }

  String passwordConfirmationValidator(String text) {
    if (_passConfirmationController.text != _passController.text)
      return 'As senhas não batem';
    return null;
  }
}
