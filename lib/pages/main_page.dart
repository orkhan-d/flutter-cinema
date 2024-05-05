import 'package:cinema_flutter/pages/login_page.dart';
import 'package:cinema_flutter/pages/movies_page.dart';
import 'package:cinema_flutter/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = AuthService.me();
    return user==null ? LoginPage() : const MoviesPage();
  }
}