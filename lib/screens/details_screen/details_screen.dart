import 'package:flutter/material.dart';
import 'package:flutter_timezone_app/constants.dart';
import 'package:flutter_timezone_app/model/timezone_model.dart';
import 'package:flutter_timezone_app/services/timezone_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class TimeZoneDetails extends StatefulWidget {
  const TimeZoneDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeZoneDetails> createState() => _TimeZoneDetailsState();
}

class _TimeZoneDetailsState extends State<TimeZoneDetails> {
  Map<String, dynamic> result = {};

  late TimezoneModel gelenCevap;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    gelenCevap = await RemoteService().getDetailsData();
    result = gelenCevap.toJson();
    if (result != null) {
      setState(() {});
      isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: RemoteService().getDetailsData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasData) {
            String selectedTimezone = result['datetime'].toString();
            String offset = result['utc_offset'].toString().substring(0, 3);
            DateTime now = DateTime.parse(selectedTimezone);
            now = now.add(Duration(hours: int.parse(offset)));
            String nowHour =
                DateFormat('HH').format(DateTime.parse(now.toString()));
            String selectedTimezoneMinute =
                DateFormat('mm').format(DateTime.parse(selectedTimezone));
            String selectedTextDay =
                DateFormat.EEEE('tr').format(DateTime.parse(selectedTimezone));
            String selectedTimezoneDay =
                DateFormat.MMMMd('tr').format(DateTime.parse(selectedTimezone));
            String selectedTimezoneYear =
                DateFormat.y('tr').format(DateTime.parse(selectedTimezone));

            String countries = result['timezone'].toString();
            List<String> clist = countries.split('/');

            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Hive.box("darkMode").get("themeMode") == false
                              ? AssetImage('assets/images/WORLD TIME2 1.png')
                              : AssetImage(
                                  'assets/images/WORLD TIME white.png')),
                      color: Hive.box("darkMode").get("themeMode") == false
                          ? kPrimaryColor
                          : kdarkColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32))),
                ),
              ),
              body: isLoaded == false
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Hive.box("darkMode")
                                                    .get("themeMode") ==
                                                false
                                            ? Colors.white
                                            : kdarkColor,
                                        border: Border.all(
                                            color: Hive.box("darkMode")
                                                        .get("themeMode") ==
                                                    false
                                                ? kTextColor
                                                : kdarkColor,
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14))),
                                    height: 140,
                                    width: 140,
                                    child: Center(
                                        child: Text(
                                      nowHour.toString(),
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 79,
                                              fontWeight: FontWeight.w600,
                                              color: Hive.box("darkMode")
                                                          .get("themeMode") ==
                                                      false
                                                  ? kTextColor
                                                  : Colors.white)),
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        child: Text(':',
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    fontSize: 79,
                                                    color: Hive.box("darkMode")
                                                                .get(
                                                                    "themeMode") ==
                                                            false
                                                        ? kTextColor
                                                        : Colors.white)))),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Hive.box("darkMode")
                                                    .get("themeMode") ==
                                                false
                                            ? Colors.white
                                            : kdarkColor,
                                        border: Border.all(
                                            color: Hive.box("darkMode")
                                                        .get("themeMode") ==
                                                    false
                                                ? kTextColor
                                                : kdarkColor,
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14))),
                                    height: 140,
                                    width: 140,
                                    child: Center(
                                      child: Text(selectedTimezoneMinute,
                                          style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                  fontSize: 79,
                                                  fontWeight: FontWeight.w600,
                                                  color: Hive.box("darkMode")
                                                              .get(
                                                                  "themeMode") ==
                                                          false
                                                      ? kTextColor
                                                      : Colors.white))),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 28, bottom: 10),
                              child: Column(
                                children: [
                                  Text(clist[1],
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                              color: Hive.box("darkMode")
                                                          .get("themeMode") ==
                                                      false
                                                  ? kTextColor
                                                  : Colors.white))),
                                  Text(clist[0],
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              color: Hive.box("darkMode")
                                                          .get("themeMode") ==
                                                      false
                                                  ? kTextColor
                                                  : Colors.white))),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text(
                                      selectedTextDay +
                                          ', GMT ' +
                                          result['utc_offset'],
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: Hive.box("darkMode")
                                                          .get("themeMode") ==
                                                      false
                                                  ? kTextColor
                                                  : Colors.white))),
                                  Text(
                                      selectedTimezoneDay +
                                          ', ' +
                                          selectedTimezoneYear,
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: Hive.box("darkMode")
                                                          .get("themeMode") ==
                                                      false
                                                  ? kTextColor
                                                  : Colors.white)))
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Icon(
                Icons.error_outline,
                size: 60,
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
