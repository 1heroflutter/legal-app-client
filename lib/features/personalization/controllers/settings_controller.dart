import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/utils/constants/colors.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  // Observable variables
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  Rx<String> language = 'vi_VN'.obs; // Default locale
  Rx<Color> primaryColor = TColors.primary.obs; // Default to TColors.primary

  static Future<SettingsController> init() async {
    final controller = SettingsController();
    await controller._loadSettings();
    Get.put(controller);
    return controller;
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // Load theme
    String? themeString = prefs.getString('themeMode');
    if (themeString != null) {
      themeMode.value = ThemeMode.values.firstWhere(
        (e) => e.toString() == themeString,
        orElse: () => ThemeMode.system,
      );
    }

    // Load language
    String? langString = prefs.getString('language');
    if (langString != null) {
      language.value = langString;
      var localeParts = langString.split('_');
      Get.updateLocale(
        Locale(localeParts[0], localeParts.length > 1 ? localeParts[1] : null),
      );
    }

    // Load color
    int? colorInt = prefs.getInt('primaryColor');
    if (colorInt != null) {
      primaryColor.value = Color(colorInt);
    }
  }

  void setThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.toString());
  }

  void setLanguage(String langCode) async {
    language.value = langCode;
    var localeParts = langCode.split('_');
    Get.updateLocale(
      Locale(localeParts[0], localeParts.length > 1 ? localeParts[1] : null),
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', langCode);
  }

  void setPrimaryColor(Color color) async {
    primaryColor.value = color;
    // We cannot dynamically update the whole app ThemeData globally without rebuilding GetMaterialApp.
    // However, since we'll wrap our screens in Obx or listen to primaryColor, it can react.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('primaryColor', color.value);
  }
}
