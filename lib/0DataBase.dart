import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBase{
 final FirebaseAuth _auth = FirebaseAuth.instance;

 final CollectionReference userData = FirebaseFirestore.instance.collection("AllUsers");

 static String? signInUserid;

 Future registerUser(String email, String pass)async{
   UserCredential credit = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
   User user = credit.user as User;
   signInUserid = user.uid;
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setString('UserID', user.uid);
   return signInUserid;
 }


 Future saveUser(String name, String number, double lat, double lng, String address, String email, String pass) async{
   try{
      await userData.doc(signInUserid).set({
        "UserID": signInUserid,
        "FullName": name,
        "ContactNumber": number,
        "Latitude": lat,
        "Longitude": lng,
        "Address": address,
        "Email": email,
        "Password": pass
      });
    }catch(e) {
     print("Error: $e");
   }
 }

 Future saveGmailUser(String uid, String name, String email)async{
   signInUserid = uid;
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setString('UserID', uid);
   try{
     await userData.doc(uid).set({
       "UserID": uid,
       "FullName": name,
       "ContactNumber": "Null",
       "Latitude": "Null",
       "Longitude": "Null",
       "Address": "Null",
       "Email": email,
       "Password": "Null",
     });
   }catch(e) {
     print("Error: $e");
   }
 }

 Future<GetSignInUserData?> getUserData(String uid) async{
   final userData = FirebaseFirestore.instance.collection("AllUsers").doc(uid);
   final snapshot = await userData.get();
   if(snapshot.exists){
     return GetSignInUserData.fromJson(snapshot.data()!);
   }
   return null;
 }

 Future updateValue(field, name, uid) async{
   final doc = FirebaseFirestore.instance.collection("AllUsers").doc(uid);
   doc.update({field: name});
 }

 Future saveLocation(String add, double lat, double lng, String uid) async{
   final doc = FirebaseFirestore.instance.collection("AllUsers").doc(uid);
   doc.update({
     "Latitude" : lat,
     "Address" : add,
     "Longitude" : lng,
   });
 }

 Future<String?> signInUser(String email, String password) async{
   try{
     UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
     User logInUser = credential.user as User;
     signInUserid = logInUser.uid;
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('UserID', logInUser.uid);
     return signInUserid;
   }
   catch(e){
     return Errors.show(e.toString());
   }
 }

}

// With GoogleSignInProvider user can sign in with gmail
class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  final CollectionReference userData = FirebaseFirestore.instance.collection("AllUsers");

  Future googleLogin() async{
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null) return;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    final signUser = FirebaseAuth.instance.currentUser!;
    DataBase().saveGmailUser(signUser.uid, signUser.displayName!, signUser.email!);

    notifyListeners();
  }
}

// This class is returning sign in error to the user
class Errors {
  static String show(String errorCode) {
    switch (errorCode) {
      case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
        return "not_found.";

      case '[firebase_auth/invalid-email] The email address is badly formatted.':
        return "invalid_Email.";

      case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
        return "wrong_password";

      default:
        return "an_error";
    }
  }
}


// User Data Class
class GetSignInUserData{
  final userID;
  final name;
  final contact;
  final lat;
  final lng;
  final add;
  final email;
  final password;

  GetSignInUserData({
    required this.userID,
    required this.name,
    required this.contact,
    required this.lat,
    required this.lng,
    required this.add,
    required this.email,
    required this.password,
  });

  static GetSignInUserData fromJson(Map<String, dynamic> doc) => GetSignInUserData(
    userID: doc["UserID"],
    name: doc["FullName"],
    contact: doc["ContactNumber"],
    lat: doc["Latitude"],
    lng: doc["Longitude"],
    add: doc["Address"],
    email: doc["Email"],
    password: doc["Password"],
  );
}


// getting User pic from Firebase Storage
class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls.asMap().map((index, url) {
      final ref = result.items[index];
      final name = ref.name;
      final file = FirebaseFile(ref: ref, name: name, url: url);
      return MapEntry(index, file);
    }).values.toList();
  }

  static Future downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');

    await ref.writeToFile(file);
  }
}

class FirebaseFile {
  final Reference ref;
  final String name;
  final String url;

  const FirebaseFile({
    required this.ref,
    required this.name,
    required this.url,
  });
}