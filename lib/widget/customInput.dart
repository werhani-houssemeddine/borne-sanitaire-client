// ignore_for_file: camel_case_types

import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

enum REQUEST_STATE {
  PENDING,
  SUCCESS,
  FAILLURE,
}

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final REQUEST_STATE? requestStatus;
  final VoidCallback onSubmit;
  final String hintText;
  final String? Function(String?)? validator;
  final String buttonTitle;
  final bool password;
  final TextInputType? keyboardType;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.formKey,
    required this.requestStatus,
    required this.onSubmit,
    required this.hintText,
    required this.buttonTitle,
    required this.validator,
    this.password = false,
    this.keyboardType,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _isObscure = false;
  void togglePasswordVisibility() {
    setState(() => _isObscure = !_isObscure);
  }

  Widget makeIcon(IconData icon) {
    return Align(
      widthFactor: 1.0,
      heightFactor: 1.0,
      child: Icon(
        icon,
        color: AppColors.primary,
      ),
    );
  }

  Widget? togglePassword() {
    if (widget.password) {
      return MakeGestureDetector(
        onPressed: togglePasswordVisibility,
        child: _isObscure
            ? makeIcon(Icons.visibility_off)
            : makeIcon(Icons.visibility),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, top: 16, left: 5, right: 5),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  // width: MediaQuery.o,
                  child: TextFormField(
                    controller: widget.controller,
                    keyboardType: widget.keyboardType,
                    obscureText: widget.password && !_isObscure,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      prefixIcon: widget.password ? makeIcon(Icons.lock) : null,
                      suffixIcon: togglePassword(),
                      focusColor: AppColors.primary,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: widget.validator,
                  ),
                ),
                if (widget.requestStatus != null)
                  Container(
                    width: 30,
                    height: 30,
                    padding: const EdgeInsets.all(8.0),
                    child: _buildStatusIcon(),
                  )
              ],
            ),
            const SizedBox(height: 16.0),
            MakeGestureDetector(
              onPressed: widget.onSubmit,
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    widget.buttonTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    if (widget.requestStatus == REQUEST_STATE.PENDING) {
      return CircularProgressIndicator(color: Colors.greenAccent.shade400);
    } else if (widget.requestStatus == REQUEST_STATE.FAILLURE) {
      return const Icon(Icons.clear, color: Colors.red);
    } else if (widget.requestStatus == REQUEST_STATE.FAILLURE) {
      return const Icon(Icons.check, color: Colors.green);
    } else {
      return const SizedBox.shrink();
    }
  }
}
