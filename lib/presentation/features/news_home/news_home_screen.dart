import 'package:fallnews/core/constant/app_colors.dart';
import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/constant/app_strings.dart';
import 'package:fallnews/core/utils/wrapper_utils.dart';
import 'package:flutter/material.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({super.key});

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.latestNews,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ), // Using textTheme
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.bookmark,
              size: AppDimens.w24,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              size: AppDimens.w24,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(AppDimens.r16),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        separatorBuilder: (_, __) => SizedBox(height: AppDimens.r16),
        itemBuilder: (_, index) {
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
                      imageUrl: '',
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
                          'New Healthcare Bill Passed',
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
                              'Kalbela',
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
                              '45m ago',
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
        },
      ),
    );
  }
}
