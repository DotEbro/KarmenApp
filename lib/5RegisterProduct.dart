import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '0CustomColors.dart';
import '6ReviewProduct.dart';

class RegisterProduct extends StatefulWidget {
  const RegisterProduct({Key? key}) : super(key: key);

  @override
  State<RegisterProduct> createState() => _RegisterProductState();
}

class _RegisterProductState extends State<RegisterProduct> {

  String? catString = "Select";
  var catSet = {"Select" : "Select", "Mobile" : "MB", "Vehicles" : "Ve", "Property for Sale" : "PS", "Property for Rent" : "PR",
    "Electronics & Home Appliances" : "EHA", "Bike" : "BI", "Business, Industrial & Agriculture" : "BIA", "Service" : "SER",
    "Jobs" : "JOB", "Animals" : "ANI", "Furniture & Home Decor" : "FHD", "Fashion & Beauty" : "FB", "Books, Sports & Hobbies" : "BSH", "Kids" : "KID"};
  List catList = [];
  catFunction(){
    catSet.forEach((key, value) {
      catList.add(key);
    });
  }

  String? subCatString = "";
  var subCatSet = {"Tablets" : "MB", "Accessories" : "MB", "Mobile Phones" : "MB", "Smart Watches" : "MB",
    "Cars" : "Ve", "Cars on Installments" : "Ve", "Cars Accessories" : "Ve", "Spare Parts" : "Ve",
    "Buses, Vans & Trucks" : "Ve", "Other Vehicles" : "Ve", "Boats" : "Ve", "Tractors & Trailers" : "Ve",
    "Land & Plots" : "PS", "Houses" : "PS", "Apartments & Flats" : "PS", "Shops, Offices, Commercial Space" : "PS",
    "Portions & Floors" : "PS",
    "Apartments and Flats" : "PR", "Portions and Floors" : "PR", "Shops, Offices and Commercial Space" : "PR",
    "Roommates & Paying Guests" : "PR", "Rooms" : "PR", "Vacation Rentals, Guest Houses" : "PR", "Land and Plots" : "PR",
    "Computer & Accessories" : "EHA", "TV - Video - Audio" : "EHA", "Cameras & Accessories" : "EHA",
    "Games & Entertainment" : "EHA", "Other HOme Appliances" : "EHA", "Generators UPS & Power Solution" : "EHA",
    "Kitchen Appliances" : "EHA", "Ac & Coolers" : "EHA", "Fridges & Freezers" : "EHA", "Washing Machines & Dryers" : "EHA",
    "Motorcycles" : "BI", "Spare-Parts" : "BI", "Bicycles" : "BI", "ATV & Quads" : "BI", "Scooters" : "BI",
    "Business for Sale" : "BIA", "Food & Restaurants" : "BIA", "Trade & Industrial" : "BIA", "Construction & Heavy Machinery" : "BIA",
    "Agriculture" : "BIA", "Other Business & Industry" : "BIA", "Medical & Pharma" : "BIA",
    "Education and Classes" : "SER", "Travel and Visa" : "SER", "Car Rental" : "SER", "Driver & Taxi" : "SER", "Web Development" : "SER",
    "Other Services" : "SER", "Electronic & Computer Repair" : "SER", "Event Service" : "SER", "Health & Beauty" : "SER",
    "Maids & Domestic Help" : "SER", "Movers and Packers" : "SER", "Home & Office Repair" : "SER", "Catering & Restaurant" : "SER",
    "Farm & Fresh Food" : "SER",
    "Online" : "JOB", "Marketing" : "JOB", "Advertising & PR" : "JOB", "Education" : "JOB", "Customer Service" : "JOB", "Sales" : "JOB", "IT & Networking" : "JOB",
    "Hotels and Tourism" : "JOB", "Clerical & Administration" : "JOB", "Human Resources" : "JOB", "Accounting & Finance" : "JOB", "Manufacturing" : "JOB",
    "Medical" : "JOB", "Domestic Stuff" : "JOB", "Part - Time" : "JOB", "Other Jobs" : "JOB",
    "Fish & Aquariums" : "ANI", "Birds" : "ANI", "Hens & Aseel" : "ANI", "Cats" : "ANI", "Dogs" : "ANI", "Livestock" : "ANI", "Horses" : "ANI", "Pet Food & Accessories" : "ANI",
    "Other Animals" : "ANI",
    "Sofa & Chairs" : "FHD", "Beds & Wardrobes" : "FHD", "Home Decoration" : "FHD", "Tables & Dining" : "FHD", "Garden & Outdoor" : "FHD",
    "Painting & Mirrors" : "FHD", "Rugs & Carpets" : "FHD", "Curtains and Blinds" : "FHD", "Office Furniture" : "FHD", "Other Household items" : "FHD",
    "Fashion Accessories" : "FB", "Clothes" : "FB", "Footwear" : "FB", "Jewellery" : "FB", "Make Up" : "FB", "Skin & Hair" : "FB", "Watches" : "FB", "Wedding" : "FB",
    "Lawn & Pret" : "FB", "Couture" : "FB", "Other Fashion" : "FB",
    "Books & Magazines" : "BSH", "Musical Instruments" : "BSH", "Sports Equipment" : "BSH", "Gym & Fitness" : "BSH", "Other Hobbies" : "BSH",
    "Kids Furniture" : "KID", "Toys" : "KID", "Prams & Walkers" : "KID", "Swings & Slides" : "KID", "Kids Bikes" : "KID", "Kids Accessories" : "KID",
  };
  List subCatList = [];
  subCatFunction(catCode){
    subCatList.add("Select");
    subCatSet.forEach((key, value) {
      if(catCode == value) {
        subCatList.add(key);
      }
    });
    subCatString = "Select";
  }

