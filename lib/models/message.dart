import 'package:myproject/constatns.dart';

class Message {
  final String text;
  final String id;
  Message(this.text,this.id);

  factory Message.fromjson(Data) {
    return Message(Data[KMessage],Data['id']);
  }
}
