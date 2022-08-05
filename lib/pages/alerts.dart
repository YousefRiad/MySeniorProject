import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:wqm/const.dart';
import 'package:wqm/pages/settings.dart';
import 'package:wqm/pages/ph_sensor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class alerts extends StatefulWidget {
  const alerts({Key? key}) : super(key: key);

  @override
  State<alerts> createState() => _alertsState();
}

class _alertsState extends State<alerts> {
  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  bool NoPh = false;
  bool NoTDS = false;
  bool NoTemp = false;
  bool NoTurb = false;

  Future getPH() async {
    final response = await http.get(Uri.parse(
        'https://api.thingspeak.com/channels/1627994/feeds.json?api_key=PJ4VIEO52G6CYB7W&results=1'));
    Map jsondata = jsonDecode(response.body);
    var sensorReadings = jsondata["feeds"];
    Map mapSensorReadings = sensorReadings[0];
    String pH = mapSensorReadings["field1"];
    pH = pH.substring(0, 4);
    return pH;
  }

  Future getTurb() async {
    final response = await http.get(Uri.parse(
        'https://api.thingspeak.com/channels/1627994/feeds.json?api_key=PJ4VIEO52G6CYB7W&results=1'));
    Map jsondata = jsonDecode(response.body);
    var sensorReadings = jsondata["feeds"];
    Map mapsensorReadings = sensorReadings[0];
    String turb = mapsensorReadings["field2"];
    turb = turb.substring(0, 4);
    return turb;
  }

  Future getTDS() async {
    final response = await http.get(Uri.parse(
        'https://api.thingspeak.com/channels/1627994/feeds.json?api_key=PJ4VIEO52G6CYB7W&results=1'));
    Map jsondata = jsonDecode(response.body);
    var sensorReadings = jsondata["feeds"];
    Map mapsensorReadings = sensorReadings[0];
    String tds = mapsensorReadings["field3"];
    tds = tds.substring(0, 6);
    return tds;
  }

  Future getTemp() async {
    final response = await http.get(Uri.parse(
        'https://api.thingspeak.com/channels/1627994/feeds.json?api_key=PJ4VIEO52G6CYB7W&results=1'));
    Map jsondata = jsonDecode(response.body);
    var sensorReadings = jsondata["feeds"];
    Map mapSensorReadings = sensorReadings[0];
    String temp = mapSensorReadings["field4"];
    temp = temp.substring(0, 2);
    return temp;
  }

  Future getDate() async {
    final response = await http.get(Uri.parse(
        'https://api.thingspeak.com/channels/1627994/feeds.json?api_key=PJ4VIEO52G6CYB7W&results=1'));
    Map jsondata = jsonDecode(response.body);
    var sensorReadings = jsondata["feeds"];
    Map mapSensorReadings = sensorReadings[0];
    String Date = mapSensorReadings["created_at"];
    Date = Date.substring(0, 10);
    return Date;
  }

