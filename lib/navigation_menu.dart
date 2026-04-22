import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:client/features/consultation/screens/chat_screen.dart';
import 'package:client/features/personalization/screens/home/home_screen.dart';
import 'package:client/features/personalization/screens/profile/profile_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: theme.scaffoldBackgroundColor,
          indicatorColor: theme.primaryColor.withAlpha((0.1 * 255).toInt()),
          destinations: [
            NavigationDestination(
              icon: const Icon(Iconsax.home),
              label: 'home'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Iconsax.message_question),
              label: 'consultation'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Iconsax.user),
              label: 'profile'.tr,
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];
}
