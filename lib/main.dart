import 'package:cinema_flutter/firebase_options.dart';
import 'package:cinema_flutter/pages/login_page.dart';
import 'package:cinema_flutter/colors.dart';
import 'package:cinema_flutter/pages/main_page.dart';
import 'package:cinema_flutter/pages/movies_page.dart';
import 'package:cinema_flutter/pages/profile_edit_page.dart';
import 'package:cinema_flutter/pages/profile_page.dart';
import 'package:cinema_flutter/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: mainTheme,
      title: 'Sinema',
      routes: {
        '/': (context) => const MainPage(),
        'login': (context) => LoginPage(),
        'register': (context) => RegisterPage(),
        'movies': (context) => const MoviesPage(),
        'profile': (context) => const ProfilePage(),
        'profile_edit': (context) => ProfileEditPage(),
      },
    );
  }
}