import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:client/navigation_menu.dart';
import 'package:client/utils/constants/colors.dart';
import 'package:client/data/repositories/authentication/authentication_repository.dart';
import 'package:client/features/personalization/controllers/settings_controller.dart';
import 'package:client/utils/translations/app_translations.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializing Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Load Settings Controller Async
  await SettingsController.init();

  // Initializing Authentication Repository
  Get.put(AuthenticationRepository());

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();

    return Obx(() {
      final primaryColor = settingsController.primaryColor.value;
      final languageParts = settingsController.language.value.split('_');
      final currentLocale = Locale(
        languageParts[0],
        languageParts.length > 1 ? languageParts[1] : null,
      );

      return GetMaterialApp(
        title: 'Tư vấn Pháp luật',
        translations: AppTranslations(),
        locale: currentLocale,
        fallbackLocale: const Locale('vi', 'VN'),
        themeMode: settingsController.themeMode.value,
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: primaryColor,
          scaffoldBackgroundColor: TColors.white,
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
            backgroundColor: TColors.white,
            surfaceTintColor: Colors.transparent,
            iconTheme: IconThemeData(color: TColors.black),
            titleTextStyle: TextStyle(
              color: TColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIconColor: primaryColor,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          primaryColor: primaryColor,
          scaffoldBackgroundColor: TColors.dark,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            backgroundColor: TColors.dark,
            surfaceTintColor: Colors.transparent,
            iconTheme: IconThemeData(color: TColors.white),
            titleTextStyle: TextStyle(
              color: TColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIconColor: primaryColor,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
            brightness: Brightness.dark,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const NavigationMenu(),
      );
    });
  }
}
