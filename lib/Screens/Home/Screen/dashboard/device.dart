import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

class DeviceWidget extends StatelessWidget {
  final String deviceId;
  const DeviceWidget({
    required this.deviceId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ChangeMaximumVisitorInput(),
          ],
        ),
      ),
    );
  }
}

class ChangeMaximumVisitorInput extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<ChangeMaximumVisitorInput> {
  final _textController = TextEditingController();
  // bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _textController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Change Maximum visitors number",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primary, width: 2.0),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primary, width: 2.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    onChanged: (value) {
                      /*setState(() {
                        _isValid = value.isNotEmpty;
                      });*/
                    },
                  ),
                ),
                /*_isValid
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : _textController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _textController.clear();
                                _isValid = false;
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          )
                        : const SizedBox.shrink(),*/
              ],
            ),
            MakeGestureDetector(
              child: Container(
                width: double.maxFinite,
                height: 55,
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Change",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                String enteredText = _textController.text;
                print(enteredText);
              },
            ),
          ],
        ),
      ),
    );
  }
}
