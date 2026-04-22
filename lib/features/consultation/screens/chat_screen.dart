import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:client/utils/constants/colors.dart';
import 'package:client/utils/constants/sizes.dart';
import 'package:client/features/consultation/controllers/chat_controller.dart';
import 'package:client/features/consultation/screens/widgets/chat_bubble.dart';
import 'package:client/features/authentication/screens/login/login_screen.dart';
import 'package:client/data/repositories/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      floatingActionButton: Obx(
        () => controller.showScrollToBottomBtn.value
            ? FloatingActionButton(
                onPressed: controller.scrollToBottom,
                backgroundColor: theme.primaryColor,
                child: const Icon(Iconsax.arrow_down, color: TColors.white),
              )
            : const SizedBox.shrink(),
      ),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tư vấn Pháp luật',
              style: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: TSizes.xs),
                Text(
                  'Trực tuyến',
                  style: theme.textTheme.labelMedium!.copyWith(
                    color: TColors.darkGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        actions: [
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                  onPressed: () => _showProfileDialog(context),
                  icon: Icon(Iconsax.user, color: theme.primaryColor),
                );
              }
              return TextButton(
                onPressed: () => Get.to(() => const LoginScreen()),
                child: Text(
                  'login'.tr,
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: Obx(
              () => controller.messages.isEmpty && !controller.isLoading.value
                  ? _buildRecommendations(controller, theme)
                  : ListView.builder(
                      reverse: true,
                      controller: controller.scrollController,
                      itemCount: controller.messages.length + 1,
                      padding: const EdgeInsets.symmetric(vertical: TSizes.md),
                      itemBuilder: (context, index) {
                        if (index == controller.messages.length) {
                          return Obx(
                            () => controller.isLoadingMore.value
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(vertical: TSizes.md),
                                    child: SpinKitThreeBounce(
                                      color: theme.primaryColor,
                                      size: 20.0,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          );
                        }
                        
                        final message = controller.messages[index];
                        return ChatBubble(
                          message: message.text,
                          isMe: message.isMe,
                        );
                      },
                    ),
            ),
          ),

          // Loading Indicator
          Obx(
            () => controller.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.all(TSizes.sm),
                    child: SpinKitThreeBounce(
                      color: theme.primaryColor,
                      size: 20.0,
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Message Input
          _buildInputSection(controller, theme),
        ],
      ),
    );
  }

  Widget _buildInputSection(ChatController controller, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.md,
        vertical: TSizes.sm,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: TColors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? TColors.darkContainer
                      : TColors.lightContainer,
                  borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                ),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller.messageController,
                  builder: (context, value, child) {
                    return TextField(
                      controller: controller.messageController,
                      decoration: InputDecoration(
                        hintText: 'type_message'.tr,
                        border: InputBorder.none,
                        hintStyle: const TextStyle(color: TColors.darkGrey),
                        suffixIcon: value.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Iconsax.close_circle,
                                  color: TColors.darkGrey,
                                ),
                                onPressed: () {
                                  controller.messageController.clear();
                                },
                              )
                            : null,
                      ),
                      onSubmitted: (_) => controller.sendMessage(),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: TSizes.sm),
            Container(
              decoration: BoxDecoration(
                color: theme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => controller.sendMessage(),
                icon: const Icon(Iconsax.send_1, color: TColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendations(ChatController controller, ThemeData theme) {
    final recommendations = [
      'Nồng độ cồn phạt bao nhiêu?',
      'Lỗi vượt đèn đỏ xe máy?',
      'Thủ tục đăng ký xe online?',
      'Mức án cho tội gây tai nạn?',
    ];

    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.message_question, size: 64, color: theme.primaryColor),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(
            'start_chat'.tr,
            style: Get.textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: TSizes.sm),
          const Text(
            'Chọn một câu hỏi gợi ý bên dưới hoặc tự nhập câu hỏi của riêng bạn.',
            textAlign: TextAlign.center,
            style: TextStyle(color: TColors.darkGrey),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          Wrap(
            spacing: TSizes.sm,
            runSpacing: TSizes.sm,
            children: recommendations.map((text) {
              return ActionChip(
                label: Text(text),
                onPressed: () {
                  controller.messageController.text = text;
                  controller.sendMessage();
                },
                backgroundColor: theme.brightness == Brightness.dark
                    ? TColors.darkContainer
                    : TColors.lightContainer,
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    )));
  }

  void _showProfileDialog(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    Get.dialog(
      AlertDialog(
        title: const Text('Thông tin cá nhân'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: TColors.primary,
              child: Text(
                user?.email?[0].toUpperCase() ?? 'U',
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const SizedBox(height: TSizes.sm),
            Text(user?.email ?? 'Không có email'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Đóng')),
          ElevatedButton(
            onPressed: () {
              AuthenticationRepository.instance.logout();
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: TColors.error),
            child: const Text(
              'Đăng xuất',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
