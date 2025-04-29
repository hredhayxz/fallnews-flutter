import 'package:fallnews/core/constant/app_strings.dart';
import 'package:flutter/material.dart';

class BookmarkNewsScreen extends StatelessWidget {
  const BookmarkNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.bookmarkedNews)),
      body: Center(child: Text('Bookmark')),
    );
  }
}
