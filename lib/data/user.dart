class CurrentUser {
  static bool haveInstance = false;
  static CurrentUser? instance;
  static String? saveToken;

  final int id;
  final String username;
  final String email;
  final String role;
  final String token;
  final int? phoneNumber;
  final String? profilePicture;

  CurrentUser._({
    required this.email,
    required this.username,
    required this.id,
    required this.role,
    required this.token,
    required this.phoneNumber,
    required this.profilePicture,
  });

  factory CurrentUser.createInstance({
    required String email,
    required String username,
    required int id,
    required String role,
    required String token,
    int? phoneNumber,
    String? profilePicture,
  }) {
    if (!haveInstance) {
      instance = CurrentUser._(
        email: email,
        username: username,
        id: id,
        role: role,
        token: token,
        phoneNumber: phoneNumber,
        profilePicture: profilePicture,
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
