import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/widget/arrow_back.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';
import 'signup_service.dart' show makeSignUpRequest;
import 'response_service.dart' show SIGN_UP_RESULT;

@RoutePage()
class SignUpFormRoute extends StatelessWidget {
  final String deviceId;
  final String email;

  const SignUpFormRoute({
    super.key,
    required this.deviceId,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    Size currentSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: currentSize.height,
        width: currentSize.width,
        color: AppColors.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const ArrowBack(),
            SignUpFormContainer(
              deviceId: deviceId,
              email: email,
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpFormContainer extends StatefulWidget {
  final String deviceId;
  final String email;
  const SignUpFormContainer(
      {super.key, required this.deviceId, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpFormContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  _SignUpFormState();

  @override
  void initState() {
    super.initState();
    UserController.initializeControllers();
  }

  void togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String deviceId = widget.deviceId;
    final String email = widget.email;

    final double currentHeight = MediaQuery.of(context).size.height;
    final double currentWidth = MediaQuery.of(context).size.height;

    return Container(
      height: currentHeight * 0.85,
      width: currentWidth,
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFieldBuilder(
                  controller: UserController.usernameController!,
                  labelText: 'Username',
                  prefixIcon: Icons.person,
                  validator: Validator.validateUsername,
                ).buildWithMargin(),
                TextFormFieldBuilder(
                  controller: UserController.passwordController!,
                  labelText: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: _isObscure,
                  isPassword: true,
                  validator: Validator.validatePassword,
                  suffixIcon:
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                  onSuffixIconPressed: togglePasswordVisibility,
                ).buildWithMargin(),
                SubmitButton(
                  formKey: _formKey,
                  email: email,
                  deviceId: deviceId,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UserController {
  static TextEditingController? emailController;
  static TextEditingController? usernameController;
  static TextEditingController? passwordController;

  static void initializeControllers() {
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }
}

class TextFormFieldBuilder {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;

  TextFormFieldBuilder({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.obscureText = false,
    this.isPassword = false,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.onSuffixIconPressed,
  });

  buildSuffixIcon() {
    if (suffixIcon != null) {
      return IconButton(
        icon: Icon(suffixIcon),
        onPressed: onSuffixIconPressed,
      );
    }
    return null;
  }

  TextFormField build() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: buildSuffixIcon(),
      ),
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Container buildWithMargin() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: build(),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String deviceId;
  final String email;

  const SubmitButton({
    super.key,
    required this.formKey,
    required this.deviceId,
    required this.email,
  });

  _submitForm({
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    SIGN_UP_RESULT singupResult = await makeSignUpRequest(
      email: email,
      username: username,
      password: password,
      deviceId: deviceId,
    );

    if (context.mounted) {
      handleSignUpResult(singupResult, context);
    }
  }

  void updateErrorText(TextEditingController? controller, String errorMessage) {
    controller
      ?..text = ''
      ..value = controller.value.copyWith(text: errorMessage);
  }

  void handleSignUpResult(SIGN_UP_RESULT result, BuildContext context) {
    if (result == SIGN_UP_RESULT.SUCCESS) {
      //! Redirect to home page
      AutoRouter.of(context)
          .push(CompleteUserSignUpRoute(deviceId: deviceId))
          .then((value) => {});
    } else /*(result == SIGN_UP_RESULT.BAD_REQUEST_EMAIL_USED)*/ {
      UserController.emailController!.clear();
      updateErrorText(UserController.emailController, 'Email already in use.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            _submitForm(
              username: UserController.usernameController!.text.trim(),
              password: UserController.passwordController!.text.trim(),
              context: context,
            );
          }
        },
        child: const Text('Submit'),
      ),
    );
  }
}

class Validator {
  static String? validateEmail(String? value) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    // Add more username validation if needed
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length <= 10) {
      return 'Password must be more than 10 characters';
    }
    return null;
  }
}
