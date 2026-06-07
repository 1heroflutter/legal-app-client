import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:client/utils/constants/sizes.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
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
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TSizes.defaultSpace,
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: TSizes.spaceBtwItems,
            runSpacing: TSizes.spaceBtwItems,
            children: [
              _buildCategory(context, Iconsax.car, 'traffic_law'.tr),
              _buildCategory(context, Iconsax.judge, 'criminal_law'.tr),
              _buildCategory(context, Iconsax.home, 'civil_law'.tr),
              _buildCategory(context, Iconsax.building, 'business_law'.tr),
            ],
          ),
        ),
      ],
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
}
