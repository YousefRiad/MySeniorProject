import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wqm/const.dart';
import 'package:wqm/pages/alerts.dart';
import 'package:wqm/pages/control_comp.dart';
import 'package:wqm/pages/daily_analysis.dart';
import 'package:wqm/pages/live_monitoring.dart';
import 'package:wqm/pages/more_info.dart';
import 'package:wqm/pages/settings.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

Color lightmode = const Color.fromARGB(255, 164, 214, 243);
Color pageColor = const Color.fromARGB(255, 164, 214, 243);
Color appBarLight = const Color.fromARGB(255, 235, 235, 235);
Color appBarColor = const Color.fromARGB(255, 235, 235, 235);

class _homePageState extends State<homePage> {
  List<bool> _selections = List.generate(4, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 8,
        shadowColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset("assets/water.png",
              fit: BoxFit.cover, height: 20.00, width: 20.00),
        ),
        title: const Text(
          'Water Quality Monitoring System    ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const alerts()),
                );
              },
              icon: const Icon(
                CupertinoIcons.bell,
                color: Colors.black,
                size: 23,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          ),
          Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: const IconThemeData(color: Colors.black)),
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
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const SizedBox(
                    //   height: 200,
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 60),
                      child: Image.asset(
                        "assets/water.png",
                        fit: BoxFit.cover,
                        height: 220,
                        width: 220,
                      ),
                    ),

                    Card(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ElevatedButton.icon(
                        icon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Image.asset(
                            "assets/marketing.png",
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const liveMonitoring()),
                          );
                        },
                        label: Text(
                          "Live Monitor ",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(350, 120),
                            primary: const Color.fromARGB(255, 235, 235, 235),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Card(
                      color: const Color.fromARGB(255, 180, 179, 179),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ElevatedButton.icon(
                        icon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Image.asset(
                            "assets/emailylwww.png",
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const dailyAnalysis()),
                          );
                        },
                        label: Text(
                          "Daily Analysis ",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(500, 120),
                            primary: const Color.fromARGB(255, 235, 235, 235),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Card(
                      color: const Color.fromARGB(255, 180, 179, 179),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ElevatedButton.icon(
                        icon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Image.asset(
                            "assets/waterpump.png",
                            fit: BoxFit.cover,
                            height: 55,
                            width: 55,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => controlComp()),
                          );
                        },
                        label: Text(
                          "Water Flow  ",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(500, 120),
                          primary: const Color.fromARGB(255, 235, 235, 235),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Card(
                      color: const Color.fromARGB(255, 180, 179, 179),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ElevatedButton.icon(
                        icon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Image.asset(
                            "assets/information.png",
                            fit: BoxFit.cover,
                            height: 45,
                            width: 45,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const moreInfo()),
                          );
                        },
                        label: Text(
                          "More Info ",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(500, 120),
                            primary: const Color.fromARGB(255, 235, 235, 235),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
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




// Column(
//             children: [
//               const SizedBox(
//                 height: 200,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 15,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => liveMonitoring()),
//                         );
//                       },
//                       child: Text(
//                         " Live Monitor ",
//                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                               fontSize: 15.0,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1,
//                             ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(150, 70),
//                           primary: Colors.grey,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0),
//                           )),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => dailyAnalysis()),
                        // );
//                       },
//                       child: Text(
//                         "Daily Analysis",
//                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1,
//                             ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(150, 70),
//                           primary: Colors.grey,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0),
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 100,
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 15,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => controlComp()),
                        // );
//                       },
//                       child: Text(
//                         "Control System",
//                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1,
//                             ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(150, 70),
//                           primary: Colors.grey,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0),
//                           )),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => moreInfo()),
                        // );
//                       },
//                       child: Text(
//                         "More Info",
//                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1,
//                             ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(150, 70),
//                           primary: Colors.grey,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0),
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),