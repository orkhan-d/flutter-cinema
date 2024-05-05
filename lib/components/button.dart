import 'package:cinema_flutter/colors.dart';
import 'package:flutter/material.dart';

enum ButtonType {text, elevated, outlined}

class Button extends StatelessWidget {
  final String text;
  final void Function() callback;
  final IconData? icon;
  final bool delete;
  final bool disabled;

  const Button(
    this.text,
    this.callback,
    {
      this.icon,
      this.delete = false,
      this.disabled = false,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    // if (icon==null) {
    //   return ElevatedButton(
    //     onPressed: callback,
    //     child: Text(text)
    //   );
    // }
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: delete ? deleteColor : buttonColor,
        ),
        child: Text(
          text,            
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}