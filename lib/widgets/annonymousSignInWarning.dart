import 'package:flutter/material.dart';
import '../services/authService.dart';

showAnnonymousSignInWarning(
  BuildContext context,
  String msg,
  AuthService _authService,
) {
  // set up the buttons
  Widget yesButton = OutlineButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Text(
        'Yes',
        style: TextStyle(
            color: Colors.green,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito'),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        _authService.signInAnnonymouslyToMyApp();
      });
  Widget noButton = OutlineButton(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Text(
      'No',
      style: TextStyle(
          color: Colors.green,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito'),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Alert',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    content: Container(
      child: Flexible(
        child: Text(
          msg,
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    ),
    actions: [
      yesButton,
      noButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}