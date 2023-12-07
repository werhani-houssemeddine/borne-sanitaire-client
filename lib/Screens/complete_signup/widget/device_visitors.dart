import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

class DeviceMaxVisitorsWidget extends StatelessWidget {
  const DeviceMaxVisitorsWidget({
    super.key,
    required this.setDeviceMaxVisitors,
  });

  final void Function(bool p1, String? p2) setDeviceMaxVisitors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: TextFormField(
        // controller: phoneNumberController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) => {
          value == ""
              ? setDeviceMaxVisitors(false, null)
              : setDeviceMaxVisitors(true, value),
        },
        decoration: InputDecoration(
          labelText: 'Enter the maximum visitors number',
          focusColor: AppColors.primary,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: TextInputType.phone,

        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a valid number';
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
