import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '0CustomColors.dart';
import '1LogIn.dart';
import '2RegisterPage1.dart';
import '0DataBase.dart';

class RegisterPage0 extends StatefulWidget {
  const RegisterPage0({Key? key}) : super(key: key);

  @override
  State<RegisterPage0> createState() => _RegisterPage0State();
}

// String address;

class _RegisterPage0State extends State<RegisterPage0> {

  var formKey = GlobalKey<FormState>();

  String pass = "";
  String email = "";

  final DataBase _db = DataBase();

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
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: formKey,
        child: Column(
          children: [
            Text(
              "Create New Account",
              style: TextStyle(
                  color: CustomColor.mediumColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 18,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 25),
              child: Text(
                "Please enter valid email, we will be verifying your account later.",
                style: TextStyle(
                  color: CustomColor.blackColor,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 36,),
            const SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.mediumColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.mediumColor),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.mediumColor),
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                validator: MultiValidator(
                  [
                    RequiredValidator(errorText: "Email is required"),
                    EmailValidator(errorText: "Not a valid Email")
                  ]
                ),
                onChanged: (value){
                  setState((){
                    email = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.mediumColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.mediumColor),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.mediumColor),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                validator: (value) {
                  // add your custom validation here.
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length < 6) {
                    return 'Must be more than 6 character';
                  }
                  return null;
                },
                onChanged: (value){
                  setState((){
                    pass = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 50,),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CustomColor.darkColor,),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),))
                ),
                onPressed: () {
                  if(email == "" && pass == ""){
                    Fluttertoast.showToast(
                      msg: "Please enter email and pass",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0
                    );
                  }else if(formKey.currentState!.validate()){
                    dynamic user = _db.registerUser(email, pass);
                    if (user != null) {
                      print("User data: $user");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => RegisterPage1(email: email, pass: pass,)));
                    } else {
                      Fluttertoast.showToast(
                        msg: "Something went wrong",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    }
                  }
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      color: CustomColor.blackColor,
                      fontSize: 22,
                      letterSpacing: 2
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
