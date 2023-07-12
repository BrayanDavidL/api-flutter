// ----- STRINGS ------
import 'package:flutter/material.dart';

const baseURL = 'http://192.168.18.114:8000/api';
const loginURL = baseURL + '/SIGAC/login';
const logoutURL = baseURL + '/SIGAC/logout';
const apprenticesURL = baseURL + '/SIGAC/apprentice';

// ----- Errors -----
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';


// --- input decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black)),

    );
}

//Header Login
Container HeaderLogin (){
  return Container(
      color: Colors.cyan,
      height: 300,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      )
  );
}

// button
Container kTextButton(String label, Function onPressed) {
  return Container(
    width: 200,
    child: TextButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xff69e2ff)),
        side: MaterialStateBorderSide.resolveWith((states) => BorderSide(width: 3.0, color: const Color(0xff000000))),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 25)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.black,),
      ),
    ),
  );
}


// loginHint
Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(label, style:TextStyle(color: Colors.blue)),
        onTap: () => onTap()
      )
    ],
  );
}
