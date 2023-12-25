import 'package:borne_sanitaire_client/utils/convert_date.dart';

class Device {
  final String purchaseDate;
  final String id;
  final int? maxVisitors;
  final String? title;
  final bool isMainDevice;
  final String version;

  static List<Device> devices = [];

  Device({
    required this.purchaseDate,
    required this.id,
    required this.maxVisitors,
    required this.title,
    required this.isMainDevice,
    required this.version,
  });

  static Device createDeviceInstance(Map<String, dynamic> map) {
    Device device = Device(
      purchaseDate: map['purchase_date'] != null
          ? formatDateTime(map['purchase_date'])
          : '',
      id: map['id'] ?? '',
      maxVisitors: map['max_visitors'] ?? 0,
      title: map['title'] ?? 'Device',
      isMainDevice: map['main'] ?? false,
      version: map['version'] ?? '1.0.0',
    );
    Device.devices.add(device);

    return device;
  }
}
