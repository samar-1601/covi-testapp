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
                      '''If you want any immediate help or want to contact the medical facility regarding any problem you are facing, here are the contacts which you can approach:\n 
                      \n𝗛𝗢𝗦𝗣𝗜𝗧𝗔𝗟\n\nBCRTH ER : (8695571404)\nBCRTH Help Desk : (03222-81008/81009)\n
                      \n𝗙𝗢𝗢𝗗 𝗦𝗨𝗣𝗣𝗟𝗬\n\nBRH Mess : (9775536579/9126784350)\nNVH Mess : (8293999071)\nSunday food truck : (8617389794)\nBiplob Da : (7407031717)\nBikash Da : (9851874317)\nHeritage : (7407000227)\nDakshin : (9674873015)\nRao Garu shop in Tech (Andhra style breakfast) : (8293476093)\nSayan Dutta home delivery : (8016895224)\n
                      \n𝗚𝗥𝗢𝗖𝗘𝗥𝗬\n\nKgp bazaar (where orders can be picked and ordered online) : (https://www.bazaarkgp.com)\n\nTech.M vegetable/eggs : (9002468543) \nRitam online services : (9046419665, 7003009650)\nTech.M groceries : (9002821867)\nSpencers- Orders can be placed in website : (8348502831)

                      ''',
                      alertTitle: 'Want immediate Help?',
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
