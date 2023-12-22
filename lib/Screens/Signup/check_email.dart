import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Signup/signup_service.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/widget/arrow_back.dart';
import 'package:borne_sanitaire_client/widget/customInput.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CheckEmailAddressRoute extends StatefulWidget {
  final String deviceId;
  const CheckEmailAddressRoute({Key? key, required this.deviceId})
      : super(key: key);

  @override
  _CheckEmailAddressState createState() => _CheckEmailAddressState();
}

class _CheckEmailAddressState extends State<CheckEmailAddressRoute> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  REQUEST_STATE? _requestStatus;
  String? errorMessage;

  String? validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a valid email';
    }

    return null;
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        String value = controller.text.trim();
        String? serviceResponse = await signUpEmail(email: value);

        if (serviceResponse == null) {
          setState(() => _requestStatus = REQUEST_STATE.SUCCESS);
          if (context.mounted) {
            Future.delayed(const Duration(seconds: 1), () {
              AutoRouter.of(context).replace(VerificationCodeRoute(
                  email: value, deviceId: widget.deviceId));
            });
          }
        } else {
          setState(() {
            errorMessage = serviceResponse;
            _requestStatus = REQUEST_STATE.FAILLURE;
          });
        }
      } catch (e) {
        print(e);
        setState(() => _requestStatus = REQUEST_STATE.FAILLURE);
      }
    }
  }

  void onChanged() {
    setState(() {
      errorMessage = null;
      _requestStatus = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: currentHeight,
        color: AppColors.primary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: ArrowBack(),
            ),
            Container(
              height: currentHeight * 0.9,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20.0)),
                color: AppColors.bgColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Please enter a valid email, we will send you a verification "
                    "code to complete the process of creating an account",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  CustomInputField(
                    controller: controller,
                    formKey: _formKey,
                    onSubmit: onSubmit,
                    validator: validator,
                    requestStatus: _requestStatus,
                    hintText: "Enter your email",
                    buttonTitle: "Signup",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    errorMessage: errorMessage,
                    onChanged: onChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
