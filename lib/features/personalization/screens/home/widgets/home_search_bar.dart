import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:client/utils/constants/sizes.dart';
import 'package:client/utils/constants/colors.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
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
                onTapOutside: (event) => FocusScope.of(context).dispose(),
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
    );
  }
}
