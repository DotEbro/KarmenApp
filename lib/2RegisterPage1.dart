import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '1LogIn.dart';
import '2RegisterPage2.dart';
import '0CustomColors.dart';

class RegisterPage1 extends StatefulWidget {
  String email;
  String pass;
  RegisterPage1({Key? key,required this.email, required this.pass}) : super(key: key);

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {

  var formKey = GlobalKey<FormState>();

  String? Name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.background,
      appBar: AppBar(
        backgroundColor: CustomColor.background,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LogIn())),
              icon: Icon(Icons.close, color: CustomColor.blackColor, size: 35,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 25),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What's your name?",
                style: TextStyle(
                  color: CustomColor.mediumColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 18,),
              Text(
                "We need your name in order to buy and sell items.",
                style: TextStyle(
                  color: CustomColor.blackColor,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 36,),
              SizedBox(
                height: 60,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    labelStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.mediumColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.mediumColor),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.mediumColor),
                    ),
                  ),
                  style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                  validator: (value){
                    if(value!.isEmpty || RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)){
                      return "Enter correct Name";
                    }
                    else{
                      return null;
                    }
                  },
                  onChanged: (value){
                    setState((){
                      Name = value;
                    });
                  },
                ),
              ),
              const Spacer(),
              // const SizedBox(height: 150,),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(CustomColor.darkColor,),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),))
                    ),
                    onPressed: () {
                      if (Name == null){
                        Fluttertoast.showToast(
                            msg: "Please enter your Name",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }else{
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                            RegisterPage2(
                              name: Name!,
                              email: widget.email,
                              pass: widget.pass,
                            )));
                      }
                    },
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                          color: CustomColor.blackColor,
                          fontSize: 22,
                          letterSpacing: 2
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25,)
            ],
          ),
        ),
      ),
    );
  }
}
