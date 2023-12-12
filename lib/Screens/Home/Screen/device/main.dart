import 'package:borne_sanitaire_client/Screens/Home/Screen/device/device_details.dart';
import 'package:borne_sanitaire_client/Screens/Home/Service/device.dart';
import 'package:borne_sanitaire_client/data/device.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/show_bottom_modal.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

class DeviceScreen2 extends StatelessWidget {
  const DeviceScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllDevices(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          List<Device> listOfDevices = snapshot.data;

          return Container(
            padding: const EdgeInsets.all(5.0),
            child: ListView.builder(
              itemCount: (listOfDevices.length / 2).ceil(),
              itemBuilder: (context, index) {
                int startIndex = index * 2;
                int endIndex = startIndex + 2;

                if (endIndex > listOfDevices.length) {
                  endIndex = listOfDevices.length;
                }

                List<Device> rowItems =
                    listOfDevices.sublist(startIndex, endIndex);
                return Row(
                  children: rowItems
                      .map((device) =>
                          Expanded(child: DeviceWidget(device: device)))
                      .toList(),
                );
              },
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}

class DeviceWidget extends StatelessWidget {
  final Device device;
  const DeviceWidget({
    Key? key,
    required this.device,
  }) : super(key: key);

  showDeviceModal(BuildContext context, Device device) {
    ShowModalBttomSheet(context, child: DeviceDetails(device: device));
  }

  @override
  Widget build(BuildContext context) {
    return MakeGestureDetector(
      onPressed: () => showDeviceModal(context, device),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: AppColors.primary,
          ),
        ),
        margin: const EdgeInsets.all(3.0),
        height: 120,
        child: const Image(
          image: AssetImage("assets/settings.png"),
        ),
      ),
    );
  }
}
