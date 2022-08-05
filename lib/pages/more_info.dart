import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wqm/const.dart';
import 'package:wqm/pages/settings.dart';

class moreInfo extends StatelessWidget {
  const moreInfo({Key? key}) : super(key: key);
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
          'More Info',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        //centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
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
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 15, 22),
            child: Row(
              children: [
                Text(
                  'Adminstration Contacts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 11),
            child: Row(
              children: [
                Text(
                  'Owner: SDP32 Team',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 11),
            child: Row(
              children: [
                Text(
                  'waterqualitysystem32@gmail.com',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 11),
            child: Row(
              children: [
                Text(
                  '___________________________',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 11),
            child: Row(
              children: [
                Text(
                  'Provider: University Of Sharjah',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 11),
            child: Row(
              children: [
                Text(
                  'Sharjah.ac.ae',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 15, 22),
            child: Row(
              children: [
                Text(
                  'Pure Water Parameters',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 11),
            child: Row(
              children: [
                Text(
                  'pH: 6.5 - 8',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 11),
            child: Row(
              children: [
                Text(
                  'Turbidity: < 8%',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 11),
            child: Row(
              children: [
                Text(
                  'TDS: < 300 ppm',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 11),
            child: Row(
              children: [
                Text(
                  'Temperature: 10°C - 30°C',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 15, 22),
            child: Row(
              children: [
                Text(
                  'Application Timezone',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 11),
            child: Row(
              children: [
                Text(
                  'Timezone: GMT',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
        ],
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
