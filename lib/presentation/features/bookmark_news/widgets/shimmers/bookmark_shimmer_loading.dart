import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/utils/wrapper_utils.dart';
import 'package:flutter/material.dart';

class BookmarkShimmerLoading extends StatelessWidget {
  const BookmarkShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(AppDimens.r16),
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (_, __) => SizedBox(height: AppDimens.r16),
      itemBuilder: (_, index) {
        return WrapperUtils.shimmer(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          height: AppDimens.h110,
          radius: AppDimens.r12,
        );
      },
    );
  }
}
