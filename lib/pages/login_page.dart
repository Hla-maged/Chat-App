import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/helper/showsnackbar.dart';
import 'package:myproject/pages/chat_page.dart';
import 'package:myproject/pages/register_page.dart';
import 'package:myproject/widgets/button.dart';
import 'package:myproject/widgets/text_feild.dart';

import '../constatns.dart';

class Login extends StatefulWidget {
  @override
  static String id = 'Login page';
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  bool load = false;

  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: load,
      child: Scaffold(
        backgroundColor: KprimaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(children: [
              SizedBox(
                height: 70,
              ),
              Image.asset(
                'assets/images/scholar.png',
                height: 140,
              ),
              Center(
                child: Text(
                  'Scholar Chat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: 'pacifico'),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text('LOGIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormFeild(
                onChanged: (data) {
                  email = data;
                },
                hint: 'Email',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormFeild(
                obsecure: true,
                onChanged: (data) {
                  password = data;
                },
                hint: 'Password',
              ),
              SizedBox(
                height: 15,
              ),
              CustomButton(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    load = true;
                    setState(() {});
                    try {
                      await LoginUser();
                      Navigator.pushNamed(context, Chat.id,arguments:email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        ShowSnackBar(context, 'user not found');
                      } else if (e.code == 'wrong-password') {
                        ShowSnackBar(context, 'wrong password');
                      }
                    } catch (e) {
                      print(e);
                      ShowSnackBar(context, 'there was an error');
                    }

                    load = false;
                    setState(() {});
                  } else {}
                },
                text: 'Login',
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Register.id);
                },
                child: Center(
                  child: Text('Dont\'t have an account?   Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> LoginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
