import 'package:flutter/material.dart';
import 'package:client/utils/constants/sizes.dart';
import 'package:client/utils/constants/colors.dart';

class JudgmentSkeleton extends StatelessWidget {
  const JudgmentSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(TSizes.md),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? TColors.darkContainer
            : TColors.lightContainer,
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _skeletonBox(context, 160, 14),
          const SizedBox(height: TSizes.sm),
          _skeletonBox(context, double.infinity, 16),
          const SizedBox(height: TSizes.xs),
          _skeletonBox(context, double.infinity, 12),
          const SizedBox(height: TSizes.sm),
          Row(
            children: [
              _skeletonBox(context, 100, 20),
              const SizedBox(width: TSizes.sm),
              _skeletonBox(context, 120, 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _skeletonBox(BuildContext context, double width, double height) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? Colors.white10
            : TColors.grey.withAlpha((0.5 * 255).toInt()),
        borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
      ),
    );
  }
}
