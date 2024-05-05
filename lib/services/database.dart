import 'package:cinema_flutter/services/auth.dart';
import 'package:cinema_flutter/services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBService {
  static FirebaseFirestore store = FirebaseFirestore.instance;

  static Future<String?> addUser (
    String uid,
    String login,
    String fullname,
    String email,
  ) async {
    try {
      await store.collection('users').doc(uid).set({
        "uid": uid,
        "login": login,
        "fullname": fullname,
        "email": email,
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static Future<Map<String, dynamic>> getUser (String uid) async {
    QuerySnapshot snapshot = await store.collection('users').where('uid', isEqualTo: uid).get();
    return snapshot.docs.first.data() as Map<String, dynamic>;
  }

  static Future<bool> checkMovieLiked (String movieId) async {
    QuerySnapshot snapshot = await store.collection('favourites').where('user_id', isEqualTo: AuthService.me()!.uid).where('movie_id', isEqualTo: movieId).get();
    return snapshot.docs.isNotEmpty;
  }

  static Future<void> toggleMovieLike (String movieId) async {
    QuerySnapshot snapshot = await store.collection('favourites').where('user_id', isEqualTo: AuthService.me()!.uid).where('movie_id', isEqualTo: movieId).get();
    if (snapshot.docs.isNotEmpty) {
      await store.collection('favourites').doc(snapshot.docs[0].id).delete();
    } else {
      await store.collection('favourites').add({
        'user_id': AuthService.me()!.uid,
        'movie_id': movieId,
      });
    }
  }

  static Future<List<Map<String, dynamic>>> getMovies() async {
    QuerySnapshot snapshot = await store.collection('movies').get();

    List<Map<String, dynamic>> docs = [];

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      data['image_url'] = await StorageService.getImageUrl(data['image']);
      data['liked'] = await DBService.checkMovieLiked(doc.id);
      Map<String, dynamic> rated = await DBService.getMovieRating(doc.id);
      data['rating'] = rated['rating'];
      data['avgRating'] = await DBService.getMovieAvgRating(doc.id);
      data['message'] = rated['message'];
      docs.add(data);
    }
      
    return docs;
  }

  static Future<double> getMovieAvgRating(String movieId) async {
    final docs = await store.collection('ratings').where('movie_id', isEqualTo: movieId).get();
    if (docs.docs.isEmpty) {
      return -1.0;
    } else {
      double s = 0.0;
      docs.docs.forEach((element) {s += element.data()['rating']+.0; });
      return s/docs.docs.length;
    }
  }

  static Future<Map<String, dynamic>> getMovieRating(String movieId) async {
    final docs = await store.collection('ratings').where('movie_id', isEqualTo: movieId)
      .where('user_id', isEqualTo: AuthService.auth.currentUser!.uid).get();
    if (docs.docs.isEmpty) {
      return {
        'rating': 0,
        'message': '',
      };
    } else {
      return {
        'rating': docs.docs.first.data()['rating'],
        'message': docs.docs.first.data()['message'],
      };
    }
  }

  static Future<List<Map<String, dynamic>>> getLikedMovies () async {
    QuerySnapshot snapshot = await store.collection('movies').get();

    List<Map<String, dynamic>> docs = [];

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      data['image_url'] = await StorageService.getImageUrl(data['image']);
      data['liked'] = await DBService.checkMovieLiked(doc.id);
      docs.add(data);
    }

    List<Map<String, dynamic>> movies = [];
    
    for (var movie in docs) {
      if (await checkMovieLiked(movie['id'])) {
        movies.add(movie);
      }
    }

    return movies;
  }

  static Future<void> setRating (String movieId, String message, int rating) async {
    QuerySnapshot snapshot = await store.collection('ratings')
      .where('user_id', isEqualTo: AuthService.auth.currentUser!.uid)
      .where('movie_id', isEqualTo: movieId).get();
    if (snapshot.docs.isEmpty) {
      store.collection('ratings').add({
        'user_id': AuthService.auth.currentUser!.uid,
        'movie_id': movieId,
        'rating': rating,
        'message': message,
      });
    } else {
      store.collection('ratings').doc(snapshot.docs.first.id).set({
        'user_id': AuthService.auth.currentUser!.uid,
        'movie_id': movieId,
        'rating': rating,
        'message': message,
      });
    }
  }
}