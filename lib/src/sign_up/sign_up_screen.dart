import 'package:botiblog/src/shared/validators/email_validator.dart';
import 'package:botiblog/src/shared/validators/text_validator.dart';
import 'package:botiblog/src/shared/widgets/boti_raised_button.dart';
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
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordConfirmationFocusNode = FocusNode();

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
      'Informe seus dados para você poder utilizar a rede social do grupo Boticario.',
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
          _buildPasswordInput(
              _passController, _passwordFocusNode, 'Senha', passwordValidator),
          SizedBox(height: 16),
          _buildPasswordInput(
              _passConfirmationController,
              _passwordConfirmationFocusNode,
              'Confirme sua Senha',
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
        if (text.length < 3) return 'Informe seu nome';
        if (TextValidator.hasNumber(text))
          return 'Não é permitido informar número';

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
        if (textInputAction == TextInputAction.done){
          _passwordConfirmationFocusNode.unfocus();
          _onButtonPressed();
        }
        else{
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
    if (text.length < 6) return 'Informe uma senha com pelo menos 6 caracteres';
    return null;
  }

  String passwordConfirmationValidator(String text) {
    if (_passConfirmationController.text != _passController.text)
      return 'As senhas não batem';
    return null;
  }

  Widget _buildButton() {
    return BotiRaisedButton(
      text: 'Continuar',
      onPressed: _onButtonPressed,
    );
  }

  void _onButtonPressed() {
    if (_formKey.currentState.validate()) {}
  }
}
