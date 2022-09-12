import 'package:flutter/material.dart';

const Color textFieldBG = Color(0xffD9D9D9);

// textField
const ktextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: textFieldBG,
  contentPadding: EdgeInsets.fromLTRB(20, 4, 20, 4),
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
  focusedErrorBorder: OutlineInputBorder(
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

const ktextStyle = TextStyle(
  fontSize: 20,
);

const String eyeOpenSvg =
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" width="16" height="16" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="#222" d="M12 9.005a4 4 0 1 1 0 8a4 4 0 0 1 0-8Zm0 1.5a2.5 2.5 0 1 0 0 5a2.5 2.5 0 0 0 0-5ZM12 5.5c4.613 0 8.596 3.15 9.701 7.564a.75.75 0 1 1-1.455.365a8.504 8.504 0 0 0-16.493.004a.75.75 0 0 1-1.456-.363A10.003 10.003 0 0 1 12 5.5Z"/></svg>';
