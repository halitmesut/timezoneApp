// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_timezone_app/constants.dart';
import 'package:flutter_timezone_app/screens/details_screen/details_screen.dart';
import 'package:flutter_timezone_app/services/timezone_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? sehirlistesi;
  var isloaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    String localTime = DateFormat('HH:mm').format(DateTime.now());
    String localDate = DateFormat.MMMMd('tr').format(DateTime.now());
    String localDay = DateFormat.EEEE('tr').format(DateTime.now());

    var darkMode = Hive.box("darkMode").get("themeMode", defaultValue: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.272,
            child: Stack(children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 66, left: kDefaultPadding, right: kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${greetingMessage()}, Haluk!",
                          style: GoogleFonts.montserrat(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          localTime,
                          style: GoogleFonts.montserrat(
                              fontSize: 32, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '$localDate, $localDay',
                          style: GoogleFonts.montserrat(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(77, 0, 9, 55),
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Hive.box("darkMode").get("themeMode") == true
                                ? Colors.white
                                : Color.fromARGB(238, 1, 18, 104),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        child: IconButton(
                          icon: Hive.box("darkMode").get("themeMode") == true
                              ? Icon(
                                  Icons.light_mode_outlined,
                                  size: 18,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.dark_mode_outlined,
                                  size: 18,
                                  color: Colors.white,
                                ),
                          onPressed: () {
                            setState(() {
                              if (Hive.box("darkMode").get("themeMode") ==
                                  true) {
                                darkMode = Hive.box("darkMode")
                                    .put("themeMode", false);
                              } else {
                                darkMode =
                                    Hive.box("darkMode").put("themeMode", true);
                              }
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                height: size.height * 0.272 - 22,
                decoration: BoxDecoration(
                    color: Hive.box("darkMode").get("themeMode") == false
                        ? kPrimaryColor
                        : kdarkColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32))),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    height: 44,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kSearchBorderColor),
                        borderRadius: BorderRadius.circular(99)),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Arama',
                          hintStyle: GoogleFonts.montserrat(
                              color: kTextColor, fontSize: 12),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                          prefixIcon: Image.asset('assets/icons/search.png')),
                    ),
                  ))
            ]),
          ),
          Expanded(
            child: Visibility(
              visible: isloaded,
              child: ListView.builder(
                  itemCount: sehirlistesi?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 33),
                      child: Stack(clipBehavior: Clip.none, children: [
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                            color:
                                Hive.box("darkMode").get("themeMode") == false
                                    ? kPrimaryColor
                                    : kdarkColor,
                            child: ListTile(
                                onTap: () {
                                  Hive.box("selectedCity").put(
                                      "selectedCountrt",
                                      sehirlistesi?[index].toString());

                                  debugPrint(Hive.box("selectedCity")
                                      .get("selectedCountrt"));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TimeZoneDetails()));
                                },
                                title: Text(
                                  sehirlistesi![index]
                                      .toString()
                                      .replaceAll('/', ', ')
                                      .replaceAll('_', ' '),
                                  style: GoogleFonts.montserrat(
                                      color: Hive.box("darkMode")
                                                  .get("themeMode") ==
                                              false
                                          ? kTextColor
                                          : Colors.white,
                                      fontSize: 15),
                                ))),
                        Positioned(
                          top: 15,
                          right: -13,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3,
                                      color: Hive.box("darkMode")
                                                  .get("themeMode") ==
                                              false
                                          ? Colors.white
                                          : kTextColor),
                                  shape: BoxShape.circle,
                                  color:
                                      Hive.box("darkMode").get("themeMode") ==
                                              false
                                          ? kPrimaryColor
                                          : kdarkColor),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Hive.box("darkMode").get("themeMode") ==
                                        false
                                    ? kTextColor
                                    : Colors.white,
                              )),
                          height: 31,
                          width: 31,
                        ),
                      ]),
                    );
                  }),
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
    );
  }

  getData() async {
    sehirlistesi = await RemoteService().getCityData();
    if (sehirlistesi != null) {
      setState(() {
        isloaded = true;
      });
    }
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow >= 5 && timeNow <= 12) {
      return 'Günaydın';
    } else if (timeNow > 12 && timeNow <= 16) {
      return 'Tünaydın';
    } else if (timeNow > 16 && timeNow < 20) {
      return 'İyi Akşamlar';
    } else {
      return 'İyi Geceler';
    }
  }
}
