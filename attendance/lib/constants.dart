import 'package:flutter/material.dart';

const Color textFieldBG = Color(0xffD9D9D9);

// textField
const ktextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: textFieldBG,
  contentPadding: EdgeInsets.symmetric(
    horizontal: 20,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
    borderSide: BorderSide(
      color: textFieldBG,
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        16,
      ),
    ),
    borderSide: BorderSide(
      width: 2,
      color: Colors.black54,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        16,
      ),
    ),
    borderSide: BorderSide(
      color: Colors.red,
      width: 2,
    ),
  ),
);

// button Style
ButtonStyle kButtonStyle = ElevatedButton.styleFrom(
    fixedSize: const Size(130, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ));

ButtonStyle kbutton = ButtonStyle(
  fixedSize: MaterialStateProperty.all(
    const Size(130, 42),
  ),
);

const ktextStyle =  TextStyle(
  fontSize: 20,
);
