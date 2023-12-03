// ignore_for_file: non_constant_identifier_names

import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/Screens/Login/interfaces.dart';
import 'package:borne_sanitaire_client/Screens/Login/login_service.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
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
    print('reset $value');
    setState(() {
      _FormInput.resetPasswordError();
    });
    print(_FormInput.getPasswordError());
  }

  resetEmail(value) {
    print('reset $value');

    setState(() {
      _FormInput.resetEmailError();
    });
    print(_FormInput.getEmailError());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          LoginFormInput(
            controller: _FormInput.emailController,
            validator: _InputValidators.emailValidator,
            onChanged: resetEmail,
            decoration: _InputDecoration.emailDecoration(
              _FormInput.getEmailError(),
            ),
            autofocus: true,
          ),
          LoginFormInput(
            controller: _FormInput.passwordController,
            validator: _InputValidators.passwordValidator,
            onChanged: resetPassword,
            decoration: _InputDecoration.passwordDecoration(
              _FormInput.getPasswordError(),
            ),
            obscureText: true,
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
      prefixIconColor: error ? Colors.red : AppColors.primary,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2.0),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2.0),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }

  static InputDecoration emailDecoration(bool emailError) {
    return makeInputDecoration(
      hint: "Enter Your Email",
      inputIcon: const Icon(Icons.person_2_rounded),
      error: emailError,
    );
  }

  static InputDecoration passwordDecoration(bool passwordError) {
    return makeInputDecoration(
      hint: "Enter Your Password",
      inputIcon: const Icon(Icons.lock),
      error: passwordError,
    );
  }
}

class _CustomInput extends StatelessWidget {
  final Widget input;
  const _CustomInput({required this.input});

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

class LoginFormInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool autofocus;
  final bool obscureText;
  final InputDecoration? decoration;
  const LoginFormInput({
    Key? key,
    required this.validator,
    required this.onChanged,
    required this.controller,
    required this.decoration,
    this.autofocus = false,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        autofocus: autofocus,
        obscureText: obscureText,
        onChanged: (String? value) {},
        decoration: decoration,
      ),
    );
  }
}
