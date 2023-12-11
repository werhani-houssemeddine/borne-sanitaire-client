import 'package:borne_sanitaire_client/data/device.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

class ListOfDevices extends StatelessWidget {
  final List<Device> devices;
  final Device currentDevice;
  final void Function(Device) setState;
  const ListOfDevices({
    Key? key,
    required this.devices,
    required this.setState,
    required this.currentDevice,
  }) : super(key: key);

  List<Widget> get makeDeviceLink => devices
      .map(
        (e) => DeviceLink(
          selected: currentDevice.id == e.id,
          title: currentDevice.title ?? "Device",
          setCurrentDevice: () {
            setState(e);
          },
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: makeDeviceLink,
        ),
      ),
    );
  }
}

class DeviceLink extends StatelessWidget {
  final bool selected;
  final String title;
  final void Function() setCurrentDevice;

  const DeviceLink({
    required this.selected,
    required this.title,
    required this.setCurrentDevice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MakeGestureDetector(
      onPressed: setCurrentDevice,
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: selected ? AppColors.darkeBg : Colors.black54,
          ),
          borderRadius: BorderRadius.circular(4.0),
          color: selected ? AppColors.darkeBg : null,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: selected ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
