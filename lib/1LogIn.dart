import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '0CustomColors.dart';
import '0DataBase.dart';
import '2RegisterPage0.dart';
import '3HomePage.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  var formKey = GlobalKey<FormState>();

  String? email;
  String? pass;
  bool passwordVisible = false;

  final DataBase _db = DataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.background,
      appBar: AppBar(
        backgroundColor: CustomColor.darkColor,
        title: Text("Log in", style: TextStyle(color: CustomColor.whiteColor, fontSize: 25),),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Image(
                  height: 60,
                  image: AssetImage("assets/logo.png"),
                ),
              ),
              const Text(
                "Together to promote the Omani product.",
                style: TextStyle(fontSize: 14, color: Colors.grey, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: CustomColor.blackColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "If you don't have account already, please register yourself.",
                    style: TextStyle(
                        color: CustomColor.blackColor, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: CustomColor.mediumColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: CustomColor.mediumColor),
                    ),
                    border: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: CustomColor.mediumColor),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  style: TextStyle(
                      fontSize: 14, color: CustomColor.blackColor),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Email is required"),
                    EmailValidator(errorText: "Not a valid Email")
                  ]),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: CustomColor.mediumColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: CustomColor.mediumColor),
                    ),
                    border: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: CustomColor.mediumColor),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  style: TextStyle(
                      fontSize: 14, color: CustomColor.blackColor),
                  obscureText: !passwordVisible,
                  onChanged: (value) {
                    setState(() {
                      pass = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        CustomColor.darkColor,
                      ),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () async {
                    if (email == null && pass == null) {
                      Fluttertoast.showToast(msg: "Please enter email and pass", textColor: Colors.white, gravity: ToastGravity.TOP);
                    } else {
                      if(formKey.currentState!.validate()){
                        String? signInUser = await _db.signInUser(email!, pass!);
                        if(signInUser == "not_found."){
                          setState(() {
                            Fluttertoast.showToast(msg: "User does not exist", textColor: Colors.white, gravity: ToastGravity.TOP);
                          });
                        }
                        else if(signInUser == "invalid_Email"){
                          setState(() {
                            Fluttertoast.showToast(msg: "Your email is incorrect", textColor: Colors.white, gravity: ToastGravity.TOP);
                          });
                        }
                        else if(signInUser == "wrong_password"){
                          setState(() {
                            Fluttertoast.showToast(msg: "Your password is incorrect", textColor: Colors.white, gravity: ToastGravity.TOP);
                          });
                        }else {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
                        }
                      }
                    }
                  },
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        color: CustomColor.blackColor,
                        fontSize: 22,
                        letterSpacing: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    GestureDetector(
                      // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterPage1())),
                        child: Text(
                          "Forget passwords?",
                          style: TextStyle(
                              fontSize: 15, color: CustomColor.mediumColor),
                        )),
                    const Spacer(),
                    GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                const RegisterPage0())),
                        child: Text(
                          "Create an account",
                          style: TextStyle(
                              fontSize: 15,
                              color: CustomColor.mediumColor),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              // Text(
              //   "Or login with",
              //   style: TextStyle(color: CustomColor.blackColor, fontSize: 18),
              // ),
              Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                height: 60,
                decoration: BoxDecoration(
                  border:
                  Border.all(color: CustomColor.darkColor, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.googleLogin();
                  },
                  child: const Center(
                    child: ListTile(
                        leading: Image(
                          image: AssetImage("assets/google-icon.png"),
                          width: 37,
                        ),
                        title: Text(
                          "Continue with Google",
                          style: TextStyle(
                              color: Colors.black, fontSize: 15),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
