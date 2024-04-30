import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myproject/constatns.dart';
import 'package:myproject/models/message.dart';

class Chat_bubble extends StatelessWidget {
  final Message message;
  Chat_bubble({required this.message});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 22, right: 22, top: 22, bottom: 22),
        margin: EdgeInsets.all(15),
        child: Text(
          message.text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        decoration: BoxDecoration(
            color: KprimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
      ),
    );
  }
}

class Chat_bubbleF extends StatelessWidget {
  final Message message;
  Chat_bubbleF({required this.message});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 22, right: 22, top: 22, bottom: 22),
        margin: EdgeInsets.all(15),
        child: Text(
          message.text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 20, 137, 200),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            )),
      ),
    );
  }
}
