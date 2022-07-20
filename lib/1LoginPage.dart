import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '0CustomColors.dart';
import '1LogIn.dart';
import '3HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Scaffold(body: Center(child: CircularProgressIndicator(),));
          }else if(snapshot.hasData){
            return const HomePage();
          } else if(snapshot.hasError){
            return const Center(child: Text("Something went wrong"));
          }else{
            return const LogIn();
          }
        },
      ),
    );
  }
}
