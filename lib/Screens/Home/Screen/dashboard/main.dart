import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/dashboard/calendar.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/dashboard/device.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/dashboard/devices_bar.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/dashboard/statistical.dart';
import 'package:borne_sanitaire_client/Screens/Home/Service/device.dart';
import 'package:borne_sanitaire_client/data/device.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialDataToDahsboard(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            List<Device> data = snapshot.data;
            print(data[0].isMainDevice);
            return DashboardWidgets(listOfDevices: data);
          }
        }

        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}

class DashboardWidgets extends StatefulWidget {
  final List<Device> listOfDevices;

  const DashboardWidgets({
    required this.listOfDevices,
    super.key,
  });

  @override
  State<DashboardWidgets> createState() => _DashboardWidgetsState();
}

class _DashboardWidgetsState extends State<DashboardWidgets> {
  Device? currentDevice;

  @override
  void initState() {
    for (Device device in widget.listOfDevices) {
      if (device.isMainDevice == true) {
        currentDevice = device;
        break;
      }
    }
    super.initState();
  }

  void setCurrentDevice(Device device) {
    setState(() {
      currentDevice = device;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CalendarWidget(),
            ListOfDevices(
              devices: widget.listOfDevices,
              currentDevice: currentDevice!,
              setState: setCurrentDevice,
            ),
            Statistical(device: currentDevice!),
            DeviceWidget(deviceId: currentDevice!.id),
          ],
        ),
      ),
    );
  }
}
