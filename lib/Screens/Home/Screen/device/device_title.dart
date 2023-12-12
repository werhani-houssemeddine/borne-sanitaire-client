import 'package:borne_sanitaire_client/widget/customInput.dart';
import 'package:flutter/material.dart';

class SetDeviceTitle extends StatefulWidget {
  const SetDeviceTitle({Key? key}) : super(key: key);

  @override
  _SetMaxVisitorsState createState() => _SetMaxVisitorsState();
}

class _SetMaxVisitorsState extends State<SetDeviceTitle> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  REQUEST_STATE? _requestStatus;

  String? validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a number';
    }

    return null;
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      String title = controller.text;
      print(title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      controller: controller,
      formKey: _formKey,
      onSubmit: onSubmit,
      validator: validator,
      requestStatus: _requestStatus,
      hintText: "Enter your device title",
      buttonTitle: "Change device title",
    );
  }
}
