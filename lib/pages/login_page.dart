// ignore_for_file: use_build_context_synchronously

import 'package:cinema_flutter/colors.dart';
import 'package:cinema_flutter/components/button.dart';
import 'package:cinema_flutter/components/input.dart';
import 'package:cinema_flutter/services/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? error;

  Future<void> login() async {
    error = await AuthService.login(widget._emailController.text, widget._passwordController.text);
    setState(() {
      
    });
    if (error==null || error!.isEmpty) {
      Navigator.of(context).pushReplacementNamed('movies');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Si", style: bigLogoStyle),
                Text("nema", style: bigLogoStyleAccent),
              ]
            ),
            const SizedBox(height: 30),
            Input(
              widget._emailController,
              placeholder: "E-mail",
              icon: Icons.mail_outline_rounded,
            ),
            const SizedBox(height: 20),
            Input(
              widget._passwordController,
              placeholder: "Password",
              obscure: true,
              icon: Icons.password_rounded,
            ),
            const SizedBox(height: 15),
            (error==null ? const SizedBox.shrink() : Text(error!, style: errorStyle)),
            const SizedBox(height: 15),
            Button("Sign in", login),
            const SizedBox(height: 15),
            const Row(children: [
              Expanded(child: Divider(thickness: 0.5)),
              SizedBox(width: 5),
              Text("Don't have an account?"),
              SizedBox(width: 5),
              Expanded(child: Divider(thickness: 0.5)),
            ]),
            const SizedBox(height: 15),
            Button("Register", () => Navigator.of(context).pushReplacementNamed('register'))
          ],
        ),
        )
      ),
    );
  }
}