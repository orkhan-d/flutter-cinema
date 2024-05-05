import 'package:cinema_flutter/colors.dart';
import 'package:cinema_flutter/components/button.dart';
import 'package:cinema_flutter/components/input.dart';
import 'package:cinema_flutter/services/auth.dart';
import 'package:cinema_flutter/services/database.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? error;
  bool checked = false;

  Future<void> login() async {
    if (!checked) {
      error = "Accept everything!";
      setState(() {
        
      });
    }
    else if (
      widget._fullNameController.text.isEmpty ||
      widget._loginController.text.isEmpty ||
      widget._emailController.text.isEmpty ||
      widget._passwordController.text.isEmpty
    ) {
      error = "Fill all fields!";
      setState(() {
        
      });
    } else {
      error = await AuthService.register(widget._emailController.text, widget._passwordController.text);
      error = await AuthService.login(widget._emailController.text, widget._passwordController.text);
      setState(() {
        
      });
      if (error==null || error!.isEmpty) {
        DBService.addUser(
          AuthService.auth.currentUser!.uid,
          widget._loginController.text,
          widget._fullNameController.text,
          widget._emailController.text,
        );
        await Navigator.of(context).pushReplacementNamed('movies');
      }
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
          padding: EdgeInsets.symmetric(horizontal: 20),
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
              widget._fullNameController,
              placeholder: "Fullname",
              icon: Icons.app_registration_rounded,
            ),
            const SizedBox(height: 30),
            Input(
              widget._loginController,
              placeholder: "Login",
              icon: Icons.account_circle_rounded,
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
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(value: checked, onChanged: (value) {
                  checked = !checked;
                  setState(() {});
                }),
                const Text("I accept everything")
              ]
            ),
            const SizedBox(height: 15),
            (error==null ? SizedBox.shrink() : Text(error!, style: errorStyle)),
            const SizedBox(height: 15),
            Button("Sign in", login),
            const SizedBox(height: 15),
            const Row(children: [
              Expanded(child: Divider(thickness: 0.5)),
              SizedBox(width: 5),
              Text("Already have an account?"),
              SizedBox(width: 5),
              Expanded(child: Divider(thickness: 0.5)),
            ]),
            const SizedBox(height: 15),
            Button("Login", () => Navigator.of(context).pushReplacementNamed('login'))
          ],
        ),
        )
      ),
    );
  }
}