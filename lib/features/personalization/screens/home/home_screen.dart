import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:client/utils/constants/sizes.dart';
import 'package:client/utils/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('welcome'.tr, style: theme.textTheme.labelMedium),
            Text(
              'Tư vấn Pháp luật',
              style: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.notification)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? TColors.darkContainer
                      : TColors.lightContainer,
                  borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.search_normal, color: theme.iconTheme.color),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'search_hint'.tr,
                          hintStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: TColors.darkGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('categories'.tr, style: theme.textTheme.titleLarge),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'read_more'.tr,
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Category items
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategory(context, Iconsax.car, 'traffic_law'.tr),
                  _buildCategory(context, Iconsax.judge, 'criminal_law'.tr),
                  _buildCategory(context, Iconsax.home, 'civil_law'.tr),
                  _buildCategory(context, Iconsax.building, 'business_law'.tr),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Banner
            Container(
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
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Highlight News
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'highlight_news'.tr,
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildNewsCard(
              context,
              'Luật Giao thông mới 2024 có gì nổi bật?',
              'Cập nhật những thay đổi quan trọng về nồng độ cồn và tốc độ tối đa.',
            ),
            _buildNewsCard(
              context,
              'Hướng dẫn tra cứu phạt nguội 2024',
              'Cách tra cứu phạt nguội nhanh chóng và chính xác nhất trên toàn quốc.',
            ),

            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: theme.primaryColor.withAlpha((0.1 * 255).toInt()),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: theme.primaryColor),
        ),
        const SizedBox(height: TSizes.sm),
        SizedBox(
          width: 70,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildNewsCard(BuildContext context, String title, String subtitle) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(
        left: TSizes.defaultSpace,
        right: TSizes.defaultSpace,
        bottom: TSizes.spaceBtwItems,
      ),
      padding: const EdgeInsets.all(TSizes.md),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? TColors.darkContainer
            : TColors.lightContainer,
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: TColors.darkGrey.withAlpha((0.2 * 255).toInt()),
              borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
            ),
            child: const Icon(Iconsax.book, color: TColors.darkGrey),
          ),
          const SizedBox(width: TSizes.spaceBtwItems),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: TSizes.xs),
                Text(
                  subtitle,
                  style: theme.textTheme.labelMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
