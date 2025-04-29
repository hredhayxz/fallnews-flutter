import 'package:fallnews/core/constant/app_colors.dart';
import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/utils/date_utils.dart';
import 'package:fallnews/core/utils/wrapper_utils.dart';
import 'package:fallnews/presentation/features/news_home/data/models/news_data_model.dart';
import 'package:flutter/material.dart';

class HomeNewsCard extends StatelessWidget {
  const HomeNewsCard({super.key, required this.news});

  final Articles news;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimens.r12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              blurRadius: AppDimens.h8,
              offset: Offset(0, AppDimens.h2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDimens.r12),
              ),
              child: WrapperUtils.cachedImage(
                imageUrl: news.urlToImage ?? '',
                width: double.infinity,
                height: AppDimens.h128,
                fit: BoxFit.cover,
              ),
            ),
            // Content
            Padding(
              padding: AppDimens.paddingMedium,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title ?? '',
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: AppDimens.sp16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  SizedBox(height: AppDimens.h8),
                  Row(
                    children: [
                      Text(
                        news.source?.name ?? '',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: AppDimens.sp12,
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(width: AppDimens.w16),
                      Icon(
                        Icons.access_time,
                        size: AppDimens.sp14,
                        color: AppColors.grey,
                      ),
                      SizedBox(width: AppDimens.w4),
                      Text(
                        DateUtilsHelper.formatPublishedDate(
                          news.publishedAt ?? '',
                        ),
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: AppDimens.sp12,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
