import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Service/current_user.dart';
import 'package:borne_sanitaire_client/Screens/services/update_client.dart';
import 'package:borne_sanitaire_client/data/user.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/widget/customInput.dart';
import 'package:flutter/material.dart';

class ChangePhoneNumber extends StatefulWidget {
  const ChangePhoneNumber({Key? key}) : super(key: key);

  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  REQUEST_STATE? _requestStatus;
  String? _errorMessage;

  String? validator(String? value) {
    print(value);
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a valid phone number';
    }

    if (int.tryParse(value) != null && int.parse(value) < 0) {
      return 'Please enter a valid number';
    }

    if (value.length != 8) {
      return 'Phone number must have 8 digit';
    }

    if (int.parse(value) == CurrentUser.instance!.phoneNumber) {
      return 'Please write a new phone number';
    }

    return null;
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        String value = controller.text.trim();
        final serviceResponse = await updatePhone(value);
        if (serviceResponse == null) {
          setState(() => _requestStatus = REQUEST_STATE.SUCCESS);
          User.getCurrentUserData(update: true);
          if (context.mounted) {
            Future.delayed(const Duration(seconds: 1), () {
              AutoRouter.of(context).popUntilRouteWithName(ProfileRoute.name);
              AutoRouter.of(context).push(const EditProfile());
            });
          }
        } else {
          setState(() {
            _errorMessage = serviceResponse;
            _requestStatus = REQUEST_STATE.FAILLURE;
          });
        }
      } catch (e) {
        setState(() => _requestStatus = REQUEST_STATE.FAILLURE);
      }
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
      hintText: "Enter your phone number",
      buttonTitle: "Change your phone number",
      keyboardType: TextInputType.number,
      errorMessage: _errorMessage,
    );
  }
}
