// ignore_for_file: non_constant_identifier_names

import 'package:borne_sanitaire_client/widget/arrow_back.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/show_image.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future ShowModalContainer(BuildContext context, {required Widget child}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: const Color.fromARGB(255, 241, 251, 255),
    barrierColor: Colors.black87.withOpacity(0.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      ),
    ),
    isScrollControlled: true,
    isDismissible: false,
    builder: (context) => child,
  );
}

class PendingAgentModal extends StatelessWidget {
  const PendingAgentModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [],
      ),
    );
  }
}

class AgentDetailsModal extends StatelessWidget {
  const AgentDetailsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      color: AppColors.bgColor,
      padding: const EdgeInsets.all(8.0),
      child: const Column(
        children: [
          ArrowBack(),
          Divider(),
          AgentDetailsProfileSection(),
          AgentDetailsLinkSection(),
          Divider(),
          AgentPermessions(),
        ],
      ),
    );
  }
}

class AgentDetailsProfileSection extends StatelessWidget {
  const AgentDetailsProfileSection({Key? key}) : super(key: key);

  Widget cellTextContent(
    String title, {
    Color? color = Colors.black,
  }) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Text(
        title,
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: color,
          fontSize: 10,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  TableRow singleRow(String title, String value) {
    Widget addMargin(Widget? widget) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: widget,
      );
    }

    return TableRow(
      children: [
        TableCell(
          child: addMargin(
            cellTextContent(title, color: Colors.black54),
          ),
        ),
        TableCell(
          child: addMargin(cellTextContent(value)),
        ),
      ],
    );
  }

  List<TableRow> tableRows() {
    return [
      singleRow("Email address", "houssemwuerhani@gmail.com"),
      singleRow("Name", "Houssemeddine werhani"),
      singleRow("Account from", "09/12/2023"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShowOnlineImage(
          size: const Size(120, 120),
          color: AppColors.primary,
          urlImage:
              "https://media.licdn.com/dms/image/D4D03AQFCT_zmnluMxw/profile-displayphoto-shrink_400_400/0/1669855115203?e=1707350400&v=beta&t=O7Bhxfag5L5ebfE-sY4ezrY3i2kI89S-FMSHGOCdkak",
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(2),
                2: FixedColumnWidth(30),
              },
              children: tableRows(),
            ),
          ),
        ),
      ],
    );
  }
}

class AgentDetailsLinkSection extends StatelessWidget {
  const AgentDetailsLinkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 10),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AgentPhoneNumber(),
          SuspendAgent(),
          DeleteAgent(),
        ],
      ),
    );
  }
}

class AgentPhoneNumber extends StatefulWidget {
  const AgentPhoneNumber({Key? key}) : super(key: key);

  @override
  _AgentDetailsState createState() => _AgentDetailsState();
}

class _AgentDetailsState extends State<AgentPhoneNumber> {
  String phoneAsset = "assets/phone.svg";

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      //onEnter: (e) => setState(() => phoneAsset = "assets/reversed_phone.svg"),
      //onExit: (e) => setState(() => phoneAsset = "assets/phone.svg"),
      child: GestureDetector(
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.all(5.0),
          child: SvgPicture.asset(
            phoneAsset,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class SuspendAgent extends StatelessWidget {
  const SuspendAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return MakeGestureDetector(
      onPressed: () {},
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5.0),
        child: SvgPicture.asset(
          "assets/suspend.svg",
          height: 32,
          width: 32,
        ),
      ),
    );
  }
}

class DeleteAgent extends StatelessWidget {
  const DeleteAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return MakeGestureDetector(
      onPressed: () {},
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(5.0),
        child: SvgPicture.asset(
          "assets/trash.svg",
          height: 32,
          width: 32,
        ),
      ),
    );
  }
}

class AgentPermessions extends StatelessWidget {
  const AgentPermessions({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
