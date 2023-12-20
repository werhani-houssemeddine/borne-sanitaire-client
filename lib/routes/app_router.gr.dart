// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:borne_sanitaire_client/Screens/complete_signup/main.dart'
    as _i4;
import 'package:borne_sanitaire_client/Screens/Home/main.dart' as _i8;
import 'package:borne_sanitaire_client/Screens/Home/Screen/add_new_device.dart'
    as _i1;
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/main.dart'
    as _i2;
import 'package:borne_sanitaire_client/Screens/Home/Screen/dashboard/main.dart'
    as _i5;
import 'package:borne_sanitaire_client/Screens/Home/Screen/devices.dart' as _i6;
import 'package:borne_sanitaire_client/Screens/init/initialRoute.dart' as _i9;
import 'package:borne_sanitaire_client/Screens/Login/main.dart' as _i10;
import 'package:borne_sanitaire_client/Screens/OTP/main.dart' as _i14;
import 'package:borne_sanitaire_client/Screens/profile/edit_profile.dart'
    as _i7;
import 'package:borne_sanitaire_client/Screens/profile/main.dart' as _i11;
import 'package:borne_sanitaire_client/Screens/Signup/check_email.dart' as _i3;
import 'package:borne_sanitaire_client/Screens/Signup/form.dart' as _i12;
import 'package:borne_sanitaire_client/Screens/Signup/main.dart' as _i13;
import 'package:borne_sanitaire_client/Screens/welcome.dart' as _i15;
import 'package:flutter/material.dart' as _i17;

