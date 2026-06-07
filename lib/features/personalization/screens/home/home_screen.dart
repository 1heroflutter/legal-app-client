import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:client/utils/constants/sizes.dart';
import 'package:client/utils/constants/colors.dart';
import 'package:client/utils/device/responsive_widget.dart';

import 'package:client/features/personalization/controllers/home_controller.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/home_categories.dart';
import 'widgets/home_promo_banner.dart';
import 'widgets/judgment_card.dart';
import 'widgets/judgment_skeleton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const HomeAppBar(),
      body: RefreshIndicator(
        onRefresh: controller.fetchRandomJudgments,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  const HomeSearchBar(),
                  const HomeCategories(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const HomePromoBanner(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Recommended Judgments Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'recent_judgments'.tr,
                          style: theme.textTheme.titleLarge,
                        ),
                        IconButton(
                          onPressed: controller.fetchRandomJudgments,
                          icon: Icon(Iconsax.refresh, color: theme.primaryColor),
                          tooltip: 'Tải lại',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // Judgment Cards
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                        child: ResponsiveWidget(
                          mobile: Column(
                            children: List.generate(
                              3,
                              (_) => const Padding(
                                padding: EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                                child: JudgmentSkeleton(),
                              ),
                            ),
                          ),
                          tablet: _buildGridSkeleton(2),
                          desktop: _buildGridSkeleton(3),
                        ),
                      );
                    }

                    if (controller.judgments.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Iconsax.document,
                                size: 48,
                                color: TColors.darkGrey,
                              ),
                              const SizedBox(height: TSizes.sm),
                              Text(
                                'Chưa có bản án nào trong hệ thống',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: TColors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                      child: ResponsiveWidget(
                        mobile: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.judgments.length,
                          itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                            child: JudgmentCard(judgment: controller.judgments[index]),
                          ),
                        ),
                        tablet: _buildGrid(controller, 2),
                        desktop: _buildGrid(controller, 3),
                      ),
                    );
                  }),

                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(HomeController controller, int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 240, // Fixed height to avoid overflow/clipping
        crossAxisSpacing: TSizes.spaceBtwItems,
        mainAxisSpacing: TSizes.spaceBtwItems,
      ),
      itemCount: controller.judgments.length,
      itemBuilder: (_, index) => JudgmentCard(judgment: controller.judgments[index]),
    );
  }

  Widget _buildGridSkeleton(int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 240,
        crossAxisSpacing: TSizes.spaceBtwItems,
        mainAxisSpacing: TSizes.spaceBtwItems,
      ),
      itemCount: 6,
      itemBuilder: (_, __) => const JudgmentSkeleton(),
    );
  }
}
