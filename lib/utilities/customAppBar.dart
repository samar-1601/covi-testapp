import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'alert_box.dart';

class CustomAppBar extends StatefulWidget {

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  @override
  Widget build(BuildContext context) {
    return  Container(
      //margin: EdgeInsets.only(top: 10.0,bottom: 20.0),
      color: kWeirdBlue,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),

            Flexible(
              flex: 9,
              child: Container(
                child: Text(
                  'CoviApp',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
//
            Flexible(
              flex: 3,
              child: MaterialButton(
                onPressed: () {
                  AlertBox(
                      context: context,
                      alertContent:
                      'Call and Mail us at ...',
                      alertTitle: 'Help',
                      rightActionText: 'Close',
                      leftActionText: '',
                      onPressingRightActionButton: () {
                        Navigator.pop(context);
                      }
                  ).showAlert();
                },
                child: Text(
                  'Help',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
