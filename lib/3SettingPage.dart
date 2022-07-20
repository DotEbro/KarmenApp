import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '0CustomColors.dart';
import '0DataBase.dart';
import '3Setting_setMap.dart';

class Setting extends StatefulWidget {
  String name;
  Setting({Key? key, required this.name}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  late Future<List<FirebaseFile>> futureFiles;
  final DataBase _db = DataBase();
  TextEditingController valueController = TextEditingController();
  String userID = "";

  Future getUserID() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('UserID')!;
  }


  bool editName = false;
  bool editPhone = false;

  @override
  initState(){
    super.initState();
    futureFiles = FirebaseApi.listAll(widget.name);
    getUserID();
  }

  @override
  Widget build(BuildContext context) {

    final currentUser = FirebaseAuth.instance.currentUser!;

    return FutureBuilder<GetSignInUserData?>(
      future: _db.getUserData(userID),
      builder: (context, snapshot){
        if (snapshot.hasData){
          final _user = snapshot.data;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: CustomColor.background,
            appBar: AppBar(
              backgroundColor: CustomColor.darkColor,
              elevation: 0,
              title: Text("Profile", style: TextStyle(color: CustomColor.whiteColor, fontSize: 22),),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
              child: Column(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: CustomColor.whiteColor,
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Colors.black38
                        )
                      ]
                    ),
                    child: Column(
                      children: [
                        currentUser.photoURL == null
                          ? FutureBuilder<List<FirebaseFile>>(
                            future: futureFiles,
                            builder: (context, snapshot){
                              final files = snapshot.data!;
                              return Center(
                                child: ClipOval(
                                  child: SizedBox(
                                    height: 170,
                                    width: 170,
                                    child: Image.network(files[0].url, fit: BoxFit.fill,),
                                  ),
                                ),
                              );
                            },
                          )
                          : Center(
                            child: ClipOval(
                              child: SizedBox(
                                height: 170,
                                width: 170,
                                child: Image(
                                  image: NetworkImage(currentUser.photoURL!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 16,),
                        Text(
                          _user!.name,
                          style: TextStyle(color: CustomColor.blackColor,fontSize: 16),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          _user.email,
                          style: TextStyle(color: CustomColor.blackColor,fontSize: 16),
                        ),
                      ],
                    )
                  ),
                  const SizedBox(height: 30,),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            color: Colors.black38
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: CustomColor.darkColor,
                          size: 30,
                        ),
                        SizedBox(width: 15,),
                        editName
                          ? SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: TextFormField(
                                controller: valueController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                          )
                          : Text(
                          _user.name,
                          style: TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        editName
                        ? IconButton(
                            onPressed: (){
                              _db.updateValue("FullName", valueController.text, userID);
                              setState((){
                                editName = !editName;
                              });
                            },
                            icon: Icon(Icons.check_circle_outline, color: Colors.green,),
                          )
                        : IconButton(
                            onPressed: (){
                              setState((){
                                if(editPhone){
                                  Fluttertoast.showToast(
                                    msg: "Please confirm your Phone Number first",
                                    textColor: Colors.white,
                                  );
                                }else{
                                  valueController.text = _user.name;
                                  editName = !editName;
                                }
                              });
                            },
                            icon: Icon(Icons.edit, color: Colors.blue,),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 18,),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            color: Colors.black38
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: CustomColor.darkColor,
                          size: 30,
                        ),
                        SizedBox(width: 15,),
                        editPhone
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: TextFormField(
                                controller: valueController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            )
                          : Text(
                              _user.contact,
                              style: TextStyle(fontSize: 14),
                            ),
                        Spacer(),
                      editPhone
                        ? IconButton(
                          onPressed: (){
                            _db.updateValue("ContactNumber", valueController.text, userID);
                            setState((){
                              editPhone = !editPhone;
                            });
                          },
                          icon: Icon(Icons.check_circle_outline, color: Colors.green,),
                        )
                        : IconButton(
                          onPressed: (){
                            setState((){
                              if(editName){
                                Fluttertoast.showToast(
                                    msg: "Please confirm your Name first",
                                    textColor: Colors.white,
                                );
                              }else{
                                valueController.text = _user.contact;
                                editPhone = !editPhone;
                              }
                            });
                          },
                          icon: Icon(Icons.edit, color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 18,),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SetMap(uid: userID))
                    ),
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              color: Colors.black38
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: CustomColor.darkColor,
                            size: 30,
                          ),
                          SizedBox(width: 15,),
                          Text(
                            _user.add,
                            style: TextStyle(fontSize: 14),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18,),
                  InkWell(
                    onTap: () => Fluttertoast.showToast(
                      msg: "Sorry! you can not edit your Email",
                      textColor: Colors.white
                    ),
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              color: Colors.black38
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: CustomColor.darkColor,
                            size: 30,
                          ),
                          SizedBox(width: 15,),
                          Text(
                            _user.email,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }else if(snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(backgroundColor: CustomColor.background, body: const Center(child: CircularProgressIndicator()));
        }else{
          print(userID);
          return Scaffold(backgroundColor: CustomColor.background, body: const Center(child: Text("Something went wrong!"),));
        }
      }
    );
  }