  String? accString = "Select";
  var accSet = {"Select" : "Accessories", "Charging Cables" : "Accessories", "Converters" : "Accessories",
    "Chargers" : "Accessories", "Screens" : "Accessories", "Screen Protectors" : "Accessories",
    "Mobile Stands" : "Accessories", "Ring Lights" : "Accessories", "Selfie Stick" : "Accessories",
    "Power Banks" : "Accessories", "Headphones" : "Accessories", "Earphones" : "Accessories",
    "Covers & Cases" : "Accessories", "External Memory" : "Accessories", "Other Accessories" : "Accessories"};
  List accList = [];
  accFunction(){
    accSet.forEach((key, value) {
      accList.add(key);
    });
    accString = "Select";
  }

  String? productName;
  String? brandCompany;
  String? description;
  String? price;
  String? quantity;
  String? pColors;
  String? warranty;
  String? weight;
  String? length;
  String? height;
  String? width;

  bool _isRadioSelected = false;

  String? returnString = "Select";
  static const returnList = ["Select","3 days", "5 days", "7 days", "10 days", "15 days", "1 month"];

  int activeIndex = 0;
  List<PlatformFile>? uploadImages;

  @override
  void initState(){
    super.initState();
    catFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Post your Product", style: TextStyle(color: CustomColor.mediumColor),),
        backgroundColor: CustomColor.darkColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 9, 15, 15),
              margin:  const EdgeInsets.fromLTRB(14, 30, 14, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: CustomColor.boxColor
              ),
              child: Column(
                children: [
                  Align(alignment: Alignment.topLeft, child: Text("Categories", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: Theme(
                      data: Theme.of(context).copyWith(canvasColor: CustomColor.darkColor,),
                      child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: CustomColor.darkColor,
                          size: 37,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColor.mediumColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColor.mediumColor),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColor.mediumColor),
                          ),
                        ),
                        value: catString,
                        items: catList.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        )).toList(),
                        onChanged: (item) {
                          setState(() {
                            subCatList = [];
                            subCatFunction(catSet[item]);
                            catString = "$item";
                          });
                        },
                        style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      ),
                    ),
                  ),
                  catString != "Select" && catString != "" ? Align(alignment: Alignment.topLeft, child: Text("Sub Categories", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)) : Text(""),
                  catString != "Select" && catString != "" ?  Container(
                    height: 60,
                    width: double.infinity,
                    child: Theme(
                      data: Theme.of(context).copyWith(canvasColor: CustomColor.darkColor,),
                      child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: CustomColor.darkColor,
                          size: 37,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColor.mediumColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColor.mediumColor),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColor.mediumColor),
                          ),
                        ),
                        value: subCatString,
                        items: subCatList.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        )).toList(),
                        onChanged: (item) {
                          setState((){
                            accList = [];
                            accFunction();
                            subCatString = "$item";
                          });
                        },
                        style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      ),
                    ),
                  ) : Container(),
                  subCatString == "Accessories" ? Align(alignment: Alignment.topLeft, child: Text("Type of Accessories", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)) : Text(""),
                  subCatString == "Accessories" ? Container(
                    height: 60,
                    width: double.infinity,
                    child: Theme(
                      data: Theme.of(context).copyWith(canvasColor: CustomColor.darkColor,),
                      child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: CustomColor.darkColor,
                          size: 37,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColor.mediumColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColor.mediumColor),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColor.mediumColor),
                          ),
                        ),
                        value: accString,
                        items: accList.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        )).toList(),
                        onChanged: (item) => setState(() => accString = "$item"),
                        style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      ),
                    ),
                  ) : Container(),
                ],
              )
            ),
            const SizedBox(height: 18,),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 9, 15, 15),
              margin:  const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: CustomColor.boxColor
              ),
              child: Column(
                children: [
                  Align(alignment: Alignment.topLeft, child: Text("Title", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                      ),
                      style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      onChanged: (value){
                        setState((){
                          productName = value;
                        });
                      },
                    ),
                  ),
                  Align(alignment: Alignment.topLeft, child: Text("Brand/Company", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                      ),
                      style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      onChanged: (value){
                        setState((){
                          brandCompany = value;
                        });
                      },
                    ),
                  ),
                  Align(alignment: Alignment.topLeft, child: Text("Product Description", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                      ),
                      style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      onChanged: (value){
                        setState((){
                          description = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18,),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 9, 15, 15),
              margin:  const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: CustomColor.boxColor
              ),
              child: Column(
                children: [
                  Align(alignment: Alignment.topLeft, child: Text("Quantity", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                      ),
                      style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      onChanged: (value){
                        setState((){
                          price = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Align(alignment: Alignment.topLeft, child: Text("Price", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)),
                  Container(
                    height: 60,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                      ),
                      style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      onChanged: (value){
                        setState((){
                          price = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LabeledRadio(
                  label: 'Warranty',
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  value: true,
                  groupValue: _isRadioSelected,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isRadioSelected = newValue;
                      warranty = "Warranty";
                    });
                  },
                ),
                const SizedBox(width: 30,),
                LabeledRadio(
                  label: 'Non Warranty',
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  value: false,
                  groupValue: _isRadioSelected,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isRadioSelected = newValue;
                      warranty = "Non Warranty";
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 18,),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 9, 15, 15),
              margin:  const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: CustomColor.boxColor
              ),
              child: Column(
                children: [
                  Align(alignment: Alignment.topLeft, child: Text("Return product within", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: Theme(
                      data: Theme.of(context).copyWith(canvasColor: CustomColor.darkColor,),
                      child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: CustomColor.darkColor,
                          size: 37,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColor.mediumColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColor.mediumColor),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColor.mediumColor),
                          ),
                        ),
                        value: returnString,
                        items: returnList.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        )).toList(),
                        onChanged: (item) {
                          setState(() {
                            returnString = "$item";
                          });
                        },
                        style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18,),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 9, 15, 15),
              margin:  const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: CustomColor.boxColor
              ),
              child: Column(
                children: [
                  Align(alignment: Alignment.topLeft, child: Text("Variation/Colors", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                      ),
                      style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      onChanged: (value){
                        setState((){
                          pColors = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18,),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 9, 15, 15),
              margin:  const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: CustomColor.boxColor
              ),
              child: Column(
                children: [
                  Align(alignment: Alignment.topLeft, child: Text("Weight(Kg)", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                      ),
                      style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      onChanged: (value){
                        setState((){
                          weight = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Align(alignment: Alignment.topLeft, child: Text("Length(cm)", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)),
                  Container(
                    height: 60,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                      ),
                      style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      onChanged: (value){
                        setState((){
                          length = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Align(alignment: Alignment.topLeft, child: Text("Width(cm)", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)),
                  Container(
                    height: 60,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                      ),
                      style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      onChanged: (value){
                        setState((){
                          width = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Align(alignment: Alignment.topLeft, child: Text("Height(cm)", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),)),
                  Container(
                    height: 60,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.mediumColor),
                        ),
                      ),
                      style: TextStyle(fontSize: 14, color: CustomColor.blackColor),
                      onChanged: (value){
                        setState((){
                          height = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              margin:  const EdgeInsets.symmetric(horizontal: 14),
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: CustomColor.boxColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: uploadImages == null
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload, size: 120, color: CustomColor.darkColor,),
                      const SizedBox(height: 18,),
                      Text("Upload Files here", style: TextStyle(color: Colors.white, fontSize: 28),),
                      const SizedBox(height: 18,),
                      SizedBox(
                        width: 280,
                        height: 55,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(CustomColor.darkColor),
                          ),
                          onPressed: () async{
                            final result = await FilePicker.platform.pickFiles(allowMultiple: true);
                            if (result == null) return;
                            setState(() {
                              uploadImages = result.files;
                              // openFiles(result.files);
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search, size: 36, color: Colors.black,),
                              const SizedBox(height: 18,),
                              Text("Choose Files", style: TextStyle(fontSize: 22, color: Colors.black),),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18,),
                      Text("Max file size 500kb",
                        style: TextStyle(color: Colors.white, fontSize: 14),),
                    ],
                  )
                  : Column(
                    children: [
                      Expanded(
                        child: CarouselSlider.builder(
                            itemCount: uploadImages?.length,
                            itemBuilder: (context, index, realIndex) {
                              final file = uploadImages![index];
                              return showPic(file);
                            },
                            options: CarouselOptions(
                              height: double.infinity - 50,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) => setState(() => activeIndex = index),
                            )
                        ),
                      ),
                      const SizedBox(height: 18,),
                      AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: uploadImages!.length,
                        effect: SlideEffect(
                          dotWidth: 12,
                          dotHeight: 12,
                          activeDotColor: CustomColor.background,
                          dotColor: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 18,),
                    ],
                  ),
            ),
            const SizedBox(height: 33,),
            SizedBox(
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
                    builder: (BuildContext context) => const ReviewProduct())
                ),
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
            const SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }
  showPic(PlatformFile file) {
    final picPath = file.path;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14),
      child: Image(
        image: AssetImage(picPath!),
      ),
    );
  }
}


class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: CustomColor.boxColor
        ),
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              Radio<bool>(
                hoverColor: CustomColor.darkColor,
                groupValue: groupValue,
                value: value,
                onChanged: (bool? newValue) {
                  onChanged(newValue!);
                },
              ),
              Text(label, style: TextStyle(fontSize: 18, color: CustomColor.mediumColor),),
            ],
          ),
        ),
      ),
    );
  }
}