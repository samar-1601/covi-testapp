import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/constants.dart';

class DataSender extends StatefulWidget {
  final String selectedCategory;
  final String name;
  final String hall;
  final String room;
  final DateTime birthday;

  DataSender(
      {this.selectedCategory,this.name, this.hall, this.room, this.birthday});

  @override
  _DataSenderState createState() => _DataSenderState();
}

class _DataSenderState extends State<DataSender> {


  @override
  void initState() {
    super.initState();
    print(widget.selectedCategory);
    print(widget.name==''?'Name not entered':widget.name);
    print(widget.hall==''?'Hall not entered':widget.hall);
    print(widget.selectedCategory=='Student'?widget.room:'');
    print(widget.birthday.toString()==''?'Name not entered':widget.birthday.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
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
            ),
            SizedBox(
              height: 120.0,
            ),
            Container(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Data till now\n',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.selectedCategory+'\n'+ widget.name + '\n' + widget.hall + '\n' + widget.room +'\n'+ widget.birthday.toString(),
                      style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: SizedBox(
      //   height: 80.0,
      //   child: CommonCustomBottomNavBar(),
      // ),
    );
  }
}
