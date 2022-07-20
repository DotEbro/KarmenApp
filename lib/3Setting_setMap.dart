import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import '0CustomColors.dart';
import '0DataBase.dart';

class SetMap extends StatefulWidget {
  String uid;
  SetMap({Key? key, required this.uid}) : super(key: key);

  @override
  State<SetMap> createState() => _SetMapState();
}

const kGoogleApiKey =  "AIzaSyBKeUyZbrb94ju6Km9Goe47zKLxNVhJO1E";
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _SetMapState extends State<SetMap> {

  Position? position;
  double? lat;
  double? lng;
  String address = "Select Home Address";
  bool showProgress = false;

  static CameraPosition? initialCameraPosition;
  Set<Marker> markersList = {};
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;

  BitmapDescriptor? mapIcon;

  final DataBase _db = DataBase();

  void getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    lng = position.longitude;
    initialCameraPosition = CameraPosition(target: LatLng(lat ?? 34.025917, lng ?? 71.560135), zoom: 14.0, tilt: 80);
  }

  @override
  initState(){
    super.initState();
    getPosition();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      key: homeScaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColor.darkColor,
        title: address != "Select Home Address"
            ? Text(address, style: TextStyle(color: CustomColor.whiteColor),)
            : Text("Select Home Address", style: TextStyle(color: CustomColor.whiteColor),),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: initialCameraPosition ?? CameraPosition(target: LatLng(lat ?? 34.025917, lng ?? 71.560135), zoom: 14.0, tilt: 80),
            markers: markersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
            onTap: (latLong) {
              setState(() {showProgress = true;});
              showMarker(latLong);
            },
          ),
          Align(
              alignment: Alignment.topCenter,
              child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(CustomColor.darkColor,),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)
                      )
                  ),
                  icon: const Icon(Icons.search),
                  onPressed: _handlePressButton,
                  label: const Text("Search Places...", style: TextStyle(fontSize: 18),)
              )
          ),
          showProgress
            ? Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  color: CustomColor.mediumColor,
                )
              )
            )
            : Positioned(
              left: (MediaQuery.of(context).size.width / 2) - 150,
              bottom: 30,
              child: SizedBox(
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
                  onPressed: () {
                    dynamic value = _db.saveLocation(address, lat!, lng!, widget.uid);
                    if(value != null) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                        color: CustomColor.blackColor,
                        fontSize: 22,
                        letterSpacing: 2
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> showMarker(LatLng latLong) async {
    List<Placemark> addresses = await placemarkFromCoordinates(latLong.latitude, latLong.longitude);
    var first = addresses.first;
    setState(() {
      markersList.add(Marker(
        markerId: MarkerId("Position"),
        position: LatLng(latLong.latitude, latLong.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: "${first.street}, ${first.locality}"),
      ));
      // print('${first.locality},${first.subLocality},${first.thoroughfare}, ${first.subThoroughfare}');
      showProgress = false;
      address = "${first.street}, ${first.locality}";
      lat = latLong.latitude;
      lng = latLong.longitude;
    });
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {

    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders()
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    setState(() {
      lat = detail.result.geometry!.location.lat;
      lng = detail.result.geometry!.location.lng;

      address = detail.result.name;

      markersList.clear();
      markersList.add(
          Marker(
              markerId: const MarkerId("Position"),
              position: LatLng(lat!, lng!),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
              infoWindow: InfoWindow(title: address)
          )
      );
    });

    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat!, lng!), 14.0));

  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: (response) => homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!))),
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))),
        components: [
          Component(Component.country,"pk"),
          Component(Component.country,"usa"),
        ]
    );
    displayPrediction(p!,homeScaffoldKey.currentState);
  }
}
