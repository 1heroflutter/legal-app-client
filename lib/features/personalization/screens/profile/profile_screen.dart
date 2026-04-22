import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:client/utils/constants/sizes.dart';
import 'package:client/utils/constants/colors.dart';
import 'package:client/data/repositories/authentication/authentication_repository.dart';
import 'package:client/features/personalization/controllers/settings_controller.dart';
import 'package:client/features/authentication/screens/login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsController = Get.find<SettingsController>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'profile'.tr,
          style: theme.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Card
            _buildUserCard(theme),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Settings
            Text('settings'.tr, style: theme.textTheme.titleLarge),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Theme setting
            Obx(
              () => _buildSettingTile(
                context,
                icon: Iconsax.moon,
                title: 'theme'.tr,
                trailing: DropdownButton<ThemeMode>(
                  value: settingsController.themeMode.value,
                  onChanged: (ThemeMode? newValue) {
                    if (newValue != null)
                      settingsController.setThemeMode(newValue);
                  },
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('system_mode'.tr),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('light_mode'.tr),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('dark_mode'.tr),
                    ),
                  ],
                ),
              ),
            ),

            // Language setting
            Obx(
              () => _buildSettingTile(
                context,
                icon: Iconsax.language_square,
                title: 'language'.tr,
                trailing: DropdownButton<String>(
                  value: settingsController.language.value,
                  onChanged: (String? newValue) {
                    if (newValue != null)
                      settingsController.setLanguage(newValue);
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'vi_VN',
                      child: Text('vietnamese'.tr),
                    ),
                    DropdownMenuItem(value: 'en_US', child: Text('english'.tr)),
                  ],
                ),
              ),
            ),

            // Primary Color setting
            _buildSettingTile(
              context,
              icon: Iconsax.color_swatch,
              title: 'primary_color'.tr,
              trailing: Obx(
                () => Row(
                  children: [
                    _colorOption(
                      settingsController,
                      theme,
                      const Color(0xFF1877F2),
                    ), // Blue
                    _colorOption(
                      settingsController,
                      theme,
                      const Color(0xFF4CAF50),
                    ), // Green
                    _colorOption(
                      settingsController,
                      theme,
                      const Color(0xFFE91E63),
                    ), // Pink
                    _colorOption(
                      settingsController,
                      theme,
                      const Color(0xFFFF9800),
                    ), // Orange
                  ],
                ),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),
            // Utilities
            Text('Tiện ích', style: theme.textTheme.titleLarge),
            const SizedBox(height: TSizes.spaceBtwItems),

            _buildSettingTile(
              context,
              icon: Iconsax.document_text,
              title: 'terms'.tr,
              showArrow: true,
            ),
            _buildSettingTile(
              context,
              icon: Iconsax.security,
              title: 'privacy'.tr,
              showArrow: true,
            ),
            _buildSettingTile(
              context,
              icon: Iconsax.info_circle,
              title: 'version'.tr,
              trailing: Text('1.0.0', style: theme.textTheme.labelMedium),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Logout
            SizedBox(
              width: double.infinity,
              child: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.error,
                        side: const BorderSide(color: TColors.error),
                      ),
                      onPressed: () =>
                          AuthenticationRepository.instance.logout(),
                      child: Text(
                        'logout'.tr,
                        style: const TextStyle(color: TColors.white),
                      ),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () => Get.to(() => const LoginScreen()),
                    child: Text('login'.tr),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(ThemeData theme) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        return Container(
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: theme.primaryColor.withAlpha((0.1 * 255).toInt()),
            borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: theme.primaryColor,
                child: Text(
                  user?.email?[0].toUpperCase() ?? 'K',
                  style: const TextStyle(
                    color: TColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user != null ? (user.displayName ?? 'User') : 'guest'.tr,
                      style: theme.textTheme.headlineSmall,
                    ),
                    Text(
                      user?.email ?? 'Chưa đăng nhập',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _colorOption(
    SettingsController controller,
    ThemeData theme,
    Color color,
  ) {
    bool isSelected = controller.primaryColor.value.value == color.value;
    return GestureDetector(
      onTap: () => controller.setPrimaryColor(color),
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? theme.iconTheme.color! : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    bool showArrow = false,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Row(
        children: [
          Icon(icon, color: theme.iconTheme.color),
          const SizedBox(width: TSizes.spaceBtwItems),
          Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
          if (trailing != null) trailing,
          if (showArrow)
            Icon(Iconsax.arrow_right_3, size: 18, color: theme.iconTheme.color),
        ],
      ),
    );
  }
}
