import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/utils/date_utils.dart';
import 'package:fallnews/core/utils/wrapper_utils.dart';
import 'package:fallnews/data/models/news_data_model.dart';
import 'package:flutter/material.dart';

class NewsDetailScreen extends StatefulWidget {
  final Articles news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
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
              IconButton(
                icon: Icon(Icons.bookmark, color: colorScheme.primary),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.share, color: colorScheme.primary),
                onPressed: () {},
              ),
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
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppDimens.h16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: AppDimens.r20,
                        backgroundColor: colorScheme.primaryContainer,
                        child: Text(
                          widget.news.source?.name ?? '',
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      SizedBox(width: AppDimens.w12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.news.source?.name ?? '',
                            style: textTheme.titleSmall,
                          ),
                          Text(
                            DateUtilsHelper.formatPublishedDate(
                              widget.news.publishedAt ?? '',
                            ),
                            style: textTheme.bodySmall?.copyWith(
                              color: textTheme.bodySmall?.color?.withOpacity(
                                0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimens.h24),
                  Text(
                    widget.news.content ?? '',
                    style: textTheme.bodyLarge?.copyWith(height: 1.6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.arrow_upward),
      ),
    );
  }
}
