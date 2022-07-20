import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '0CustomColors.dart';
import '0DataBase.dart';
import '1LoginPage.dart';
import '3HomePage.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;

  runApp( ChangeNotifierProvider(
    create: (context) => GoogleSignInProvider(),
    child: MaterialApp(
      home: status ? const HomePage() : const MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future getLocationAndStorage() async {
    var locationPermission = await Permission.location.status;
    var storagePermission =  await Permission.storage.status;

    if(locationPermission != PermissionStatus.granted){
      locationPermission = await Permission.location.request();
    }if(storagePermission != PermissionStatus.granted) {
      storagePermission = await Permission.storage.request();
    }else{
      return;
    }
  }

  @override
  initState(){
    // TODO: implement initState
    super.initState();
    getLocationAndStorage();
    // _getStoragePermission();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100,),
            const Center(
              child: Image(
                height: 100,
                image: AssetImage("assets/logo.png"),
              ),
            ),
            Text(
              "Karmen",
              style: TextStyle(fontSize: 30, color: CustomColor.blackColor, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                "Welcome to Karmen platform where you can buy or sell products.",
                style: TextStyle(color: CustomColor.blackColor, fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 330,
              child: Center(
                child: Lottie.asset("assets/68484-venda-online.json",),
              ),
            ),
            SizedBox(height: 40,),
            Container(
              width: 300,
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
                    builder: (BuildContext context) => const LoginPage())
                ),
                child: Text(
                  "START",
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
