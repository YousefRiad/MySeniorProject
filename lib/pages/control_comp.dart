import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wqm/const.dart';
import 'package:wqm/pages/settings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class controlComp extends StatefulWidget {
  @override
  State<controlComp> createState() => _controlCompState();
}

class _controlCompState extends State<controlComp> {
  Color btnColor = Color.fromARGB(255, 145, 143, 143);
  List<bool> _selections = List.generate(4, (index) => false);

  Future getStatus() async {
    final response = await http.get(Uri.parse(
        'https://api.thingspeak.com/channels/1627994/feeds.json?api_key=PJ4VIEO52G6CYB7W&results=1'));
    Map jsonData = jsonDecode(response.body);
    var FeedsReadings = jsonData["feeds"];
    Map mapFeedsReadings = FeedsReadings[0];
    String LEDStat = mapFeedsReadings["field5"];
    return LEDStat;
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
              CupertinoIcons.back,
              color: Colors.black,
              size: 28,
            )),
        backgroundColor: Color.fromARGB(255, 164, 214, 243),
        title: Text(
          'WaterFlow Control',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
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
                  builder: (context) => controlComp(),
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
      body: Column(
        children: [
          SizedBox(
            height: 90,
          ),
          Image.asset(
            "assets/waterpump.png",
            fit: BoxFit.cover,
            height: 200,
            width: 200,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Water Pump',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 60),
                    primary: Color.fromARGB(255, 53, 104, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () async {
                    await http.get(Uri.parse('http://192.168.1.26/switchled'));
                  },
                  child: Text(
                    'Switch',
                    style: TextStyle(
                      color: Color.fromARGB(255, 235, 235, 235),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: getStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator.adaptive();
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                String LEDStatusString = snapshot.data.toString();
                var LEDStatus = double.parse(LEDStatusString);
                if (LEDStatus == 1) {
                  return Text(
                    'Pump Status: ON',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  );
                } else if (LEDStatus == 0) {
                  return Text(
                    'Pump Status: OFF',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  );
                } else {
                  return Text(
                    'Pump Status: Not Connected',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
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
}
