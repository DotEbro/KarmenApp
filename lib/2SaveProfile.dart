import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '0CustomColors.dart';
import '3HomePage.dart';

class SaveProfile extends StatefulWidget {
  const SaveProfile({Key? key}) : super(key: key);

  @override
  State<SaveProfile> createState() => _SaveProfileState();
}

class _SaveProfileState extends State<SaveProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 260,
              child: Center(
                child: Lottie.asset("assets/33886-check-okey-done.json", repeat: false),
              ),
            ),
            Text(
              "Successful !!",
              style: TextStyle(color: CustomColor.blackColor, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30,),
            Text(
              "Your profile has successfully created, please login into your account by clicking ok.",
              style: TextStyle(color: CustomColor.blackColor, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 70,),
            SizedBox(
              width: 280,
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: CustomColor.darkColor,
                onPressed: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage())
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.white,
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
