import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;
  final IconData? icon;
  final int? maxLines;
  final bool obscure;

  const Input(
    this.controller,
    {
      this.placeholder = "",
      this.icon,
      this.maxLines = 1,
      this.obscure = false,
      super.key
    }
  );

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: widget.placeholder,
        prefixIcon: Icon(widget.icon),
        border: const OutlineInputBorder()
      ),
      maxLines: widget.maxLines,
      controller: widget.controller,
      obscureText: widget.obscure,
    );
  }
}