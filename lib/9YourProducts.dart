import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '0CustomColors.dart';
import '3HomePage.dart';

class YourProducts extends StatefulWidget {
  const YourProducts({Key? key}) : super(key: key);

  @override
  State<YourProducts> createState() => _YourProductsState();
}

class _YourProductsState extends State<YourProducts> {
  bool orders = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: AppBar(
        backgroundColor: CustomColor.darkColor,
        title: Text("Your Products"),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: orders
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 260,
              child: Center(
                child: Lottie.asset("assets/93134-not-found.json"),
              ),
            ),
            Text(
              "Oops !!",
              style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30,),
            Text(
              "Sorry! don't have any items yet.",
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
                  "Order now",
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
