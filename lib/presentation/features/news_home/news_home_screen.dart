import 'package:fallnews/core/constant/app_colors.dart';
import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/constant/app_strings.dart';
import 'package:fallnews/core/routes/app_routes.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_bloc.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_event.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_state.dart';
import 'package:fallnews/presentation/features/news_home/widgets/home_news_card.dart';
import 'package:fallnews/presentation/features/news_home/widgets/shimmers/home_shimmer_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({super.key});

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _fetchNews(isRefresh: true);
    _scrollController.addListener(_onScroll);
  }

  void _fetchNews({bool isRefresh = false}) {
    if (isRefresh) {
      _currentPage = 1;
    }
    context.read<NewsBloc>().add(
      FetchNewsEvent(page: _currentPage, isRefresh: isRefresh),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _currentPage++;
      _fetchNews();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
            onPressed: () {
              if (user == null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Please sign in')));
                Navigator.pushNamed(context, AppRoutes.login);
                return;
              } else {
                Navigator.pushNamed(context, AppRoutes.bookmarkNews);
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              size: AppDimens.w24,
              color: AppColors.primary,
            ),
            onPressed: () {
              if (user == null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Please sign in')));
                Navigator.pushNamed(context, AppRoutes.login);
                return;
              } else {
                Navigator.pushNamed(context, AppRoutes.settings);
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading && state.articles.isEmpty) {
            return const HomeShimmerLoading();
          } else if (state is NewsLoaded ||
              (state is NewsLoading && state.articles.isNotEmpty)) {
            final articles = state.articles;
            return RefreshIndicator(
              onRefresh: () async {
                _fetchNews(isRefresh: true);
              },
              child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.all(AppDimens.r16),
                itemCount: articles.length + 1,
                // Always show loading indicator
                separatorBuilder: (_, __) => SizedBox(height: AppDimens.r16),
                itemBuilder: (_, index) {
                  if (index < articles.length) {
                    return HomeNewsCard(news: articles[index]);
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            );
          } else if (state is NewsError) {
            return RefreshIndicator(
              onRefresh: () async {
                _fetchNews(isRefresh: true);
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(AppDimens.r16),
                  child: Center(child: Text('Error: ${state.message}')),
                ),
              ),
            );
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
