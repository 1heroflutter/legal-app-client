import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:client/utils/constants/sizes.dart';
import 'package:client/utils/constants/colors.dart';
import 'package:client/features/personalization/models/judgment_model.dart';
import 'judgment_detail_sheet.dart';

class JudgmentCard extends StatelessWidget {
  final JudgmentModel judgment;

  const JudgmentCard({
    super.key,
    required this.judgment,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? TColors.darkContainer
            : TColors.lightContainer,
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? Colors.white10
              : TColors.borderSecondary,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        child: InkWell(
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          onTap: () => JudgmentDetailSheet.show(context, judgment),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Số bản án + Badge
                Row(
                  children: [
                    Icon(Iconsax.judge, size: 18, color: theme.primaryColor),
                    const SizedBox(width: TSizes.sm),
                    Expanded(
                      child: Text(
                        judgment.soBanAn,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    if (judgment.anTreo)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: TColors.warning.withAlpha((0.15 * 255).toInt()),
                          borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
                        ),
                        child: Text(
                          'Án treo',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: TColors.warning,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: TSizes.sm),

                // Tội danh
                if (judgment.toiDanh.isNotEmpty)
                  Text(
                    judgment.toiDanh,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: TSizes.xs),

                // Hành vi (tóm tắt)
                if (judgment.hanhVi.isNotEmpty)
                  Text(
                    judgment.hanhVi,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: TColors.darkGrey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: TSizes.sm),

                // Footer: Hình phạt + Điều luật
                Wrap(
                  spacing: TSizes.sm,
                  runSpacing: TSizes.xs,
                  children: [
                    if (judgment.hinhPhat.isNotEmpty)
                      _buildInfoChip(
                        context,
                        Iconsax.shield_tick,
                        judgment.hinhPhat,
                        TColors.error,
                      ),
                    if (judgment.dieuLuat.isNotEmpty)
                      _buildInfoChip(
                        context,
                        Iconsax.book_1,
                        judgment.dieuLuat,
                        TColors.info,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context,
    IconData icon,
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
