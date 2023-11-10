import 'package:hive/hive.dart';
part 'auth_token.g.dart';

@HiveType(typeId: 1)
class AuthToken {
  @HiveField(0)
  String? token;

  @HiveField(1)
  int? expiresIn;

  AuthToken({
    required this.token,
    this.expiresIn,
  });
}
