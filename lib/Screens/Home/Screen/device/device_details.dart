import 'package:borne_sanitaire_client/Screens/Home/Screen/device/device_title.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/device/max_visitors.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/device/set_main.dart';
import 'package:borne_sanitaire_client/data/device.dart';
import 'package:borne_sanitaire_client/data/user.dart';
import 'package:borne_sanitaire_client/widget/arrow_back.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

class DeviceDetails extends StatelessWidget {
  final Device device;

  const DeviceDetails({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ArrowBack(),
              const Divider(),
              GetDeviceDetails(device: device),
              const Divider(),
              const CardComponentBuilder(
                title: 'Change Device Max Visitors',
                child: SetMaxVisitors(),
              ),
              const CardComponentBuilder(
                title: 'Device title',
                description: 'Set up the device title',
                child: SetDeviceTitle(),
              ),
              const CardComponentBuilder(
                title: 'Set the main device',
                description: 'The main device is the principal device that '
                    'will be showen in the dashboard when you open the application',
                child: SetMainDevice(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GetDeviceDetails extends StatelessWidget {
  final Device device;
  const GetDeviceDetails({Key? key, required this.device}) : super(key: key);

  TableCell makeTableCell1(String title) => TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      );

  TableCell makeTableCell2(String value) => TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
      );

  TableRow makeTableRow(String title, String value) => TableRow(
        children: [makeTableCell1(title), makeTableCell2(value)],
      );

  List<TableRow> get tableRows => [
        makeTableRow("username", CurrentUser.instance!.username),
        if (CurrentUser.instance!.phoneNumber != null)
          makeTableRow(
            "phone number",
            CurrentUser.instance!.phoneNumber as String,
          ),
        makeTableRow('Title', device.title!),
        makeTableRow("purchased at", device.purchaseDate),
        makeTableRow("max visitors", (device.maxVisitors ?? 0).toString()),
        makeTableRow("version", device.version),
      ];

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(2),
      },
      children: tableRows,
    );
  }
}

class CardComponentBuilder extends StatelessWidget {
  final String title;
  final Widget child;
  final String? description;
  const CardComponentBuilder({
    Key? key,
    required this.title,
    required this.child,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 5,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (description != null)
                Text(
                  description!,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12.0),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
