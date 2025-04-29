import 'package:fallnews/core/constant/app_colors.dart';
import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/constant/app_strings.dart';
import 'package:fallnews/core/routes/app_routes.dart';
import 'package:fallnews/presentation/features/news_home/widgets/home_news_card.dart';
import 'package:fallnews/presentation/features/news_home/widgets/shimmers/home_shimmer_loading.dart';
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
            onPressed:
                () => Navigator.pushNamed(context, AppRoutes.bookmarkNews),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              size: AppDimens.w24,
              color: AppColors.primary,
            ),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
          ),
        ],
      ),
      body: HomeShimmerLoading(),
      //_buildNewsList(),
    );
  }

  Widget _buildNewsList() {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.separated(
        padding: EdgeInsets.all(AppDimens.r16),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        separatorBuilder: (_, __) => SizedBox(height: AppDimens.r16),
        itemBuilder: (_, index) {
          return HomeNewsCard();
        },
      ),
    );
  }
}
