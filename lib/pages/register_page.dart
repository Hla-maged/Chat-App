import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myproject/helper/showsnackbar.dart';
import 'package:myproject/pages/chat_page.dart';
import 'package:myproject/widgets/button.dart';
import 'package:myproject/widgets/text_feild.dart';

import '../constatns.dart';

class Register extends StatefulWidget {
  static String id = 'Register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;

  String? password;

  bool load = false;

  @override
  GlobalKey<FormState> formKey = GlobalKey();

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
                  Text('REGISTER',
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
                      await RegisterUser();
                      Navigator.pushNamed(context, Chat.id);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        ShowSnackBar(context, 'weak-password');
                      } else if (e.code == 'email-already-in-use') {
                        ShowSnackBar(context, 'email-already-in-use');
                      }
                    } catch (e) {
                      ShowSnackBar(context, 'there was an error');
                    }
                    load = false;
                    setState(() {});
                  } else {}
                },
                text: 'Register',
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text('Already have an account?   Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> RegisterUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
