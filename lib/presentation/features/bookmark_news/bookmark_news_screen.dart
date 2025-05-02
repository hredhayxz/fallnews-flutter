import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/constant/app_strings.dart';
import 'package:fallnews/core/di/dependency_injection_service.dart';
import 'package:fallnews/core/routes/app_routes.dart';
import 'package:fallnews/data/models/news_data_model.dart';
import 'package:fallnews/presentation/features/bookmark_news/bloc/bookmark_bloc.dart';
import 'package:fallnews/presentation/features/bookmark_news/bloc/bookmark_event.dart';
import 'package:fallnews/presentation/features/bookmark_news/bloc/bookmark_state.dart';
import 'package:fallnews/presentation/features/bookmark_news/repo/bookmark_repo.dart';
import 'package:fallnews/presentation/features/bookmark_news/widgets/bookmark_news_list_item.dart';
import 'package:fallnews/presentation/features/bookmark_news/widgets/shimmers/bookmark_shimmer_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkNewsScreen extends StatelessWidget {
  const BookmarkNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if user is authenticated
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(AppStrings.bookmarkedNews)),
        body: _buildSignInPrompt(context: context),
      );
    }

    return BlocProvider(
      create:
          (context) =>
              BookmarkBloc(sl.get<BookmarkRepository>())
                ..add(FetchBookmarksEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.bookmarkedNews)),
        body: _buildBookmarkContent(context: context),
      ),
    );
  }

  Widget _buildBookmarkContent({required BuildContext context}) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<BookmarkBloc>().add(FetchBookmarksEvent());
      },
      child: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkLoading) {
            return const BookmarkShimmerLoading();
          } else if (state is BookmarkLoaded) {
            if (state.bookmarks.isEmpty) {
              return _buildNoBookmarkFound(context: context);
            }
            return _buildBookmarkNewsList(
              context: context,
              bookmarks: state.bookmarks,
            );
          } else if (state is BookmarkError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: AppDimens.h16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<BookmarkBloc>().add(FetchBookmarksEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return _buildNoBookmarkFound(context: context);
        },
      ),
    );
  }

  Widget _buildBookmarkNewsList({
    required BuildContext context,
    required List<Articles> bookmarks,
  }) {
    return ListView.separated(
      padding: EdgeInsets.all(AppDimens.r16),
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: bookmarks.length,
      separatorBuilder:
          (_, __) => Divider(
            height: AppDimens.h24,
            color: Theme.of(context).dividerColor,
          ),
      itemBuilder: (_, index) {
        final article = bookmarks[index];
        return BookmarkNewsListItem(
          onRemove: () {
            context.read<BookmarkBloc>().add(RemoveBookmarkEvent('111'));
          },
          onTap: () {
            // Navigate to article details screen
            Navigator.pushNamed(context, AppRoutes.details, arguments: article);
          },
          article: article,
        );
      },
    );
  }

  Widget _buildNoBookmarkFound({required BuildContext context}) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: AppDimens.w64,
              color: theme.disabledColor,
            ),
            SizedBox(height: AppDimens.h16),
            Text(
              AppStrings.noBookmarks,
              style: textTheme.titleMedium?.copyWith(
                color: theme.disabledColor,
              ),
            ),
            SizedBox(height: AppDimens.h8),
            Text(
              'Save news articles to read later',
              style: textTheme.bodyMedium?.copyWith(color: theme.disabledColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInPrompt({required BuildContext context}) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: AppDimens.w64, color: theme.disabledColor),
            SizedBox(height: AppDimens.h16),
            Text(
              'Sign in required',
              style: textTheme.titleMedium?.copyWith(
                color: theme.disabledColor,
              ),
            ),
            SizedBox(height: AppDimens.h8),
            Text(
              'Please sign in to view your bookmarks',
              style: textTheme.bodyMedium?.copyWith(color: theme.disabledColor),
            ),
            SizedBox(height: AppDimens.h16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.login);
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
