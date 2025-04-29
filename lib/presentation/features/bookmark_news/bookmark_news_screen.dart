import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/constant/app_strings.dart';
import 'package:fallnews/presentation/features/bookmark_news/widgets/bookmark_news_list_item.dart';
import 'package:flutter/material.dart';

class BookmarkNewsScreen extends StatelessWidget {
  const BookmarkNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.bookmarkedNews)),
      body: _buildBookmarkNewsList(context: context),
    );
  }

  Widget _buildBookmarkNewsList({required BuildContext context}) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.separated(
        padding: EdgeInsets.all(AppDimens.r16),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        separatorBuilder:
            (_, __) => Divider(
              height: AppDimens.h24,
              color: Theme.of(context).dividerColor,
            ),
        itemBuilder: (_, index) {
          return BookmarkNewsListItem(onRemove: () {}, onTap: () {});
        },
      ),
    );
  }
}
