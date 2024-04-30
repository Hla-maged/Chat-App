import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myproject/firebase_options.dart';
import 'package:myproject/pages/chat_page.dart';
import 'package:myproject/pages/login_page.dart';
import 'package:myproject/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        Chat.id: (context) => Chat(),
      },
      initialRoute: Login.id,
    );
  }
}

