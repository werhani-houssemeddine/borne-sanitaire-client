import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

class UpdatePhoneNumber extends StatelessWidget {
  final void Function(bool, String?) setPhoneNumber;
  final String? errorText;

  const UpdatePhoneNumber({
    Key? key,
    required this.setPhoneNumber,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Enter Your Phone Number',
          hintText: 'Phone Number',
          focusColor: AppColors.primary,
          errorText: errorText,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: TextInputType.phone,
        maxLength: 8,
        onChanged: (String? value) => {
          value?.length != 8
              ? setPhoneNumber(false, null)
              : setPhoneNumber(true, value),
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a valid phone number';
          }

          if (double.tryParse(value) == null) {
            return 'Invalid format, numbers only';
          }

          return null;
        },
      ),
    );
  }
}