abstract class $AppRouter extends _i16.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    AddNewDeviceRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddNewDeviceRoute(),
      );
    },
    AgentsRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AgentsScreen(),
      );
    },
    CheckEmailAddressRoute.name: (routeData) {
      final args = routeData.argsAs<CheckEmailAddressRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CheckEmailAddressRoute(
          key: args.key,
          deviceId: args.deviceId,
        ),
      );
    },
    CompleteUserSignUpRoute.name: (routeData) {
      final args = routeData.argsAs<CompleteUserSignUpRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.CompleteUserSignUpScreen(
          key: args.key,
          deviceId: args.deviceId,
        ),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DashboardScreen(),
      );
    },
    DevicesRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.DevicesScreen(),
      );
    },
    EditProfile.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.EditProfile(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.HomeScreen(),
      );
    },
    InitialRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.InitialScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LoginScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.ProfileScreen(),
      );
    },
    SignUpFormRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpFormRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.SignUpFormRoute(
          key: args.key,
          deviceId: args.deviceId,
          email: args.email,
        ),
      );
    },
    SignupRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.SignupScreen(),
      );
    },
    VerificationCodeRoute.name: (routeData) {
      final args = routeData.argsAs<VerificationCodeRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.VerificationCodeScreen(
          key: args.key,
          email: args.email,
          deviceId: args.deviceId,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.WelcomeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddNewDeviceRoute]
class AddNewDeviceRoute extends _i16.PageRouteInfo<void> {
  const AddNewDeviceRoute({List<_i16.PageRouteInfo>? children})
      : super(
          AddNewDeviceRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddNewDeviceRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AgentsScreen]
class AgentsRoute extends _i16.PageRouteInfo<void> {
  const AgentsRoute({List<_i16.PageRouteInfo>? children})
      : super(
          AgentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AgentsRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CheckEmailAddressRoute]
class CheckEmailAddressRoute
    extends _i16.PageRouteInfo<CheckEmailAddressRouteArgs> {
  CheckEmailAddressRoute({
    _i17.Key? key,
    required String deviceId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          CheckEmailAddressRoute.name,
          args: CheckEmailAddressRouteArgs(
            key: key,
            deviceId: deviceId,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckEmailAddressRoute';

  static const _i16.PageInfo<CheckEmailAddressRouteArgs> page =
      _i16.PageInfo<CheckEmailAddressRouteArgs>(name);
}

class CheckEmailAddressRouteArgs {
  const CheckEmailAddressRouteArgs({
    this.key,
    required this.deviceId,
  });

  final _i17.Key? key;

  final String deviceId;

  @override
  String toString() {
    return 'CheckEmailAddressRouteArgs{key: $key, deviceId: $deviceId}';
  }
}

/// generated route for
/// [_i4.CompleteUserSignUpScreen]
class CompleteUserSignUpRoute
    extends _i16.PageRouteInfo<CompleteUserSignUpRouteArgs> {
  CompleteUserSignUpRoute({
    _i17.Key? key,
    required String? deviceId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          CompleteUserSignUpRoute.name,
          args: CompleteUserSignUpRouteArgs(
            key: key,
            deviceId: deviceId,
          ),
          initialChildren: children,
        );

  static const String name = 'CompleteUserSignUpRoute';

  static const _i16.PageInfo<CompleteUserSignUpRouteArgs> page =
      _i16.PageInfo<CompleteUserSignUpRouteArgs>(name);
}

class CompleteUserSignUpRouteArgs {
  const CompleteUserSignUpRouteArgs({
    this.key,
    required this.deviceId,
  });

  final _i17.Key? key;

  final String? deviceId;

  @override
  String toString() {
    return 'CompleteUserSignUpRouteArgs{key: $key, deviceId: $deviceId}';
  }
}

/// generated route for
/// [_i5.DashboardScreen]
class DashboardRoute extends _i16.PageRouteInfo<void> {
  const DashboardRoute({List<_i16.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i6.DevicesScreen]
class DevicesRoute extends _i16.PageRouteInfo<void> {
  const DevicesRoute({List<_i16.PageRouteInfo>? children})
      : super(
          DevicesRoute.name,
          initialChildren: children,
        );

  static const String name = 'DevicesRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i7.EditProfile]
class EditProfile extends _i16.PageRouteInfo<void> {
  const EditProfile({List<_i16.PageRouteInfo>? children})
      : super(
          EditProfile.name,
          initialChildren: children,
        );

  static const String name = 'EditProfile';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HomeScreen]
class HomeRoute extends _i16.PageRouteInfo<void> {
  const HomeRoute({List<_i16.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i9.InitialScreen]
class InitialRoute extends _i16.PageRouteInfo<void> {
  const InitialRoute({List<_i16.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LoginScreen]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute({List<_i16.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i11.ProfileScreen]
class ProfileRoute extends _i16.PageRouteInfo<void> {
  const ProfileRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i12.SignUpFormRoute]
class SignUpFormRoute extends _i16.PageRouteInfo<SignUpFormRouteArgs> {
  SignUpFormRoute({
    _i17.Key? key,
    required String deviceId,
    required String email,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          SignUpFormRoute.name,
          args: SignUpFormRouteArgs(
            key: key,
            deviceId: deviceId,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'SignUpFormRoute';

  static const _i16.PageInfo<SignUpFormRouteArgs> page =
      _i16.PageInfo<SignUpFormRouteArgs>(name);
}

class SignUpFormRouteArgs {
  const SignUpFormRouteArgs({
    this.key,
    required this.deviceId,
    required this.email,
  });

  final _i17.Key? key;

  final String deviceId;

  final String email;

  @override
  String toString() {
    return 'SignUpFormRouteArgs{key: $key, deviceId: $deviceId, email: $email}';
  }
}

/// generated route for
/// [_i13.SignupScreen]
class SignupRoute extends _i16.PageRouteInfo<void> {
  const SignupRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i14.VerificationCodeScreen]
class VerificationCodeRoute
    extends _i16.PageRouteInfo<VerificationCodeRouteArgs> {
  VerificationCodeRoute({
    _i17.Key? key,
    required String email,
    String? deviceId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          VerificationCodeRoute.name,
          args: VerificationCodeRouteArgs(
            key: key,
            email: email,
            deviceId: deviceId,
          ),
          initialChildren: children,
        );

  static const String name = 'VerificationCodeRoute';

  static const _i16.PageInfo<VerificationCodeRouteArgs> page =
      _i16.PageInfo<VerificationCodeRouteArgs>(name);
}

class VerificationCodeRouteArgs {
  const VerificationCodeRouteArgs({
    this.key,
    required this.email,
    this.deviceId,
  });

  final _i17.Key? key;

  final String email;

  final String? deviceId;

  @override
  String toString() {
    return 'VerificationCodeRouteArgs{key: $key, email: $email, deviceId: $deviceId}';
  }
}

/// generated route for
/// [_i15.WelcomeScreen]
class WelcomeRoute extends _i16.PageRouteInfo<void> {
  const WelcomeRoute({List<_i16.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}
