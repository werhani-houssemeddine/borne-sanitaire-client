class Device {
  final String purchaseDate;
  final String id;
  final int? visitors;
  final String? title;
  final bool isMainDevice;

  Device({
    required this.purchaseDate,
    required this.id,
    required this.visitors,
    required this.title,
    required this.isMainDevice,
  });

  static Device createDeviceInstance(Map<String, dynamic> map) {
    return Device(
      purchaseDate: map['purchaseDate'] ?? '',
      id: map['id'] ?? '',
      visitors: map['visitors'] ?? 0,
      title: map['title'] ?? 'Device',
      isMainDevice: map['main'] ?? false,
    );
  }
}
