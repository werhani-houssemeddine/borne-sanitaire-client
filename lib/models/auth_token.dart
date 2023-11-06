import 'package:hive/hive.dart';
part 'auth_token.g.dart';

@HiveType(typeId: 1)
class AuthToken {
  @HiveField(0)
  String? token;

  AuthToken({required this.token});
}
