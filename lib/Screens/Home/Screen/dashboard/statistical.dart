import 'dart:convert';

import 'package:borne_sanitaire_client/config.dart';
import 'package:borne_sanitaire_client/data/device.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Statistical extends StatefulWidget {
  final Device device;
  const Statistical({required this.device, Key? key}) : super(key: key);

  @override
  State<Statistical> createState() => _StatisticalState();
}

class _StatisticalState extends State<Statistical> {
  late IO.Socket socket;
  String? currentDeviceID;

  int current_visitors = 0;
  int max_visitors = 0;

  @override
  void initState() {
    initSocket(widget.device.id);
    connectSocket();
    getSocketData();
    super.initState();
  }

  void initSocket(String deviceId) {
    socket = IO.io("http://$SERVER_REAL_TIME/device", {
      'transports': ['websocket'],
      'query': {
        'deviceId': widget.device.id,
      },
    });

    currentDeviceID = deviceId;
  }

  void connectSocket() {
    socket.onConnect((data) => print('Connection established'));
    socket.onConnectError((error) => print('Connect error $error'));
    socket.onDisconnect((data) => print('Server Disconnect'));
  }

  void getSocketData() {
    socket.on('handshake', (data) {
      Map<String, dynamic> decodedData = jsonDecode(data);
      setState(() {
        current_visitors = decodedData['current_visitors'] as int;
        max_visitors = decodedData['max_visitors'] as int;
      });
    });
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentDeviceID != widget.device.id) {
      socket.dispose();
      initSocket(widget.device.id);
      connectSocket();
      getSocketData();
    }
    return Container(
        height: 130,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(width: 1, color: Colors.purple),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: StatisticalDetails(
                maxVisitors: max_visitors,
                currentVisitors: current_visitors,
              ),
            ),
            Expanded(
              flex: 1,
              child: PercentIndicator(
                maxVisitors: max_visitors,
                currentVisitors: current_visitors,
              ),
            ),
          ],
        ));
  }
}

class PercentIndicator extends StatelessWidget {
  final int maxVisitors;
  final int currentVisitors;

  const PercentIndicator({
    super.key,
    required this.currentVisitors,
    required this.maxVisitors,
  });

  double get percent => maxVisitors == 0 ? 0 : currentVisitors / maxVisitors;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 5.0,
      percent: percent,
      center: percent == 0 ? null : Text("${percent.toStringAsFixed(2)}%"),
      progressColor: const Color.fromRGBO(1, 65, 189, 1),
      backgroundColor: Colors.blue.shade200,
      rotateLinearGradient: true,
      animation: true,
      animationDuration: 800,
      circularStrokeCap: CircularStrokeCap.square,
    );
  }
}

class StatisticalDetails extends StatelessWidget {
  final int maxVisitors;
  final int currentVisitors;

  const StatisticalDetails({
    super.key,
    required this.currentVisitors,
    required this.maxVisitors,
  });

  double get percent => maxVisitors == 0 ? 0 : currentVisitors / maxVisitors;

  @override
  Widget build(BuildContext context) {
    String message = currentVisitors == 0 ? "no" : "$maxVisitors";
    String quotion =
        maxVisitors == 0 ? "$currentVisitors" : "$currentVisitors/$maxVisitors";
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "There is $message person(s)",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (currentVisitors != 0)
          Text(
            quotion,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
      ],
    );
  }
}
