import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:client/utils/constants/sizes.dart';

class HomePromoBanner extends StatelessWidget {
  const HomePromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
      ),
      padding: const EdgeInsets.all(TSizes.md),
      decoration: BoxDecoration(
        color: theme.primaryColor.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        border: Border.all(
          color: theme.primaryColor.withAlpha((0.3 * 255).toInt()),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'start_chat'.tr,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: TSizes.sm),
                Text(
                  'Trợ lý AI sẵn sàng giải đáp 24/7',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Icon(
            Iconsax.message_notif,
            size: 48,
            color: theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
