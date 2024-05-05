import 'package:cinema_flutter/colors.dart';
import 'package:cinema_flutter/components/button.dart';
import 'package:cinema_flutter/components/input.dart';
import 'package:cinema_flutter/services/auth.dart';
import 'package:cinema_flutter/services/database.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  String? error;

  Future<void> editUser() async {
    if (
      widget._fullNameController.text.isEmpty ||
      widget._loginController.text.isEmpty
    ) {
      error = "Fill all fields!";
      setState(() {
        
      });
    } else {
      error = await DBService.addUser(
        AuthService.auth.currentUser!.uid,
        widget._loginController.text,
        widget._fullNameController.text,
        widget._emailController.text
      );
      
      await Navigator.of(context).pushReplacementNamed('profile');
    }
  }

  Future<void> getData () async {
    Map<String, dynamic> data = await DBService.getUser(AuthService.me()!.uid);
    widget._emailController.text = data['email'];
    widget._loginController.text = data['login'];
    widget._fullNameController.text = data['fullname'];
  }


  @override
  void initState() {
    super.initState();
    getData();
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
                Text("Edit profile", style: bigLogoStyle),
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
            const SizedBox(height: 20),
            (error==null ? const SizedBox.shrink() : Text(error!, style: errorStyle)),
            const SizedBox(height: 15),
            Button("Edit user", () => editUser()),
            const SizedBox(height: 15),
          ],
        ),
        )
      ),
    );
  }
}