import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Service/current_user.dart';
import 'package:borne_sanitaire_client/Screens/services/update_client.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/widget/customInput.dart';
import 'package:flutter/material.dart';

class ChangeNameScreen extends StatefulWidget {
  const ChangeNameScreen({Key? key}) : super(key: key);

  @override
  _SetMaxVisitorsState createState() => _SetMaxVisitorsState();
}

class _SetMaxVisitorsState extends State<ChangeNameScreen> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  REQUEST_STATE? _requestStatus;

  String? validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a valid username';
    }

    return null;
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        String value = controller.text.trim();
        final serviceResponse = await updateUsername(value);
        if (serviceResponse == true) {
          setState(() => _requestStatus = REQUEST_STATE.SUCCESS);
          User.getCurrentUserData(update: true);
          if (context.mounted) {
            Future.delayed(const Duration(seconds: 1), () {
              AutoRouter.of(context).popUntilRouteWithName(ProfileRoute.name);
              AutoRouter.of(context).replace(const EditProfile());
            });
          }
        } else {
          setState(() => _requestStatus = REQUEST_STATE.FAILLURE);
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
      hintText: "Enter your the username",
      buttonTitle: "Change your username",
    );
  }
}
