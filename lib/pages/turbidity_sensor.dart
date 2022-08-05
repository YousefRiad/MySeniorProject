import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wqm/const.dart';
import 'package:wqm/pages/more_info.dart';
import 'package:wqm/pages/settings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TurbiditySensor extends StatefulWidget {
  const TurbiditySensor({Key? key}) : super(key: key);

  @override
  State<TurbiditySensor> createState() => _TurbiditySensorState();
}

class _TurbiditySensorState extends State<TurbiditySensor> {
  Future getTurb() async {
    final response = await http.get(Uri.parse(
        'https://api.thingspeak.com/channels/1627994/feeds.json?api_key=PJ4VIEO52G6CYB7W&results=1'));
    Map jsondata = jsonDecode(response.body);
    var sensorReadings = jsondata["feeds"];
    Map mapsensorReadings = sensorReadings[0];
    String turb = mapsensorReadings["field2"];
    turb = turb.substring(0, 5);
    return turb;
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

  Color valueColor = Color.fromARGB(255, 0, 0, 0);

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
            CupertinoIcons.back,
            color: Colors.black,
            size: 28,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 164, 214, 243),
        title: Text(
          'Turbidity',
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TurbiditySensor(),
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
                    children: [
                      Icon(
                        CupertinoIcons.settings,
                        color: Colors.black,
                      ),
                      const SizedBox(
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
      body: Center(
        child: FutureBuilder(
            future: Future.wait(
              [getTurb(), getDate(), getTime()],
            ),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator.adaptive();
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                String TurbString = snapshot.data[0].toString();
                var Turb = double.parse(TurbString);

                String DateString = snapshot.data[1].toString();

                String TimeString = snapshot.data[2].toString();

                if (Turb > 8 && Turb < 100) {
                  valueColor = Color.fromARGB(255, 206, 19, 19);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Current Turbidity value',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        snapshot.data[0].toString() + '%',
                        style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: valueColor,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.xmark_circle,
                            color: valueColor,
                            size: 25,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'High Turbidity %',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Last Updated: $DateString at $TimeString',
                        style: TextStyle(
                          fontSize: 11.3,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 24, 24, 24),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '              For more info about the parameters check the "more info" page.',
                            style: TextStyle(
                                fontSize: 9, fontWeight: FontWeight.normal),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const moreInfo()),
                                );
                              },
                              icon: Icon(
                                CupertinoIcons.info,
                                size: 13,
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ],
                  );
                } else if (Turb < 0) {
                  valueColor = Color.fromARGB(255, 206, 19, 19);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Current Turbidity value',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        snapshot.data[0].toString() + '%',
                        style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: valueColor,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.xmark_circle,
                            color: valueColor,
                            size: 25,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Incorrect value. check sensor',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Last Updated: $DateString at $TimeString',
                        style: TextStyle(
                          fontSize: 11.3,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 24, 24, 24),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '              For more info about the parameters check the "more info" page.',
                            style: TextStyle(
                                fontSize: 9, fontWeight: FontWeight.normal),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const moreInfo()),
                                );
                              },
                              icon: Icon(
                                CupertinoIcons.info,
                                size: 13,
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ],
                  );
                } else if (Turb > 100) {
                  valueColor = Color.fromARGB(255, 206, 19, 19);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Current Turbidity value',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        snapshot.data[0].toString() + '%',
                        style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: valueColor,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.xmark_circle,
                            color: valueColor,
                            size: 25,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Incorrect value. check sensor',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Last Updated: $DateString at $TimeString',
                        style: TextStyle(
                          fontSize: 11.3,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 24, 24, 24),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '              For more info about the parameters check the "more info" page.',
                            style: TextStyle(
                                fontSize: 9, fontWeight: FontWeight.normal),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const moreInfo()),
                                );
                              },
                              icon: Icon(
                                CupertinoIcons.info,
                                size: 13,
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ],
                  );
                } else {
                  valueColor = Color.fromARGB(255, 11, 190, 17);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Current Turbidity value',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        snapshot.data[0].toString() + '%',
                        style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: valueColor,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.check_mark_circled,
                            color: valueColor,
                            size: 25,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Safe Turbidity Value',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Last Updated: $DateString at $TimeString',
                        style: TextStyle(
                          fontSize: 11.3,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 24, 24, 24),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '              For more info about the parameters check the "more info" page.',
                            style: TextStyle(
                                fontSize: 9, fontWeight: FontWeight.normal),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const moreInfo()),
                                );
                              },
                              icon: Icon(
                                CupertinoIcons.info,
                                size: 13,
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ],
                  );
                }
              }
            }),
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
