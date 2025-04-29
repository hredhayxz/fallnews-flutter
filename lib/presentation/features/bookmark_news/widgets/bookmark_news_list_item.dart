import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/utils/wrapper_utils.dart';
import 'package:flutter/material.dart';

class BookmarkNewsListItem extends StatelessWidget {
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const BookmarkNewsListItem({
    super.key,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.r12),
      child: Container(
        padding: EdgeInsets.all(AppDimens.w8),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(AppDimens.r12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.r8),
              child: WrapperUtils.cachedImage(
                imageUrl:
                    'https://cdn.bhdw.net/im/error-wallpaper-29852_w635.webp',
                width: AppDimens.w96,
                height: AppDimens.h96,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: AppDimens.w12),
            // News content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'News Title',
                    style: textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppDimens.h8),
                  Row(
                    spacing: AppDimens.w8,
                    children: [
                      Text(
                        "news.source",
                        style: textTheme.bodySmall?.copyWith(
                          color: textTheme.bodySmall?.color?.withOpacity(0.7),
                        ),
                      ),
                      Icon(
                        Icons.circle,
                        size: AppDimens.w4,
                        color: textTheme.bodySmall?.color?.withOpacity(0.5),
                      ),
                      Text(
                        "news.date",
                        style: textTheme.bodySmall?.copyWith(
                          color: textTheme.bodySmall?.color?.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Bookmark button
            IconButton(
              icon: Icon(Icons.bookmark, color: theme.colorScheme.primary),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
