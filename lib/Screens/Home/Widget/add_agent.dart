import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/interface.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/service.dart';
import 'package:flutter/material.dart';

Future AddAgentBuilder(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black87.withOpacity(0.5),
    builder: (context) => const _AddAgent(),
  );
}

class _AddAgent extends StatelessWidget {
  const _AddAgent({Key? key}) : super(key: key);

  Widget _DialogTitle() {
    return const Center(
      child: Text(
        "Add New Agent",
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          fontFamily: "cursive",
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
          // color: Colors.deepPurpleAccent.shade700,
        ),
      ),
    );
  }

  Widget _gapWidget() {
    return const SizedBox(height: 20);
  }

  Widget _Description() {
    return RichText(
      textAlign: TextAlign.justify,
      text: const TextSpan(
        text:
            "To add a new agent, enter their email. We will attempt to send an email to complete the process. "
            "Upon the agent's acceptance or refusal, you will receive a notification. "
            "You can also check the request status on the Agents page.",
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Container(
        constraints: const BoxConstraints(/*maxHeight: 350*/),
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _DialogTitle(),
              _gapWidget(),
              _gapWidget(),
              _Description(),
              _EmailSending(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailSending extends StatefulWidget {
  @override
  _EmailSendingState createState() => _EmailSendingState();
}

class _EmailSendingState extends State<_EmailSending> {
  bool isSendingEmail = false;
  String? sendingEmailState;
  final _emailController = TextEditingController();

  void sendEmailToServer() async {
    if (_emailController.text.isNotEmpty) {
      if (_emailController.text.contains('@')) {
        setState(() {
          isSendingEmail = true;
        });

        ADD_AGENT_INTERFACE response =
            await AgentService.addAgent(_emailController.text.trim());

        if (response == ADD_AGENT_INTERFACE.SUCCESS) {
          setState(() {
            sendingEmailState = "SUCCESS";
          });
        } else if (response == ADD_AGENT_INTERFACE.MISSING_EMAIL) {
          setState(() {
            sendingEmailState = "MISSING EMAIL";
          });
        } else if (response == ADD_AGENT_INTERFACE.EMAIL_USED) {
          setState(() {
            sendingEmailState = "EMAIL USED";
          });
        } else if (response == ADD_AGENT_INTERFACE.SERVER_ERROR) {
          setState(() {
            sendingEmailState = "SERVER ERROR";
          });
        }
      }
    }

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isSendingEmail = false;
      });
      // Add your actual HTTP request logic here
    });
  }

  Widget _AlertAddingEmail() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.red.shade800,
                  size: 24,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    "Note: The server cannot check if the email is received by the"
                    "agent make sure you provide the correct email.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: Colors.redAccent.shade400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget? chooseIcon() {
    if (isSendingEmail == true) {
      return CircularProgressIndicator(color: Colors.greenAccent.shade400);
    } else if (sendingEmailState != null) {
      if (sendingEmailState == "SUCCESS") {
        return Icon(Icons.check, color: Colors.greenAccent.shade400);
      } else {
        return Icon(Icons.close, color: Colors.redAccent.shade700);
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent.shade700,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }

                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.all(8.0),
                child: chooseIcon(),
              ),
            ],
          ),
        ),
        _AlertAddingEmail(),
        Container(
          margin: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 8.0,
            top: 16.0,
          ),
          width: double.maxFinite,
          child: _ButtonsContainer(context, sendEmailToServer),
        )
      ],
    );
  }
}

Widget _ButtonsContainer(BuildContext context, void Function() submitRequest) {
  final screenSize = MediaQuery.of(context).size;

  Widget ButtonFactory({
    required void Function() onPressed,
    required Color primaryColor,
    required String buttonTitle,
  }) {
    var margin = screenSize.width >= 450
        ? const EdgeInsets.symmetric(horizontal: 8.0)
        : const EdgeInsets.symmetric(vertical: 8.0);
    return Container(
      margin: margin,
      height: 40,
      width: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
            side: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
        child: Text(buttonTitle),
      ),
    );
  }

  void cancelSubmitting() => Navigator.pop(context);

  List<Widget> listOfButtons = <Widget>[
    ButtonFactory(
      onPressed: () => cancelSubmitting(),
      primaryColor: Colors.red,
      buttonTitle: "Cancel",
    ),
    ButtonFactory(
      onPressed: () => submitRequest(),
      primaryColor: Colors.tealAccent.shade400,
      buttonTitle: "Add Agent",
    ),
  ];

  LargeScreen() => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: listOfButtons,
      );

  SmallScreen() => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: listOfButtons,
      );

  return screenSize.width >= 450 ? LargeScreen() : SmallScreen();
}
