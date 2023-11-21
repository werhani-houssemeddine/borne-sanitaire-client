// ignore_for_file: non_constant_identifier_names

import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/widget/Login/interfaces.dart';
import 'package:borne_sanitaire_client/widget/Login/login_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class _FormInput {
  static bool _passwordError = false;
  static bool _emailError = false;
  static TextEditingController emailController =
      TextEditingController(text: '');
  static TextEditingController passwordController =
      TextEditingController(text: '');

  static void resetPasswordError() => _passwordError = false;
  static void setPasswordError() => _passwordError = true;
  static bool getPasswordError() => _passwordError;

  static void resetEmailError() => _emailError = false;
  static void setEmailError() => _emailError = true;
  static bool getEmailError() => _emailError;
}

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // _FormInput.emailController.dispose();
    // _FormInput.passwordController.dispose();
    super.dispose();
  }

  resetPassword(value) {
    setState(() {
      _FormInput.resetPasswordError();
    });
  }

  resetEmail(value) {
    setState(() {
      _FormInput.resetEmailError();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _InputContainer(
            _makeInput(
              _FormInput.emailController,
              _InputValidators.emailValidator,
              resetEmail,
              _InputDecoration.emailDecoration(
                _FormInput.getEmailError(),
              ),
              autofocus: true,
            ),
          ),
          _InputContainer(
            _makeInput(
              _FormInput.passwordController,
              _InputValidators.passwordValidator,
              resetPassword,
              _InputDecoration.passwordDecoration(
                _FormInput.getPasswordError(),
              ),
              obscureText: true,
            ),
          ),
          _SubmitLoginButton(
            formKey: _formKey,
            emailController: _FormInput.emailController,
            passwordController: _FormInput.passwordController,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                text: "Forgot Password ?",
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print("Hi forgot password clicked !");
                  },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (emailRegex.hasMatch(value) == false) {
      return "Invalid Email";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 10) {
      return "Too Short Password";
    }

    return null;
  }
}

class _SubmitLoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController emailController;

  const _SubmitLoginButton(
      {required this.formKey,
      required this.emailController,
      required this.passwordController});

  void _handleSubmitLogin(
      String email, String password, BuildContext context) async {
    LOGIN_RESPONSE response =
        await submitLoginForm(email: email, password: password);

    if (response == LOGIN_RESPONSE.SUCCESS) {
      if (context.mounted) {
        AutoRouter.of(context).push(const HomeRoute()).then((value) => null);
      }
    } else if (response == LOGIN_RESPONSE.SERVER_ERROR) {
      if (context.mounted) {
        AutoRouter.of(context).push(const WelcomeRoute()).then((value) => null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      height: 50,
      child: ElevatedButton(
        child: const Text("Login"),
        onPressed: () => {
          if (formKey.currentState!.validate())
            {
              _handleSubmitLogin(
                emailController.value.text,
                passwordController.value.text,
                context,
              )
            }
        },
      ),
    );
  }
}

class _InputDecoration {
  static InputDecoration makeInputDecoration(
      {Icon? inputIcon, String hint = "Enter data", bool error = false}) {
    Widget? checkIcon() {
      if (inputIcon != null) {
        return Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: inputIcon,
        );
      } else {
        return null;
      }
    }

    return InputDecoration(
      hintText: hint,
      prefixIcon: checkIcon(),
      prefixIconColor: error ? Colors.red : Colors.green,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green, width: 1.0),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.0),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.green, width: 1.0),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }

  static InputDecoration emailDecoration(bool emailError) {
    return makeInputDecoration(
      hint: "Enter Your Email",
      inputIcon: const Icon(Icons.person_2_rounded),
      error: _FormInput.getEmailError(),
    );
  }

  static InputDecoration passwordDecoration(bool passwordError) {
    return makeInputDecoration(
      hint: "Enter Your Password",
      inputIcon: const Icon(Icons.password),
      error: _FormInput.getPasswordError(),
    );
  }
}

class _CustomInputContainer extends StatelessWidget {
  final Widget input;
  const _CustomInputContainer({required this.input});

  @override
  Widget build(BuildContext context) {
    if (input is TextFormField || input is ElevatedButton) {
      return Container(
        margin: const EdgeInsets.all(10.0),
        child: input,
      );
    } else {
      return Container();
    }
  }
}

Widget _InputContainer(Widget input) {
  if (input is TextFormField || input is ElevatedButton) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: input,
    );
  }

  throw Error();
}

TextFormField _makeInput(
    TextEditingController controller, validator, onChanged, decoration,
    {bool autofocus = false, bool obscureText = false}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    autofocus: autofocus,
    obscureText: obscureText,
    decoration: decoration,
    onChanged: onChanged,
  );
}