  Future getTime() async {
    final response = await http.get(Uri.parse(
        'https://api.thingspeak.com/channels/1627994/feeds.json?api_key=PJ4VIEO52G6CYB7W&results=1'));
    Map jsondata = jsonDecode(response.body);
    var sensorReadings = jsondata["feeds"];
    Map mapSensorReadings = sensorReadings[0];
    String time = mapSensorReadings["created_at"];
    time = time.substring(11, 16);
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 164, 214, 243),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.xmark,
              color: Colors.black,
              size: 22,
            )),
        backgroundColor: Color.fromARGB(255, 164, 214, 243),
        title: const Text(
          'Alerts',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          const Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => alerts(),
                ),
              );
            },
            icon: const Icon(
              CupertinoIcons.refresh,
              color: Colors.black,
              size: 25,
            ),
          ),
          Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: IconThemeData(color: Colors.black)),
            child: PopupMenuButton<int>(
              color: Colors.white,
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: const [
                      Icon(
                        CupertinoIcons.settings,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Settings'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        color: Color.fromARGB(255, 164, 214, 243),
        backgroundColor: Colors.white,
        height: 200,
        animSpeedFactor: 2,
        showChildOpacityTransition: true,
        onRefresh: _handleRefresh,
        child: Center(
          child: FutureBuilder(
            future: Future.wait(
              [getPH(), getTDS(), getDate(), getTemp(), getTurb(), getTime()],
            ),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator.adaptive();
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                //create list for snapshot.data:
                ListView.builder(
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Text('${snapshot.data[index].title}');
                  },
                );

                String pHString = snapshot.data[0].toString();
                var pH = double.parse(pHString);

                String TurbString = snapshot.data[4].toString();
                var Turb = double.parse(TurbString);

                String TDSString = snapshot.data[1].toString();
                var TDS = double.parse(TDSString);

                String TempString = snapshot.data[3].toString();
                var Temp = double.parse(TempString);

                String DateString = snapshot.data[2].toString();

                String TimeString = snapshot.data[5].toString();

                return ListView(
                  children: [
                    (pH > 8 || pH < 6.5)
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Column(
                                children: [
                                  Container(
                                    height: 76,
                                    color: Color.fromARGB(255, 235, 235, 235),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 0, 0),
                                              child: Icon(
                                                Icons.warning_rounded,
                                                color: Color.fromARGB(
                                                    255, 240, 3, 3),
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 8, 0, 0),
                                              child: Text(
                                                'WARNNING',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 0),
                                              child: Icon(
                                                Icons.warning_rounded,
                                                color: Color.fromARGB(
                                                    255, 240, 3, 3),
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  100, 0, 0, 0),
                                              child: Text(
                                                '$DateString at $TimeString',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 170, 170, 170),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(13, 10, 0, 0),
                                          child: Text(
                                            'It looks like you have an unsafe pH value. Please check your water sample or your pH sensor.',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Text(''),
                    (Turb > 8 || Turb < 0)
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Column(
                                children: [
                                  Container(
                                    height: 76,
                                    color: Color.fromARGB(255, 235, 235, 235),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 0, 0),
                                              child: Icon(
                                                Icons.warning_rounded,
                                                color: Color.fromARGB(
                                                    255, 240, 3, 3),
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 8, 0, 0),
                                              child: Text(
                                                'WARNNING',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 0),
                                              child: Icon(
                                                Icons.warning_rounded,
                                                color: Color.fromARGB(
                                                    255, 240, 3, 3),
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  100, 0, 0, 0),
                                              child: Text(
                                                '$DateString at $TimeString',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 170, 170, 170),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(13, 10, 0, 0),
                                          child: Text(
                                            'It looks like you have an unsafe Turbidity value. Please check your water sample or your Turbidity sensor.',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Text(''),
                    (TDS > 300 || TDS < 0)
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Column(
                                children: [
                                  Container(
                                    height: 76,
                                    color: Color.fromARGB(255, 235, 235, 235),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 0, 0),
                                              child: Icon(
                                                Icons.warning_rounded,
                                                color: Color.fromARGB(
                                                    255, 240, 3, 3),
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 8, 0, 0),
                                              child: Text(
                                                'WARNNING',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 0),
                                              child: Icon(
                                                Icons.warning_rounded,
                                                color: Color.fromARGB(
                                                    255, 240, 3, 3),
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  100, 0, 0, 0),
                                              child: Text(
                                                '$DateString at $TimeString',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 170, 170, 170),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(13, 10, 0, 0),
                                          child: Text(
                                            'It looks like you have an unsafe TDS value. Please check your water sample or your TDS sensor.',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Text(''),
                    (Temp > 30 || Temp < 10)
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Column(
                                children: [
                                  Container(
                                    height: 90,
                                    color: Color.fromARGB(255, 235, 235, 235),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 0, 0),
                                              child: Icon(
                                                Icons.warning_rounded,
                                                color: Color.fromARGB(
                                                    255, 240, 3, 3),
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 8, 0, 0),
                                              child: Text(
                                                'WARNNING',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 0),
                                              child: Icon(
                                                Icons.warning_rounded,
                                                color: Color.fromARGB(
                                                    255, 240, 3, 3),
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  100, 0, 0, 0),
                                              child: Text(
                                                '$DateString at $TimeString',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 170, 170, 170),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(13, 10, 0, 0),
                                          child: Text(
                                            'It looks like you have an unsafe Temperature value. Please check Room Temperature or your Temperature sensor.',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Text(''),
                    (pH > 6.5 &&
                            pH < 8 &&
                            Turb < 8 &&
                            Turb > 0 &&
                            TDS < 300 &&
                            TDS > 0 &&
                            Temp > 5 &&
                            Temp < 30)
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(10, 180, 10, 10),
                            child: Center(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "You have No Alerts",
                                          style: TextStyle(
                                            fontSize: 27,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/waterdrop.png",
                                      fit: BoxFit.cover,
                                      height: 140,
                                      width: 140,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(25),
                            child: Text(''),
                          ),
                  ],
                );

                // if (Turb > 8 || Turb < 0) {
                //   return ListView(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(25.0),
                //         child: ClipRRect(
                //           borderRadius: BorderRadius.circular(15),
                //           child: Column(
                //             children: [
                //               Container(
                //                 height: 85,
                //                 color: Color.fromARGB(255, 255, 255, 255),
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Row(
                //                       children: [
                //                         Padding(
                //                           padding:
                //                               EdgeInsets.fromLTRB(10, 5, 0, 0),
                //                           child: Icon(
                //                             Icons.warning_rounded,
                //                             color: const Color.fromARGB(
                //                                 255, 240, 3, 3),
                //                           ),
                //                         ),
                //                         Padding(
                //                           padding:
                //                               EdgeInsets.fromLTRB(0, 8, 0, 0),
                //                           child: Text(
                //                             'WARNNING',
                //                             style: TextStyle(
                //                                 fontSize: 17,
                //                                 fontWeight: FontWeight.bold),
                //                           ),
                //                         ),
                //                         Padding(
                //                           padding:
                //                               EdgeInsets.fromLTRB(0, 5, 0, 0),
                //                           child: Icon(
                //                             Icons.warning_rounded,
                //                             color: const Color.fromARGB(
                //                                 255, 240, 3, 3),
                //                           ),
                //                         ),
                //                         Padding(
                //                           padding:
                //                               EdgeInsets.fromLTRB(160, 8, 0, 0),
                //                           child: Text(
                //                             '$DateString at $TimeString',
                //                             style: TextStyle(
                //                               fontSize: 12,
                //                               fontWeight: FontWeight.bold,
                //                               color: Color.fromARGB(
                //                                   255, 170, 170, 170),
                //                             ),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                     Padding(
                //                       padding: const EdgeInsets.fromLTRB(
                //                           20, 5, 0, 0),
                //                       child: Text(
                //                         'It looks like you have an unsafe Turb value. Please check your water sample or your Turb sensor.',
                //                         style: TextStyle(
                //                             fontSize: 14,
                //                             fontWeight: FontWeight.bold),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   );
                // } else {
                //   NoTurb = true;
                // }
              }
            },
          ),
        ),
      ),
    );
  }
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const settingsPage()),
      );
      break;
  }
}


// return 
// Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         child: Text(
//                           "You have No Alerts",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Icon(
//                         CupertinoIcons.check_mark_circled,
//                         color: Color.fromARGB(255, 11, 190, 17),
//                         size: 60,
//                       ),
//                     ],
//                   ),
//                 );