import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:client/utils/constants/sizes.dart';
import 'package:client/utils/constants/colors.dart';
import 'package:client/features/personalization/models/judgment_model.dart';

class JudgmentDetailSheet {
  static void show(BuildContext context, JudgmentModel judgment) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: TSizes.md),
                      decoration: BoxDecoration(
                        color: TColors.darkGrey,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Số bản án
                  Row(
                    children: [
                      Icon(Iconsax.judge, color: theme.primaryColor),
                      const SizedBox(width: TSizes.sm),
                      Expanded(
                        child: Text(
                          judgment.soBanAn,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (judgment.ngayTuyen.isNotEmpty) ...[
                    const SizedBox(height: TSizes.xs),
                    Text(
                      'Ngày tuyên: ${judgment.ngayTuyen}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: TColors.darkGrey,
                      ),
                    ),
                  ],
                  const SizedBox(height: TSizes.md),
                  const Divider(),
                  const SizedBox(height: TSizes.md),

                  _detailSection(theme, 'Tội danh', judgment.toiDanh),
                  _detailSection(theme, 'Hành vi', judgment.hanhVi),
                  _detailSection(theme, 'Hình phạt', judgment.hinhPhat),
                  _detailSection(theme, 'Điều luật áp dụng', judgment.dieuLuat),

                  if (judgment.anTreo) ...[
                    const SizedBox(height: TSizes.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: TColors.warning.withAlpha((0.15 * 255).toInt()),
                        borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Iconsax.info_circle,
                            size: 16,
                            color: TColors.warning,
                          ),
                          const SizedBox(width: TSizes.xs),
                          Text(
                            'Được hưởng án treo',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: TColors.warning,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Widget _detailSection(ThemeData theme, String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: TSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: TColors.darkGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: TSizes.xs),
          Text(value, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
