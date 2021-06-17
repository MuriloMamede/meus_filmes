import 'package:flutter/material.dart';

const Color accentColor = Colors.redAccent;

const Color primaryColor = Colors.red;
Color brancoFundo = Colors.black87;
LinearGradient get primaryGradient => LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Colors.black, primaryColor],
    );

LinearGradient get redGradient => LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Colors.black, Colors.red[600]],
    );
