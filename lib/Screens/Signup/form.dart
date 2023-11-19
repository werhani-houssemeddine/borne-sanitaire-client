import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Padding(
        padding: EdgeInsets.all(3.0),
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  // ignore: library_private_types_in_public_api
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_Form> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

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
    return Form(
      key: _formKey,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormFieldBuilder(
            controller: UserController.emailController!,
            labelText: 'Email',
            prefixIcon: Icons.email,
            validator: Validator.validateEmail,
          ).buildWithMargin(),
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
            suffixIcon: _isObscure ? Icons.visibility_off : Icons.visibility,
            onSuffixIconPressed: togglePasswordVisibility,
          ).buildWithMargin(),
          SubmitButton(formKey: _formKey),
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

  const SubmitButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            print('Form is valid');
            // Access the data using the controllers
            String email = UserController.emailController!.text.trim();
            String username = UserController.usernameController!.text.trim();
            String password = UserController.passwordController!.text.trim();

            // Use the data as needed
            print('Email: $email');
            print('Username: $username');
            print('Password: $password');
          } else {
            print('Form is not valid');
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