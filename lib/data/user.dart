class CurrentUser {
  static bool haveInstance = false;
  static CurrentUser? instance;

  final int id;
  final String username;
  final String email;
  final String role;
  final String token;
  final int? phoneNumber;

  CurrentUser._({
    required this.email,
    required this.username,
    required this.id,
    required this.role,
    required this.token,
    required this.phoneNumber,
  });

  factory CurrentUser.createInstance({
    required String email,
    required String username,
    required int id,
    required String role,
    required String token,
    int? phoneNumber,
  }) {
    if (!haveInstance) {
      instance = CurrentUser._(
        email: email,
        username: username,
        id: id,
        role: role,
        token: token,
        phoneNumber: phoneNumber,
      );
      haveInstance = true;
    }
    return instance!;
  }

  static void releaseInstance() {
    haveInstance = false;
    instance = null;
  }
}
