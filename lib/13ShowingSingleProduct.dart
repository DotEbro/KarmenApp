import 'package:flutter/material.dart';

import '0CustomColors.dart';

class ShowingSingleProduct extends StatefulWidget {
  const ShowingSingleProduct({Key? key}) : super(key: key);

  @override
  State<ShowingSingleProduct> createState() => _ShowingSingleProductState();
}

class _ShowingSingleProductState extends State<ShowingSingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColor.darkColor,
        title: Text("Showing Single Product"),
      ),
    );
  }
}
