import 'package:borne_sanitaire_client/Screens/profile/settings/interface.dart';
import 'package:borne_sanitaire_client/Screens/profile/settings/service.dart';
import 'package:borne_sanitaire_client/widget/customInput.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:borne_sanitaire_client/widget/switch.dart';
import 'package:flutter/material.dart';

class EnableOTPAuth extends StatefulWidget {
  const EnableOTPAuth({Key? key}) : super(key: key);

  @override
  State<EnableOTPAuth> createState() => _EnableOTPAuthState();
}

class _EnableOTPAuthState extends State<EnableOTPAuth> {
  bool showPasswordWidget = false;

  setToggleSwitch() {
    setState(() => showPasswordWidget = !showPasswordWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SettingsService.checkOTP(),
      builder: (context, snapshot) {
        CHECK_OTP_RESPONSE? response = snapshot.data;
        if (response != null) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 5,
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Secure Your Account with OTP Authentication",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Enhance the security of your account with One-Time "
                    "Password (OTP) Authentication we will send a unique, "
                    "time-sensitive code to your registered email address",
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
                    children: [
                      CustomSwitch(
                        setActionState: setToggleSwitch,
                        prevState: response == CHECK_OTP_RESPONSE.ENABLED,
                      ),
                    ],
                  ),
                  if (showPasswordWidget)
                    EnableOTPAuthInput(
                      isOPTEnabled: response == CHECK_OTP_RESPONSE.ENABLED,
                    ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class EnableOTPAuthInput extends StatefulWidget {
  final bool isOPTEnabled;
  const EnableOTPAuthInput({
    Key? key,
    required this.isOPTEnabled,
  }) : super(key: key);

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

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      String passwordValue = controller.text;
      try {
        setState(() => _requestStatus = REQUEST_STATE.PENDING);

        OTP_RESPONSE serviceResponse = widget.isOPTEnabled
            ? await SettingsService.disableOTP(passwordValue)
            : await SettingsService.enableOTP(passwordValue);

        if (serviceResponse == OTP_RESPONSE.SUCCESS) {
          setState(() => _requestStatus = REQUEST_STATE.SUCCESS);
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
    String isOTPEnabled = widget.isOPTEnabled ? "Disable" : "Enable";
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: CustomInputField(
        controller: controller,
        formKey: _formKey,
        onSubmit: onSubmit,
        validator: validator,
        requestStatus: _requestStatus,
        hintText: "Enter your password",
        buttonTitle: "$isOTPEnabled OTP password",
        password: true,
      ),
    );
  }
}
