// import 'package:fallnews/core/constant/app_colors.dart';
// import 'package:fallnews/core/constant/app_dimens.dart';
// import 'package:fallnews/core/constant/app_strings.dart';
// import 'package:fallnews/core/routes/app_routes.dart';
// import 'package:fallnews/presentation/features/news_home/widgets/home_news_card.dart';
// import 'package:fallnews/presentation/features/news_home/widgets/shimmers/home_shimmer_loading.dart';
// import 'package:flutter/material.dart';
//
// class NewsHomeScreen extends StatefulWidget {
//   const NewsHomeScreen({super.key});
//
//   @override
//   State<NewsHomeScreen> createState() => _NewsHomeScreenState();
// }
//
// class _NewsHomeScreenState extends State<NewsHomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           AppStrings.latestNews,
//           style: textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//           ), // Using textTheme
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.bookmark,
//               size: AppDimens.w24,
//               color: AppColors.primary,
//             ),
//             onPressed:
//                 () => Navigator.pushNamed(context, AppRoutes.bookmarkNews),
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.settings,
//               size: AppDimens.w24,
//               color: AppColors.primary,
//             ),
//             onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
//           ),
//         ],
//       ),
//       body: HomeShimmerLoading(),
//       //_buildNewsList(),
//     );
//   }
//
//   Widget _buildNewsList() {
//     return RefreshIndicator(
//       onRefresh: () async {},
//       child: ListView.separated(
//         padding: EdgeInsets.all(AppDimens.r16),
//         physics: const AlwaysScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: 10,
//         separatorBuilder: (_, __) => SizedBox(height: AppDimens.r16),
//         itemBuilder: (_, index) {
//           return HomeNewsCard(news: null,);
//         },
//       ),
//     );
//   }
// }
//
//
//
//

// UI - NewsHomeScreen with Bloc Integration and Pagination
import 'package:fallnews/core/constant/app_colors.dart';
import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/constant/app_strings.dart';
import 'package:fallnews/core/routes/app_routes.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_bloc.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_event.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_state.dart';
import 'package:fallnews/presentation/features/news_home/widgets/home_news_card.dart';
import 'package:fallnews/presentation/features/news_home/widgets/shimmers/home_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({super.key});

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchNews();
    _scrollController.addListener(_onScroll);
  }

  void _fetchNews() {
    context.read<NewsBloc>().add(FetchNewsEvent());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      final state = context.read<NewsBloc>().state;
      if (state is NewsLoaded && !state.hasReachedMax) {
        _fetchNews();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.latestNews,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const HomeShimmerLoading();
          } else if (state is NewsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<NewsBloc>().add(FetchNewsEvent(isRefresh: true));
              },
              child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.all(AppDimens.r16),
                itemCount: state.articles.length + 1,
                separatorBuilder: (_, __) => SizedBox(height: AppDimens.r16),
                itemBuilder: (_, index) {
                  if (index < state.articles.length) {
                    return HomeNewsCard(news: state.articles[index]);
                  } else {
                    return state.hasReachedMax
                        ? const SizedBox.shrink()
                        : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(child: CircularProgressIndicator()),
                        );
                  }
                },
              ),
            );
          } else if (state is NewsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No news found.'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
