// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// import '0CustomColors.dart';
// import '2RegisterPage1.dart';
// import '3HomePage.dart';
//
// class EmailLogIn extends StatefulWidget {
//   const EmailLogIn({Key? key}) : super(key: key);
//
//   @override
//   State<EmailLogIn> createState() => _EmailLogInState();
// }
//
// class _EmailLogInState extends State<EmailLogIn> {
//
//   String? email;
//   String? pass;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // resizeToAvoidBottomInset: true,
//       backgroundColor: CustomColor.background,
//       appBar: AppBar(
//         backgroundColor: CustomColor.darkColor,
//         title: const Text("Log in", style: TextStyle(color: Colors.white, fontSize: 25),),
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 70,),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   "Already have an account?",
//                   style: TextStyle(color: CustomColor.blackColor, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8,),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   "If you don't have account already, please register yourself.",
//                   style: TextStyle(color: CustomColor.blackColor, fontSize: 14),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20,),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: CustomColor.mediumColor),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: CustomColor.mediumColor),
//                   ),
//                   border: UnderlineInputBorder(
//                     borderSide: BorderSide(color: CustomColor.mediumColor),
//                   ),
//                   labelText: "Email",
//                   labelStyle: TextStyle(color: Colors.grey),
//                 ),
//                 style: const TextStyle(fontSize: 14, color: Colors.white),
//                 onChanged: (value){
//                   setState((){
//                     email = value;
//                   });
//                 },
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//             const SizedBox(height: 30,),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: CustomColor.mediumColor),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: CustomColor.mediumColor),
//                   ),
//                   border: UnderlineInputBorder(
//                     borderSide: BorderSide(color: CustomColor.mediumColor),
//                   ),
//                   labelText: "Password",
//                   labelStyle: TextStyle(color: Colors.grey),
//                 ),
//                 style: const TextStyle(fontSize: 14, color: Colors.white),
//                 onChanged: (value){
//                   setState((){
//                     pass = value;
//                   });
//                 },
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//             const SizedBox(height: 50,),
//             SizedBox(
//               width: 300,
//               height: 50,
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(CustomColor.darkColor,),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18.0),))
//                 ),
//                 onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) => const HomePage())
//                 ),
//                 child: Text(
//                   "Log in",
//                   style: TextStyle(
//                       color: CustomColor.blackColor,
//                       fontSize: 22,
//                       letterSpacing: 2
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15,),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                       // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterPage1())),
//                       child: Text("Forget passwords?", style: TextStyle(fontSize: 15, color: CustomColor.mediumColor),)
//                   ),
//                   const Spacer(),
//                   GestureDetector(
//                       onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterPage1())),
//                       child: Text("Create an account", style: TextStyle(fontSize: 15, color: CustomColor.mediumColor),)
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
