import 'package:flutter/material.dart';

import '0CustomColors.dart';

class SearchItem extends StatefulWidget {
  double padding;
  SearchItem({Key? key, required this.padding}) : super(key: key);

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {

  String? searchedKeyword;

  @override
  initState(){
    searchedKeyword = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      body: Padding(
        padding: EdgeInsets.fromLTRB(14, 30 + widget.padding, 14, 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 330,
                height: 70,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CustomColor.mediumColor),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CustomColor.mediumColor),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: CustomColor.mediumColor),
                        borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                  style: TextStyle(fontSize: 18, color: CustomColor.blackColor),
                  onChanged: (value){
                    setState((){
                      searchedKeyword = value;
                    });
                  },
                ),
              ),
              searchedKeyword == ""
                ? Column(
                  children: [
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Popular searches",
                        style: TextStyle(fontSize: 22, color: CustomColor.blackColor),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: CustomColor.darkColor)
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.trending_up, color: CustomColor.boxColor),
                                  SizedBox(width: 5,),
                                  Text("Laptop", style: TextStyle(color: CustomColor.darkColor),)
                                ],
                              )
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: CustomColor.darkColor)
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                      Icons.trending_up,
                                      color: CustomColor.boxColor
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Mobile", style: TextStyle(color: CustomColor.darkColor),)
                                ],
                              )
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: CustomColor.darkColor)
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    color: CustomColor.boxColor,
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Cars", style: TextStyle(color: CustomColor.darkColor),)
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: CustomColor.darkColor)
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    color: CustomColor.boxColor,
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Kitchen Utensils", style: TextStyle(color: CustomColor.darkColor),)
                                ],
                              )
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: CustomColor.darkColor)
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    color: CustomColor.boxColor,
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Wrist Watch", style: TextStyle(color: CustomColor.darkColor),)
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: CustomColor.darkColor)
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                      Icons.trending_up,
                                      color: CustomColor.boxColor
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Sport Shoes", style: TextStyle(color: CustomColor.darkColor),)
                                ],
                              )
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: CustomColor.darkColor)
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                      Icons.trending_up,
                                      color: CustomColor.boxColor
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Women HandBag", style: TextStyle(color: CustomColor.darkColor),)
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: CustomColor.darkColor)
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                      Icons.trending_up,
                                      color: CustomColor.boxColor
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Men Shirts", style: TextStyle(color: CustomColor.darkColor),)
                                ],
                              )
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: CustomColor.darkColor)
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                      Icons.trending_up,
                                      color: CustomColor.boxColor
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Body Spray", style: TextStyle(color: CustomColor.darkColor),)
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                : GridView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 22,
                      mainAxisSpacing: 8
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: CustomColor.boxColor,
                    );
                  }
                )
            ],
          ),
        ),
      )
    );
  }
}
