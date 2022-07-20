import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '0DataBase.dart';
import '0CustomColors.dart';
import '2SaveProfile.dart';
import '3HomePage.dart';

class ReviewProfile extends StatefulWidget {
  String name;
  String number;
  double lat;
  double lng;
  String address;
  String email;
  String pass;
  ReviewProfile({Key? key, required this.name, required this.number, required this.lat, required this.lng, required this.address, required this.email, required this.pass}) : super(key: key);

  @override
  State<ReviewProfile> createState() => _ReviewProfileState();
}

class _ReviewProfileState extends State<ReviewProfile> {

  late Future<List<FirebaseFile>> futureFiles;
  final DataBase _db = DataBase();

  @override
  initState(){
    super.initState();
    futureFiles = FirebaseApi.listAll(widget.name);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: AppBar(
        title: Text(
          "Review your Profile",
          style: TextStyle(color: CustomColor.mediumColor),
        ),
        backgroundColor: CustomColor.darkColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot){
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
                return const Align(alignment: Alignment.center, child: CircularProgressIndicator());
            default:
              final files = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.network(files[0].url),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Text(
                        widget.name,
                        style: TextStyle(
                          color: CustomColor.mediumColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 18,),
                      Text(
                        widget.number,
                        style: TextStyle(
                          color: CustomColor.mediumColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 18,),
                      Text(
                        widget.address,
                        style: TextStyle(
                          color: CustomColor.mediumColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 18,),
                      Text(
                        widget.email,
                        style: TextStyle(
                          color: CustomColor.mediumColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 18,),
                      Text(
                        widget.pass,
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
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const HomePage()));
                              },
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
                          const Spacer(),
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
                              onPressed: () {
                                dynamic user = _db.saveUser(widget.name, widget.number, widget.lat, widget.lng, widget.address, widget.email, widget.pass);
                                if(user != null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                      const SaveProfile()));
                                }
                              },
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
              );
          }
        },
      ),
    );
  }
}
