import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';


import '0CustomColors.dart';
import '0DataBase.dart';
import '1LogIn.dart';
import '2RegisterPage3.dart';

class RegisterPage2 extends StatefulWidget {
  String name;
  String email;
  String pass;
  RegisterPage2({Key? key, required this.name, required this.email, required this.pass}) : super(key: key);

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {

  UploadTask? task;
  File? file;
  String uploadImage = "assets/user-icon.png";

  PermissionStatus? permissionGranted;

  Future _getStoragePermission() async {
    permissionGranted =  await Permission.storage.status;
    if(permissionGranted != PermissionStatus.granted) {
      permissionGranted = await Permission.storage.request();
    }
    else {
      return;
    }
  }

  @override
  initState(){
    super.initState();
    _getStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) :  "No file selected";
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload a Profile Picture",
              style: TextStyle(
                  color: CustomColor.mediumColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 18,),
            Text(
              "Upload your picture, so stranger can trust you.",
              style: TextStyle(
                color: CustomColor.blackColor,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 36,),
            Align(
              alignment: Alignment.center,
              child:
              uploadImage == "assets/user-icon.png"
                ? Center(
                  child: Stack(
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: Ink.image(
                            image: AssetImage(uploadImage),
                            fit: BoxFit.cover,
                            width: 250,
                            height: 250,
                            child: InkWell(onTap: onClicked),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 16,
                        child: buildCircle(
                          color: Colors.white,
                          all: 4,
                          child: buildCircle(
                            color: Theme.of(context).colorScheme.primary,
                            all: 16,
                            child: const Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                : ProfileWidget(imagePath: uploadImage, onClicked: onClicked),
            ),
            Spacer(),
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
                    if(file == null){
                      Fluttertoast.showToast(
                        msg: "No file is selected",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0
                      );
                    }else{
                      uploadFile();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => RegisterPage3(
                          name: widget.name,
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
    );
  }

  Future uploadFile() async{
    final fileName = basename(file!.path);
    final destination = "${widget.name}/$fileName";

    FirebaseAPI.uploadFile(destination, file!);
  }

  void onClicked() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],);

    if(result == null) return;
    final path = result.files.single.path!;

    setState((){
      file = File(path);
      uploadImage = path;
    });
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({Key? key, required this.imagePath, required this.onClicked,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final image = imagePath.contains('https://') ? NetworkImage(imagePath) : FileImage(File(imagePath));

    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: image as ImageProvider,
                fit: BoxFit.cover,
                width: 250,
                height: 250,
                child: InkWell(onTap: onClicked),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 16,
            child: buildCircle(
              color: Colors.white,
              all: 4,
              child: buildCircle(
                color: color,
                all: 16,
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

class FirebaseAPI{
  static UploadTask? uploadFile(String des, File file){
    try{
      final ref = FirebaseStorage.instance.ref(des);
      return ref.putFile(file);
    }on FirebaseException catch(e){
        return null;
    }
  }
}