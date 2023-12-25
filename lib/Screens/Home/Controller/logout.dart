import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/data/device.dart';
import 'package:borne_sanitaire_client/data/user.dart';
import 'package:borne_sanitaire_client/models/auth_token.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void logout(BuildContext context) async {
  try {
    final Box authBox = await Hive.openBox<AuthToken>('authBox');
    await authBox.clear();
    await authBox.close();

    CurrentUser.releaseInstance();
    Device.devices = [];

    if (context.mounted) context.router.replace(const InitialRoute());
  } catch (e) {
    print("An error occured logout $e");
    CurrentUser.releaseInstance();
    Device.devices = [];

    if (context.mounted) context.router.replace(const InitialRoute());
  }
}
