import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '0CustomColors.dart';
import '1LogIn.dart';
import '2RegisterPage4.dart';

class RegisterPage3 extends StatefulWidget {
  String name;
  String email;
  String pass;
  RegisterPage3({Key? key, required this.name, required this.pass, required this.email}) : super(key: key);

  @override
  State<RegisterPage3> createState() => _RegisterPage3State();
}

class _RegisterPage3State extends State<RegisterPage3> {

  String? countryCode = "";
  String? number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Enter your phone number",
              style: TextStyle(
                  color: CustomColor.mediumColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 18,),
            Text(
              "To contact buyer or seller, they would like to know your contact number.",
              style: TextStyle(
                color: CustomColor.blackColor,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 36,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Country Code", style: TextStyle(fontSize: 12, color: CustomColor.mediumColor),),
                    SizedBox(
                      height: 60,
                      width: 80,
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
                            countryCode = value;
                          });
                        },
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 25,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Phone Number", style: TextStyle(fontSize: 14, color: CustomColor.mediumColor),),
                    SizedBox(
                      height: 60,
                      width: 200,
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
                            number = value;
                          });
                        },
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                )
              ],
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
                    if(countryCode == null && number == null){
                      Fluttertoast.showToast(
                          msg: "Please enter your Phone number",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }else{
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                          RegisterPage4(
                            name: widget.name,
                            number: "$countryCode $number",
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
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
// static const countryCodeList = [
//   "Select",
//   "AFG-93",
//   "ALB-355",
//   "DZA-213",
//   "ASM-1-684",
//   "AND-376",
//   "AGO- 244",
//   "AIA-1-264",
//   "ATA-672",
//   "ATG-1-268",
//   "ARG-54",
//   "ARM-374",
//   "ABW-297",
//   "AUS-61",
//   "AUT-43",
//   "AZE-994",
//   "BHS-1-242",
//   "BHR-973",
//   "BGD-880",
//   "BRB-1-246",
//   "BLR-375",
//   "BEL-32",
//   "BLZ-501",
//   "BEN-229",
//   "BMU-1-441",
//   "BTN-975",
//   "BOL-591",
//   "BIH-387",
//   "BWA-267",
//   "BRA-55",
//   "IOT-246",
//   "VGB-1-284",
//   "BRN-673",
//   "BGR-359",
//   "BFA-226",
//   "BDI-257",
//   "KHM-855",
//   "CMR-237",
//   "CAN-1",
//   "CPV-238",
//   "CYM-1-345",
//   "CAF-236",
//   "TCD-235",
//   "CHL-56",
//   "CHN-86",
//   "CXR-61",
//   "CCK-61",
//   "COL-57",
//   "COM-269",
//   "COK-682",
//   "CRI-506",
//   "HRV-385",
//   "CUB-53",
//   "CUW-599",
//   "CYP-357",
//   "CZE-420",
//   "COD-243",
//   "DNK-45",
//   "DJI-253",
//   "DMA-1-767",
//   "DOM-1-809, 1-829, 1-849",
//   "TLS-670",
//   "ECU-593",
//   "EGY-20",
//   "SLV-503",
//   "GNQ-240",
//   "ERI-291",
//   "EST-372",
//   "ETH-251",
//   "FLK-500",
//   "FRO-298",
//   "FJI-679",
//   "FIN-358",
//   "FRA-33",
//   "PYF-689",
//   "GAB-241",
//   "GMB-220",
//   "GEO-995",
//   "DEU-49",
//   "GHA-233",
//   "GIB-350",
//   "GRC-30",
//   "GRL-299",
//   "GRD-1-473",
//   "GUM-1-671",
//   "GTM-502",
//   "GGY-44-1481",
//   "GIN-224",
//   "GNB-245",
//   "GUY-592",
//   "HTI-509",
//   "HND-504",
//   "HKG-852",
//   "HUN-36",
//   "ISL-354",
//   "IND-91",
//   "IDN-62",
//   "IRN-98",
//   "IRQ-964",
//   "IRL-353",
//   "IMN-44-1624",
//   "ISR-972",
//   "ITA-39",
//   "CIV-225",
//   "JAM-1-876",
//   "JPN-81",
//   "JEY-44-1534",
//   "JOR-962",
//   "KAZ-7",
//   "KEN-254",
//   "KIR-686",
//   "XKX-383",
//   "KWT-965",
//   "KGZ-996",
//   "LAO-856",
//   "LVA-371",
//   "LBN-961",
//   "LSO-266",
//   "LBR-231",
//   "LBY-218",
//   "LIE-423",
//   "LTU-370",
//   "LUX-352",
//   "MAC-853",
//   "MKD-389",
//   "MDG-261",
//   "MWI-265",
//   "MYS-60",
//   "MDV-960",
//   "MLI-223",
//   "MLT-356",
//   "MHL-692",
//   "MRT-222",
//   "MUS-230",
//   "MYT-262",
//   "MEX-52",
//   "FSM-691",
//   "MDA-373",
//   "MCO-377",
//   "MNG-976",
//   "MNE-382",
//   "MSR-1-664",
//   "MAR-212",
//   "MOZ-258",
//   "MMR-95",
//   "NAM-264",
//   "NRU-674",
//   "NPL-977",
//   "NLD-31",
//   "ANT-599",
//   "NCL-687",
//   "NZL-64",
//   "NIC-505",
//   "NER-227",
//   "NGA-234",
//   "NIU-683",
//   "PRK-850",
//   "MNP-1-670",
//   "NOR-47",
//   "OMN-968",
//   "PAK-92",
//   "PLW-680",
//   "PSE-970",
//   "PAN-507",
//   "PNG-675",
//   "PRY-595",
//   "PER-51",
//   "PHL-63",
//   "PCN-64",
//   "POL-48",
//   "PRT-351",
//   "PRI-1-787, 1-939",
//   "QAT-974",
//   "COG-242",
//   "REU-262",
//   "ROU-40",
//   "RUS-7",
//   "RWA-250",
//   "BLM-590",
//   "SHN-290",
//   "KNA-1-869",
//   "LCA-1-758",
//   "MAF-590",
//   "SPM-508",
//   "VCT-1-784",
//   "WSM-685",
//   "SMR-378",
//   "STP-239",
//   "SAU-966",
//   "SEN-221",
//   "SRB-381",
//   "SYC-248",
//   "SLE-232",
//   "SGP-65",
//   "SXM-1-721",
//   "SVK-421",
//   "SVN-386",
//   "SLB-677",
//   "SOM-252",
//   "ZAF-27",
//   "KOR-82",
//   "SSD-211",
//   "ESP-34",
//   "LKA-94",
//   "SDN-249",
//   "SUR-597",
//   "SJM-47",
//   "SWZ-268",
//   "SWE-46",
//   "CHE-41",
//   "SYR-963",
//   "TWN-886",
//   "TJK-992",
//   "TZA-255",
//   "THA-66",
//   "TGO-228",
//   "TKL-690",
//   "TON-676",
//   "TTO-1-868",
//   "TUN-216",
//   "TUR-90",
//   "TKM-993",
//   "TCA-1-649",
//   "TUV-688",
//   "VIR-1-340",
//   "UGA-256",
//   "UKR-380",
//   "ARE-971",
//   "GBR-44",
//   "USA-1",
//   "URY-598",
//   "UZB-998",
//   "VUT-678",
//   "VAT-379",
//   "VEN-58",
//   "VNM-84",
//   "WLF-681",
//   "ESH-212",
//   "YEM-967",
//   "ZMB-260",
//   "ZWE-263",
// ];