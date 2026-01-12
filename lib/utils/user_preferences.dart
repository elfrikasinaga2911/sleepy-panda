import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _nameKey = 'name';
  static const String _genderKey = 'gender';
  static const String _heightKey = 'height';
  static const String _weightKey = 'weight';

  /// ================= SAVE USER =================
  static Future<void> saveUser({
    String? name,
    String? gender,
    double? height,
    double? weight,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (name != null && name.isNotEmpty) {
        await prefs.setString(_nameKey, name);
      }

      if (gender != null && gender.isNotEmpty) {
        await prefs.setString(_genderKey, gender);
      }

      if (height != null && height > 0) {
        await prefs.setDouble(_heightKey, height);
      }

      if (weight != null && weight > 0) {
        await prefs.setDouble(_weightKey, weight);
      }
    } catch (e) {
      // supaya error tidak silent
      print('❌ ERROR saveUser: $e');
      rethrow;
    }
  }

  /// ================= GET USER =================
  static Future<Map<String, dynamic>> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      return {
        'name': prefs.getString(_nameKey) ?? '',
        'gender': prefs.getString(_genderKey) ?? '',
        'height': prefs.containsKey(_heightKey)
            ? prefs.getDouble(_heightKey)
            : null,
        'weight': prefs.containsKey(_weightKey)
            ? prefs.getDouble(_weightKey)
            : null,
      };
    } catch (e) {
      print('❌ ERROR getUser: $e');
      return {
        'name': '',
        'gender': '',
        'height': null,
        'weight': null,
      };
    }
  }

  /// ================= CLEAR =================
  static Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      print('❌ ERROR clear: $e');
    }
  }
}
