import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref? _instance;
  late SharedPreferences _prefs;

  // Private constructor
  SharedPref._();

  // Getter for the instance
  static Future<SharedPref> getInstance() async {
    if (_instance == null) {
      _instance = SharedPref._();
      await _instance!._init();
    }
    return _instance!;
  }

  // Initialize SharedPreferences
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Setters
  Future<void> setUserId(String userId) async {
    await _prefs.setString('userId', userId);
  }

  Future<void> setFirstName(String firstName) async {
    await _prefs.setString('FirstName', firstName);
  }

  Future<void> setLastName(String lastName) async {
    await _prefs.setString('LastName', lastName);
  }

  Future<void> setEmail(String email) async {
    await _prefs.setString('email', email);
  }

  // Getters
  Future<String?> getUserId() async {
    return _prefs.getString('userId');
  }

  Future<String?> getFirstName() async {
    return _prefs.getString('FirstName');
  }

  Future<String?> getLastName() async {
    return _prefs.getString('LastName');
  }

  Future<String?> getEmail() async {
    return _prefs.getString('email');
  }

  // Clear values
  Future<void> clearProfile() async {
    await _prefs.remove('userId');
    await _prefs.remove('FirstName');
    await _prefs.remove('LastName');
    await _prefs.remove('email');
  }
}
