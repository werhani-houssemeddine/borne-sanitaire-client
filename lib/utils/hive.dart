import 'package:borne_sanitaire_client/models/auth_token.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path;

class _LocalStorage {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final directory = await path.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }
}

class LocalStorageAuthToken {
  static void registerToken() {
    Hive.registerAdapter(AuthTokenAdapter());
  }

  static Future<Box<AuthToken>> getCollection() async {
    try {
      await _LocalStorage.init();
      return await Hive.openBox<AuthToken>('authBox');
    } catch (e) {
      print("Getting collection error $e");
      rethrow;
    }
  }

  static Future<String?> getToken() async {
    try {
      final Box<AuthToken> tokenBox = await getCollection();
      final AuthToken? authToken = tokenBox.get('token');

      //! This is similair to return authToken == null ? null : authToken.token
      return authToken?.token;
    } on Exception catch (e) {
      print("An Error occured when getting the token $e");
      return null;
    }
  }

  static void deleteToken() async {
    final tokenBox = await getCollection();
    tokenBox.delete('token');
  }
}
