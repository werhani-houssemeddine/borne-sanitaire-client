// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:borne_sanitaire_client/Screens/complete_signup/main.dart'
    as _i3;
import 'package:borne_sanitaire_client/Screens/Home/main.dart' as _i7;
import 'package:borne_sanitaire_client/Screens/Home/Screen/add_new_device.dart'
    as _i1;
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents.dart' as _i2;
import 'package:borne_sanitaire_client/Screens/Home/Screen/dashboard/main.dart'
    as _i4;
import 'package:borne_sanitaire_client/Screens/Home/Screen/devices.dart' as _i5;
import 'package:borne_sanitaire_client/Screens/init/initialRoute.dart' as _i8;
import 'package:borne_sanitaire_client/Screens/Login/main.dart' as _i9;
import 'package:borne_sanitaire_client/Screens/profile/edit_profile.dart'
    as _i6;
import 'package:borne_sanitaire_client/Screens/profile/main.dart' as _i10;
import 'package:borne_sanitaire_client/Screens/Signup/main.dart' as _i11;
import 'package:borne_sanitaire_client/Screens/welcome.dart' as _i12;
import 'package:flutter/material.dart' as _i14;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    AddNewDeviceRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddNewDeviceRoute(),
      );
    },
    AgentsRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AgentsScreen(),
      );
    },
    CompleteUserSignUpRoute.name: (routeData) {
      final args = routeData.argsAs<CompleteUserSignUpRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CompleteUserSignUpScreen(
          key: args.key,
          deviceId: args.deviceId,
        ),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DashboardScreen(),
      );
    },
    DevicesRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DevicesScreen(),
      );
    },
    EditProfile.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.EditProfile(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomeScreen(),
      );
    },
    InitialRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.InitialScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.LoginScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ProfileScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.SignupScreen(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.WelcomeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddNewDeviceRoute]
class AddNewDeviceRoute extends _i13.PageRouteInfo<void> {
  const AddNewDeviceRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AddNewDeviceRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddNewDeviceRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AgentsScreen]
class AgentsRoute extends _i13.PageRouteInfo<void> {
  const AgentsRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AgentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AgentsRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CompleteUserSignUpScreen]
class CompleteUserSignUpRoute
    extends _i13.PageRouteInfo<CompleteUserSignUpRouteArgs> {
  CompleteUserSignUpRoute({
    _i14.Key? key,
    required String? deviceId,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          CompleteUserSignUpRoute.name,
          args: CompleteUserSignUpRouteArgs(
            key: key,
            deviceId: deviceId,
          ),
          initialChildren: children,
        );

  static const String name = 'CompleteUserSignUpRoute';

  static const _i13.PageInfo<CompleteUserSignUpRouteArgs> page =
      _i13.PageInfo<CompleteUserSignUpRouteArgs>(name);
}

class CompleteUserSignUpRouteArgs {
  const CompleteUserSignUpRouteArgs({
    this.key,
    required this.deviceId,
  });

  final _i14.Key? key;

  final String? deviceId;

  @override
  String toString() {
    return 'CompleteUserSignUpRouteArgs{key: $key, deviceId: $deviceId}';
  }
}

/// generated route for
/// [_i4.DashboardScreen]
class DashboardRoute extends _i13.PageRouteInfo<void> {
  const DashboardRoute({List<_i13.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DevicesScreen]
class DevicesRoute extends _i13.PageRouteInfo<void> {
  const DevicesRoute({List<_i13.PageRouteInfo>? children})
      : super(
          DevicesRoute.name,
          initialChildren: children,
        );

  static const String name = 'DevicesRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i6.EditProfile]
class EditProfile extends _i13.PageRouteInfo<void> {
  const EditProfile({List<_i13.PageRouteInfo>? children})
      : super(
          EditProfile.name,
          initialChildren: children,
        );

  static const String name = 'EditProfile';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i8.InitialScreen]
class InitialRoute extends _i13.PageRouteInfo<void> {
  const InitialRoute({List<_i13.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.LoginScreen]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ProfileScreen]
class ProfileRoute extends _i13.PageRouteInfo<void> {
  const ProfileRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i11.SignupScreen]
class SignupRoute extends _i13.PageRouteInfo<void> {
  const SignupRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i12.WelcomeScreen]
class WelcomeRoute extends _i13.PageRouteInfo<void> {
  const WelcomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}
