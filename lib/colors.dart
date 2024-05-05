import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 22, 22, 22)
  )
);

Color accentColor = Colors.pink.shade700;
Color buttonColor = Colors.purple.shade700;
Color deleteColor = Colors.red;

TextStyle errorStyle = const TextStyle(
  color: Colors.red,
  fontSize: 18,
  fontWeight: FontWeight.bold
);

TextStyle bigLogoStyle = const TextStyle(
  color: Colors.white,
  fontSize: 50,
  fontWeight: FontWeight.w900
);

TextStyle bigLogoStyleAccent = TextStyle(
  color: accentColor,
  fontSize: 50,
  fontWeight: FontWeight.w900
);

TextStyle movieTileTitle = const TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.w700
);

TextStyle profileInfoText = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: Colors.white
);

TextStyle profileInfoCaption = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: accentColor
);