import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';

class CustomDropDownButton extends StatefulWidget {

  final String buttonHintText;
  final Color hintTextColor;
  final Color dropDownItemColor;
  final Color dropDownColor;
  final value;
  final List items;
  final Function onTap;

  CustomDropDownButton({
    this.buttonHintText,
    this.hintTextColor,
    this.dropDownItemColor,
    this.dropDownColor,
    this.value,
    this.items,
    this.onTap,
  });

  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 2.0, bottom: 2.0),
        child: DropdownButton(
          style: TextStyle(
            color: widget.dropDownItemColor,
            fontSize: 16.0,
          ),
          hint: Text(
            widget.buttonHintText,
            style: TextStyle(
              color: widget.hintTextColor,
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(                // Add this
              Icons.arrow_drop_down,  // Add this
              color: kWeirdBlue,   // Add this
            ),
          ),
          dropdownColor: widget.dropDownColor,
          value: widget.value,
          items: widget.items,
          onChanged: widget.onTap,
        ),
      ),
    );
  }
}
