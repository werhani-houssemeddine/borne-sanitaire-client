import 'package:borne_sanitaire_client/Screens/services/update_client.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _showPassword = false;
  void togglePassword() => setState(() => _showPassword = !_showPassword);
  String? errorMessage;
  bool success = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
            },
            children: [
              _buildRow(
                "Current",
                "Enter your current password",
                _currentPassword,
                _inputValidator(),
              ),
              _buildRow(
                "New",
                "Enter your new password",
                _newPassword,
                _inputValidator(),
              ),
              _buildRow(
                "Confirm",
                "Confirm your new password",
                _confirmPassword,
                _inputValidator(isThird: true),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                success
                    ? "Password updated successfully"
                    : (errorMessage ?? ""),
                style: TextStyle(
                  color: success ? Colors.greenAccent.shade400 : Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          MakeGestureDetector(
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                updatePassword(_currentPassword.text, _newPassword.text).then(
                  (response) => {
                    setState(
                      () {
                        response == null
                            ? success = true
                            : errorMessage = response;
                      },
                    )
                  },
                );
              } else {
                setState(() => errorMessage = "Something is wrong");
              }
            },
            child: Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Center(
                child: Text(
                  "Confirm update password",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? Function(String?)? _inputValidator({bool isThird = false}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return '';
      }

      if (value.length <= 10) {
        return '';
      }

      if (isThird && value != _newPassword.text) {
        return '';
      }

      return null;
    };
  }

  TableRow _buildRow(
    String labelText,
    String hintText,
    TextEditingController controller,
    validator,
  ) {
    TableCell addPadding(Widget child) {
      return TableCell(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
          child: child,
        ),
      );
    }

    return TableRow(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black45),
        ),
      ),
      children: [
        addPadding(
          Text(
            labelText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        addPadding(
          TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
              errorStyle: const TextStyle(fontSize: 0),
              border: InputBorder.none,
              /*suffixIcon: IconButton(
                icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: togglePassword,
              ),*/
            ),
            style: TextStyle(
              fontSize: _showPassword ? 16.0 : 22.0,
              color: Colors.black,
            ),
            obscureText: !_showPassword,
          ),
        ),
      ],
    );
  }
}
