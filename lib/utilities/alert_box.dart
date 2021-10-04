//this file has a customized alert Box
//Can be used anywhere by calling the AlertBox  class and specifying the required parameters.

import 'package:coviapp/utilities/constants.dart';
import 'package:flutter/material.dart';

class AlertBox
{
  final context;
  final alertTitle;
  final alertContent;
  final String rightActionText;
  final String leftActionText ;
  final Function onPressingLeftActionButton;
  final Function onPressingRightActionButton;
  AlertBox({this.context, this.alertContent, this.alertTitle, this.rightActionText, this.leftActionText, this.onPressingLeftActionButton, this.onPressingRightActionButton});

  void showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertTitle??'Alert Title'),
          content: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Text(alertContent??'Alert Content')
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                leftActionText??' ',
                style: TextStyle(
                  color: kWeirdBlue,
                  fontSize: 12.0,
                ),
              ),
              onPressed: onPressingLeftActionButton
            ),
            TextButton(
              child: Text(
                rightActionText??' ',
                style: TextStyle(
                  color: kWeirdBlue,
                ),
              ),
              onPressed: onPressingRightActionButton
            ),
          ],
        );
      },
    );
  }

}