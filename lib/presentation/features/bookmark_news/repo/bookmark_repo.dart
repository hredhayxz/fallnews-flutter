import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fallnews/data/models/news_data_model.dart';

class BookmarkRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  BookmarkRepository(this._auth, this._firestore);

  Future<Either<String, void>> addBookmark(Articles article) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('objectUser not authenticated');
        return Left('User not authenticated');
      }

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('bookmarks')
          .doc(article.id)
          .set(article.toJson());

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> removeBookmark(String articleId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return Left('User not authenticated');

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('bookmarks')
          .doc(articleId)
          .delete();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Articles>>> getBookmarks() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return Left('User not authenticated');

      final snapshot =
          await _firestore
              .collection('users')
              .doc(user.uid)
              .collection('bookmarks')
              .get();
      final bookmarks =
          snapshot.docs
              .map((doc) => Articles.fromFirestore(doc.data()))
              .toList();
      return Right(bookmarks);
    } catch (e) {
      print('objectUser getBookmarks error: $e');
      return Left(e.toString());
    }
  }
}
