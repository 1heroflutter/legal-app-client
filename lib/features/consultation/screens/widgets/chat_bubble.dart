import 'package:flutter/material.dart';
import 'package:client/utils/constants/colors.dart';
import 'package:client/utils/constants/sizes.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  void _showContextMenu(BuildContext context, Offset tapPosition) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        tapPosition &
            const Size(
              40,
              40,
            ),
        Offset.zero & overlay.size,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
      ),
      color: isDark ? TColors.darkContainer : TColors.white,
      items: [
        PopupMenuItem(
          value: 'copy',
          child: Row(
            children: [
              Icon(Iconsax.copy, size: 18, color: isDark ? TColors.white : TColors.black),
              const SizedBox(width: TSizes.sm),
              Text('Sao chép', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'share',
          child: Row(
            children: [
              Icon(Iconsax.share, size: 18, color: isDark ? TColors.white : TColors.black),
              const SizedBox(width: TSizes.sm),
              Text('Chia sẻ', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
      elevation: 8,
    ).then((value) {
      if (value == 'copy') {
        Clipboard.setData(ClipboardData(text: message));
        Get.snackbar(
          'Đã sao chép',
          'Nội dung tin nhắn đã được lưu vào bộ nhớ tạm.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TColors.darkerGrey.withAlpha((0.9 * 255).toInt()),
          colorText: TColors.white,
          margin: const EdgeInsets.all(TSizes.md),
          duration: const Duration(seconds: 2),
        );
      } else if (value == 'share') {
        // Handle share logic here if needed
        Get.snackbar('Thông báo', 'Tính năng chia sẻ đang được phát triển');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Offset tapPosition = Offset.zero;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPressStart: (details) {
          tapPosition = details.globalPosition;
        },
        onLongPress: () => _showContextMenu(context, tapPosition),
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: TSizes.xs,
            horizontal: TSizes.md,
          ),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: isMe ? TColors.primary : TColors.softGrey,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(TSizes.borderRadiusLg),
              topRight: const Radius.circular(TSizes.borderRadiusLg),
              bottomLeft: Radius.circular(isMe ? TSizes.borderRadiusLg : 0),
              bottomRight: Radius.circular(isMe ? 0 : TSizes.borderRadiusLg),
            ),
            boxShadow: [
              if (isMe)
                BoxShadow(
                  color: TColors.primary.withAlpha((0.3 * 255).toInt()),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: SelectableText(
            message,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: isMe ? TColors.white : TColors.textPrimary,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}
