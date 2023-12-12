import 'package:borne_sanitaire_client/widget/customInput.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:borne_sanitaire_client/widget/switch.dart';
import 'package:flutter/material.dart';

class SuspendAccount extends StatefulWidget {
  const SuspendAccount({Key? key}) : super(key: key);

  @override
  State<SuspendAccount> createState() => _SuspendAccountState();
}

class _SuspendAccountState extends State<SuspendAccount> {
  bool showPasswordWidget = false;

  setToggleSwitch() {
    setState(() => showPasswordWidget = !showPasswordWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 5,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Suspend Your Account",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Suspend Your Account functionality, you are deactivating your "
              "account temporarily putting a pause on any activities "
              "associated with it, Just logged in for reactivate your account",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [CustomSwitch(setActionState: setToggleSwitch)],
            ),
            if (showPasswordWidget) const EnableOTPAuthInput(),
          ],
        ),
      ),
    );
  }
}

class EnableOTPAuthInput extends StatefulWidget {
  const EnableOTPAuthInput({Key? key}) : super(key: key);

  @override
  _SetMaxVisitorsState createState() => _SetMaxVisitorsState();
}

class _SetMaxVisitorsState extends State<EnableOTPAuthInput> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  REQUEST_STATE? _requestStatus;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length <= 8) {
      return 'Wrong password';
    }

    return null;
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      String passwordValue = controller.text;
      print(passwordValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: CustomInputField(
        controller: controller,
        formKey: _formKey,
        onSubmit: onSubmit,
        validator: validator,
        requestStatus: _requestStatus,
        hintText: "Enter your password",
        buttonTitle: "Suspend your account",
        password: true,
      ),
    );
  }
}
