import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

import '0CustomColors.dart';
import '0DataBase.dart';
import '1LoginPage.dart';
import '3SettingPage.dart';
import '4SearchItem.dart';
import '5RegisterProduct.dart';
import '8PreviousOrder.dart';
import '9YourProducts.dart';
import '10Purchase.dart';
import '11FreeDelivery.dart';
import '12NearMe.dart';
import '13ShowingSingleProduct.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final DataBase _db = DataBase();
  bool homeAdd = false;
  String userID = "";

  late Future<List<FirebaseFile>> futureFiles;

  DateTime currentBackPressTime = DateTime.now();

  Future getUserID() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('UserID')!;
  }

  Future<void> setLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  static const iconList = ["assets/order.png", "assets/product.png", "assets/purchase.png", "assets/delivery.jpg", "assets/near-me.png", "assets/profile.png", "assets/sign-out.png"];
  static const picksList = ["assets/mobile.png", "assets/Electronics.png", "assets/cars.png", "assets/cosmetics.png", "assets/laptops.png"];

  static const iconType = ["Previous Orders", "Your Products", "Purchase", "Free Delivery", "Near Me", "Profile", "Sign Out"];
  static const picksType = ["Mobiles", "Electronics", "Cars", "Cosmetics", "Laptops"];

  @override
  initState() {
    super.initState();
    setLogin();
    getUserID();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press back again to exit");
      return Future.value(false);
    } else {
      SystemNavigator.pop();
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, data){
        return FutureBuilder<GetSignInUserData?>(
            future: _db.getUserData(userID),
            builder: (context, snapshot){
              if (snapshot.hasData){
                final user = snapshot.data;
                var add = user!.add;
                homeAdd = true;
                futureFiles = FirebaseApi.listAll(user.name);
                return WillPopScope(
                  onWillPop: onWillPop,
                  child: Scaffold(
                    extendBody: true,
                    backgroundColor: CustomColor.background,
                    appBar: AppBar(
                      // automaticallyImplyLeading: false,
                      backgroundColor: CustomColor.darkColor,
                      elevation: 0,
                      title: homeAdd && add != "Null"
                          ? Text(add, style: TextStyle(color: CustomColor.whiteColor, fontSize: 14),)
                          : Text("Select Home Address", style: TextStyle(color: CustomColor.whiteColor, fontSize: 14),),
                    ),
                    drawer: Drawer(
                        backgroundColor: CustomColor.background,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 30, 0, 20),
                              decoration: BoxDecoration(
                                color: CustomColor.darkColor,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(18.0),
                                    bottomRight: Radius.circular(18.0)
                                ),
                              ),
                              child: Row(
                                children: [
                                  currentUser.photoURL == null
                                    ? FutureBuilder<List<FirebaseFile>>(
                                      future: futureFiles,
                                      builder: (context, snap){
                                        if(snap.hasData) {
                                          final files = snap.data!;
                                          return ClipOval(child: SizedBox(height: 100, width: 100, child: Image.network(files[0].url, fit: BoxFit.fill,),),);
                                        }else{
                                          return const CircularProgressIndicator();
                                        }
                                      }
                                    )
                                      : ClipOval(child: SizedBox(height: 100, width: 100, child: Image(image: NetworkImage(currentUser.photoURL!), fit: BoxFit.fill,),),),
                                  const SizedBox(width: 15,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(user.name, style: TextStyle(fontSize: 18, color: CustomColor.whiteColor),),
                                      Text(user.email, style: TextStyle(fontSize: 13, color: CustomColor.whiteColor),)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 7,
                                itemBuilder: (BuildContext context, int index) {
                                  return topicList(iconList[index], iconType[index], index, user.name);
                                },
                              ),
                            ),
                          ],
                        )
                    ),
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text(
                                "Hi, ${user.name}",
                                style: TextStyle(color: CustomColor.blackColor, fontSize: 20, fontFamily: "Rotunda-Medium"),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => SearchItem(padding: 35,))
                                    ),
                                    child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        height: 200,
                                        width: MediaQuery.of(context).size.width / 2.3,
                                        decoration: BoxDecoration(
                                          color: CustomColor.whiteColor,
                                          borderRadius: BorderRadius.circular(18),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 2),
                                                blurRadius: 3,
                                                color: Colors.grey.shade400
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Search for an item",
                                              style: TextStyle(fontSize: 18, color: CustomColor.blackColor),
                                            ),
                                            Spacer(),
                                            Container(
                                                child: Lottie.asset("assets/47336-online-shopping-search-product-concept-animation.json")
                                            )
                                          ],
                                        )
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => const RegisterProduct())
                                    ),
                                    child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        height: 200,
                                        width: MediaQuery.of(context).size.width / 2.3,
                                        decoration: BoxDecoration(
                                            color: CustomColor.whiteColor,
                                            borderRadius: BorderRadius.circular(18),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(0, 2),
                                                  blurRadius: 3,
                                                  color: Colors.grey.shade400
                                              )
                                            ]
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Post your product",
                                              style: TextStyle(fontSize: 18, color: CustomColor.blackColor),
                                            ),
                                            Spacer(),
                                            Container(
                                                child: Lottie.asset("assets/79799-add-product.json"))
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text(
                                "Top Picks",
                                style: TextStyle(color: CustomColor.blackColor, fontSize: 18, fontFamily: "Rotunda-Medium"),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                              child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: 5,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
                                itemBuilder: (BuildContext context, int index) {
                                  return picksCard(index);
                                },
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text(
                                "Products",
                                style: TextStyle(color: CustomColor.blackColor, fontSize: 18, fontFamily: "Rotunda-Medium"),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 13,
                                itemBuilder: (BuildContext context, int index) {
                                  return productListView(productList[index], index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }else if(snapshot.connectionState == ConnectionState.waiting){
                return Scaffold(backgroundColor: CustomColor.background, body: const Center(child: CircularProgressIndicator()));
              }else{
                return Scaffold(backgroundColor: CustomColor.background, body: const Center(child: Text("Something went wrong!"),));
              }
            }
        );
      },

    );
  }

  Widget picksCard(int index) {
    return Container(
      margin: const EdgeInsets.only(left: 7, right: 7, bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 3,
              color: Colors.grey.shade400
          )
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: Image(
              image: AssetImage(picksList[index]),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10,),
          Text(picksType[index], style: TextStyle(color: CustomColor.darkColor, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

  Widget productListView(Product product, int index) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: CustomColor.whiteColor,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 2),
          blurRadius: 3,
          color: Colors.grey.shade300
        )
      ]
    ),
    child: InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ShowingSingleProduct())
      ),
      child: ListTile(
        leading: Image(image: AssetImage(product.pic),),
        title: Text(product.name, style: TextStyle(fontSize: 18, color: CustomColor.mediumColor, fontWeight: FontWeight.bold),),
        subtitle: Row(
          children: [
            Text("${product.price} OMR",), //${product.price.toString()}
            SizedBox(width: 20,),
            Icon(Icons.star, color: Colors.yellow,),
            Text(product.star.toString(),),
            SizedBox(width: 20,),
            Icon(Icons.delivery_dining, color: Colors.black),
            Text(product.delivery)
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: CustomColor.mediumColor,
        ),
      ),
    ),
  );

  static List<Product> productList = [
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 4.2),
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 4.1),
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 2.2),
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 3.6),
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 3.7),
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 1.5),
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 2.6),
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 4.9),
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 2.0),
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 3.6),
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 3.5),
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 2.9),
    Product(pic: "assets/package.png", name: "ProductName", delivery: "Free", price: "9.8", star: 4.2),
  ];

  Widget topicList(String pic, String txt, int index, String name) => InkWell(
    onTap: () async {
      if(index == 0){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const PreviousOrder()
        ));
      }
      if(index == 1){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const YourProducts()
        ));
      }
      if(index == 2){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Purchase()
        ));
      }
      if(index == 3){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const FreeDelivery()
        ));
      }
      if(index == 4){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NearMe()
        ));
      }
      if(index == 5){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Setting(name: name)
        ));
      }
      if(index == 6){
        FirebaseAuth.instance.signOut();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LoginPage()
        ));
      }
    },
    child: Container(
      width: 65,
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            width: 50,
            height: 50,
            child: Image(
              image: AssetImage(pic),
              color: CustomColor.mediumColor,
            ),
          ),
          const SizedBox(width: 12,),
          Text(
            txt,
            style: TextStyle(fontSize: 13, color: CustomColor.blackColor,),
            // textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}

class Product{
  String pic;
  String name;
  String delivery;
  double star;
  String? price;
  Product({required this.pic, required this.name, required this.delivery, required this.price, required this.star});
}

class Business{
  String pic;
  String businessName;
  String description;
  String location;
  Business({required this.pic, required this.businessName, required this.description, required this.location});
}