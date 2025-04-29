import 'package:intl/intl.dart';

class DateUtilsHelper {
  DateUtilsHelper._();

  static String formatPublishedDate(String? publishedAt) {
    if (publishedAt == null || publishedAt.isEmpty) {
      return 'Unknown date';
    }

    try {
      final DateTime dateTime = DateTime.parse(publishedAt).toLocal();
      final Duration difference = DateTime.now().difference(dateTime);

      if (difference.inSeconds < 60) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else {
        return DateFormat('yyyy-MM-dd').format(dateTime);
      }
    } catch (e) {
      return 'Invalid date';
    }
  }
}
