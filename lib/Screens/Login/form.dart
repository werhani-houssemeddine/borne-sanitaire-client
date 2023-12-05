import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/Screens/Login/interfaces.dart';
import 'package:borne_sanitaire_client/Screens/Login/login_service.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

class LoginFormInputValidators {
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

class LoginFormInputDecoration {
  static InputDecoration makeInputDecoration({
    Icon? inputIcon,
    String hint = "Enter data",
    bool error = false,
  }) {
    Widget? checkIcon() {
      if (inputIcon == null) return null;
      return Align(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: inputIcon,
      );
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

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();

  bool error = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void submitForm({
      required String email,
      required String password,
      required BuildContext context,
    }) async {
      LOGIN_RESPONSE response =
          await submitLoginForm(email: email, password: password);

      if (response == LOGIN_RESPONSE.SUCCESS) {
        if (context.mounted) {
          AutoRouter.of(context).push(const HomeRoute()).then((value) => null);
        }
      } else if (response == LOGIN_RESPONSE.SERVER_ERROR) {
        if (context.mounted) {
          AutoRouter.of(context)
              .push(const WelcomeRoute())
              .then((value) => null);
        }
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: TextFormField(
              autofocus: true,
              controller: _emailController,
              validator: LoginFormInputValidators.emailValidator,
              decoration: LoginFormInputDecoration.emailDecoration(error),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              validator: LoginFormInputValidators.passwordValidator,
              decoration: LoginFormInputDecoration.passwordDecoration(error),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: MakeGestureDetector(
                  onPressed: () {},
                  child: Text(
                    "forgot password",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
          MakeGestureDetector(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                submitForm(
                  email: _emailController.value.text,
                  password: _passwordController.value.text,
                  context: context,
                );
              } else {
                setState(() {
                  error = true;
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary,
              ),
              child: const Center(
                child: Text(
                  "SIGN IN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
