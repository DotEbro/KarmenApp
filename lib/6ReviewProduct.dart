import 'package:flutter/material.dart';

import '0CustomColors.dart';
import '3HomePage.dart';
import '7SavedProduct.dart';

class ReviewProduct extends StatefulWidget {
  const ReviewProduct({Key? key}) : super(key: key);

  @override
  State<ReviewProduct> createState() => _ReviewProductState();
}

class _ReviewProductState extends State<ReviewProduct> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: AppBar(
        title: Text(
          "Review your Product",
          style: TextStyle(color: CustomColor.mediumColor),
        ),
        backgroundColor: CustomColor.darkColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(image: AssetImage("assets/package.png"))
                ),
              ),
              SizedBox(height: 18,),
              Text(
                "Product Name",
                style: TextStyle(
                  color: CustomColor.mediumColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 18,),
              Text(
                "Category",
                style: TextStyle(
                  color: CustomColor.mediumColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 18,),
              Text(
                "Contact Number",
                style: TextStyle(
                  color: CustomColor.mediumColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 18,),
              Text(
                "Price",
                style: TextStyle(
                  color: CustomColor.mediumColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 18,),
              Text(
                "Quantity",
                style: TextStyle(
                  color: CustomColor.mediumColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 18,),
              Text(
                "Address",
                style: TextStyle(
                  color: CustomColor.mediumColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 70,),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: CustomColor.boxColor,
                      onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const HomePage())
                      ),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                            color: CustomColor.blackColor,
                            fontSize: 22,
                            letterSpacing: 2
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(CustomColor.darkColor,),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )
                          )
                      ),
                      onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const SavedProduct())
                      ),
                      child: Text(
                        "CONFIRM",
                        style: TextStyle(
                            color: CustomColor.mediumColor,
                            fontSize: 22,
                            letterSpacing: 2
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
