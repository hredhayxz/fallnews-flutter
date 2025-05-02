import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/di/dependency_injection_service.dart';
import 'package:fallnews/core/routes/app_routes.dart';
import 'package:fallnews/core/utils/date_utils.dart';
import 'package:fallnews/core/utils/wrapper_utils.dart';
import 'package:fallnews/data/models/news_data_model.dart';
import 'package:fallnews/presentation/features/bookmark_news/bloc/bookmark_bloc.dart';
import 'package:fallnews/presentation/features/bookmark_news/bloc/bookmark_event.dart';
import 'package:fallnews/presentation/features/bookmark_news/bloc/bookmark_state.dart';
import 'package:fallnews/presentation/features/bookmark_news/repo/bookmark_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsDetailScreen extends StatefulWidget {
  final Articles news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              BookmarkBloc(sl.get<BookmarkRepository>())
                ..add(FetchBookmarksEvent()),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: AppDimens.h300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: 'news-image-${widget.news.urlToImage}',
                  child: WrapperUtils.cachedImage(
                    imageUrl: widget.news.urlToImage ?? '',
                    width: double.infinity,
                    height: AppDimens.h300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              actions: [
                BlocBuilder<BookmarkBloc, BookmarkState>(
                  builder: (context, state) {
                    print('widget.news.idwidget.news.id ${widget.news.id}');
                    bool isBookmarked =
                        state is BookmarkLoaded &&
                        state.bookmarks.any((a) => a.id == widget.news.id);
                    print('isBookmarkedisBookmarkedisBookmarked ${isBookmarked}');
                    return IconButton(
                      icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please sign in to bookmark articles',
                              ),
                            ),
                          );
                          Navigator.pushNamed(context, AppRoutes.login);
                          return;
                        }
                        if (isBookmarked) {
                          context.read<BookmarkBloc>().add(
                            RemoveBookmarkEvent(widget.news.id!),
                          );
                        } else {
                          context.read<BookmarkBloc>().add(
                            AddBookmarkEvent(widget.news),
                          );
                        }
                      },
                    );
                  },
                ),
                // IconButton(
                //   icon: Icon(Icons.share, color: Theme.of(context).colorScheme.primary),
                //   onPressed: () {},
                // ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.w16,
                  vertical: AppDimens.h24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.news.title ?? '',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: AppDimens.h16),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: AppDimens.r20,
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          child: Text(
                            widget.news.source?.name?[0] ?? '',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        SizedBox(width: AppDimens.w12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.news.source?.name ?? '',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              DateUtilsHelper.formatPublishedDate(
                                widget.news.publishedAt ?? '',
                              ),
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color?.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimens.h24),
                    Text(
                      widget.news.content ?? '',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(height: 1.6),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