  // Future showMap() async {
  //   String address = "Select Home Address";
  //   bool showProgress = false;
  //
  //   Set<Marker> markersList = {};
  //   late GoogleMapController googleMapController;
  //   const Mode _mode = Mode.overlay;
  //
  //   BitmapDescriptor? mapIcon;
  //
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   var lat = position.latitude;
  //   var long = position.longitude;
  //   var initialCameraPosition = CameraPosition(target: LatLng(lat, long), zoom: 14.0, tilt: 80);
  //
  //   Future<void> showMarker(LatLng latLong) async {
  //     List<Placemark> addresses = await placemarkFromCoordinates(latLong.latitude, latLong.longitude);
  //     var first = addresses.first;
  //     setState(() {
  //       markersList.add(Marker(
  //         markerId: MarkerId("Position"),
  //         position: LatLng(latLong.latitude, latLong.longitude),
  //         icon: BitmapDescriptor.defaultMarkerWithHue(
  //             BitmapDescriptor.hueGreen),
  //         infoWindow: InfoWindow(title: "${first.street}, ${first.locality}"),
  //       ));
  //       // print('${first.locality},${first.subLocality},${first.thoroughfare}, ${first.subThoroughfare}');
  //       showProgress = false;
  //       address = "${first.street}, ${first.locality}";
  //       lat = latLong.latitude;
  //       long = latLong.longitude;
  //     });
  //   }
  //
  //   Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {
  //
  //     GoogleMapsPlaces places = GoogleMapsPlaces(
  //         apiKey: kGoogleApiKey,
  //         apiHeaders: await const GoogleApiHeaders().getHeaders()
  //     );
  //
  //     PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
  //
  //     setState(() {
  //       lat = detail.result.geometry!.location.lat;
  //       long = detail.result.geometry!.location.lng;
  //
  //       address = detail.result.name;
  //
  //       markersList.clear();
  //       markersList.add(
  //           Marker(
  //               markerId: const MarkerId("Position"),
  //               position: LatLng(lat, long),
  //               icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //               infoWindow: InfoWindow(title: address)
  //           )
  //       );
  //     });
  //
  //     googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), 14.0));
  //
  //   }
  //
  //   Future<void> _handlePressButton() async {
  //     Prediction? p = await PlacesAutocomplete.show(
  //         context: context,
  //         apiKey: kGoogleApiKey,
  //         onError: (response) => homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!))),
  //         mode: _mode,
  //         language: 'en',
  //         strictbounds: false,
  //         types: [""],
  //         decoration: InputDecoration(
  //             hintText: 'Search',
  //             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))),
  //         components: [
  //           Component(Component.country,"pk"),
  //           Component(Component.country,"usa"),
  //         ]
  //     );
  //     displayPrediction(p!,homeScaffoldKey.currentState);
  //   }
  //
  //   return showModalBottomSheet(
  //       isScrollControlled: true,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //       ),
  //       context: context,
  //       builder: (context) {
  //         return Scaffold(
  //           backgroundColor: CustomColor.background,
  //           key: homeScaffoldKey,
  //           appBar: AppBar(
  //             automaticallyImplyLeading: false,
  //             backgroundColor: CustomColor.darkColor,
  //             title: address != "Select Home Address"
  //                 ? Text(address, style: TextStyle(color: CustomColor.whiteColor),)
  //                 : Text("Select Home Address", style: TextStyle(color: CustomColor.whiteColor),),
  //           ),
  //           body: Stack(
  //             children: [
  //               GoogleMap(
  //                 mapToolbarEnabled: false,
  //                 zoomControlsEnabled: false,
  //                 initialCameraPosition: initialCameraPosition,
  //                 markers: markersList,
  //                 mapType: MapType.normal,
  //                 onMapCreated: (GoogleMapController controller) {
  //                   googleMapController = controller;
  //                 },
  //                 onTap: (latLong) {
  //                   setState(() {showProgress = true;});
  //                   showMarker(latLong);
  //                 },
  //               ),
  //               Align(
  //                 alignment: Alignment.topCenter,
  //                 child: ElevatedButton.icon(
  //                   style: ButtonStyle(
  //                     backgroundColor: MaterialStateProperty.all(CustomColor.darkColor,),
  //                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                         RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)
  //                     )
  //                   ),
  //                   icon: const Icon(Icons.search),
  //                   onPressed: _handlePressButton,
  //                   label: const Text("Search Places...", style: TextStyle(fontSize: 18),)
  //                 )
  //               ),
  //               showProgress
  //                 ? Align(
  //                   alignment: Alignment.center,
  //                   child: SizedBox(
  //                     height: 100,
  //                     width: 100,
  //                     child: CircularProgressIndicator(
  //                       color: CustomColor.mediumColor,
  //                     )
  //                   )
  //                 )
  //                 : Positioned(
  //                   left: (MediaQuery.of(context).size.width / 2) - 150,
  //                   bottom: 30,
  //                   child: SizedBox(
  //                     width: 300,
  //                     height: 50,
  //                     child: ElevatedButton(
  //                       style: ButtonStyle(
  //                           backgroundColor: MaterialStateProperty.all(CustomColor.darkColor,),
  //                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                               RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(18.0),
  //                               )
  //                           )
  //                       ),
  //                       onPressed: ()=> Navigator.pop(context),
  //                       child: Text(
  //                         "Confirm",
  //                         style: TextStyle(
  //                             color: CustomColor.blackColor,
  //                             fontSize: 22,
  //                             letterSpacing: 2
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         );
  //       }
  //   );
  // }
}
