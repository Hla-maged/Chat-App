import 'package:flutter/material.dart';
import 'package:myproject/constatns.dart';
import 'package:myproject/models/message.dart';
import 'package:myproject/widgets/Chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatelessWidget {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessageCollections);
  TextEditingController controller = TextEditingController();
  static String id = 'Chat page';
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(KCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> MessageL = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              MessageL.add(Message.fromjson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: KprimaryColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        KLogo,
                        height: 60,
                      ),
                      Text(
                        'Chat',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                body: Column(children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: MessageL.length,
                        itemBuilder: (context, index) {
                          return MessageL[index].id == email
                              ? Chat_bubble(
                                  message: MessageL[index],
                                )
                              : Chat_bubbleF(message: MessageL[index]);
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          KMessage: data,
                          KCreatedAt: DateTime.now(),
                          'id': email,
                        });
                        controller.clear();
                        _controller.animateTo(0,
                            duration: Duration(seconds: 10),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: Icon(Icons.send, color: KprimaryColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: KprimaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: KprimaryColor)),
                      ),
                    ),
                  ),
                ]));
          } else {
            return Text('Loading...');
          }
        });
  }
}
