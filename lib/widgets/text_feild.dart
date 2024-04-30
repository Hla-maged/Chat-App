import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  String? hint;
  bool? obsecure;
  CustomTextFormFeild({this.onChanged, required this.hint,this.obsecure=false});
  Function(String)? onChanged;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obsecure! ,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field Required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
  }
}
