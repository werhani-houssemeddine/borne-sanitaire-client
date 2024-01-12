import 'package:borne_sanitaire_client/widget/show_image.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

class AgentDetailsProfileSection extends StatelessWidget {
  final String email;
  final String username;
  final String createdAt;
  final String? profilePicture;
  final bool isActif;

  const AgentDetailsProfileSection({
    required this.createdAt,
    required this.email,
    required this.profilePicture,
    required this.username,
    required this.isActif,
    Key? key,
  }) : super(key: key);

  Widget cellTextContent(
    String title, {
    Color? color = Colors.black,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
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
      singleRow("Email address", email),
      singleRow("Name", username),
      singleRow("Account from", createdAt),
      singleRow("State", isActif ? "Actif" : "Suspended"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShowImage(
          defaultAssets: "assets/user.png",
          size: const Size(120, 120),
          onlinePictureSrc: profilePicture,
          color: AppColors.primary,
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
