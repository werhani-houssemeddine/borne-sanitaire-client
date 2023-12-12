import 'package:borne_sanitaire_client/widget/customInput.dart';
import 'package:flutter/material.dart';

class SetMaxVisitors extends StatefulWidget {
  const SetMaxVisitors({Key? key}) : super(key: key);

  @override
  _SetMaxVisitorsState createState() => _SetMaxVisitorsState();
}

class _SetMaxVisitorsState extends State<SetMaxVisitors> {
  final TextEditingController _numberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  REQUEST_STATE? _requestStatus;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }
    if (int.tryParse(value) == null || int.parse(value) <= 0) {
      return 'Please enter a valid positive integer';
    }
    return null;
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      int number = int.parse(_numberController.text);
      print(number);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, top: 16, left: 5, right: 5),
      child: CustomInputField(
        controller: _numberController,
        formKey: _formKey,
        onSubmit: onSubmit,
        validator: validator,
        requestStatus: _requestStatus,
        hintText: "Enter the maximum visitors number",
        buttonTitle: "Change visitors number",
        keyboardType: TextInputType.number,
      ),
    );
  }
}
