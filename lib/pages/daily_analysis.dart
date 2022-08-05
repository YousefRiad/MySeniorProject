import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wqm/const.dart';
import 'package:wqm/pages/settings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class dailyAnalysis extends StatefulWidget {
  const dailyAnalysis({Key? key}) : super(key: key);

  @override
  State<dailyAnalysis> createState() => _dailyAnalysisState();
}

class _dailyAnalysisState extends State<dailyAnalysis> {
  final EmailTEC = TextEditingController();
  String dataUrl = 'https://thingspeak.com/channels/1627994/feed.csv';

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
          title: const Text(
            'Daily Analysis',
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
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
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Image.asset(
                "assets/emailylwww.png",
                fit: BoxFit.cover,
                height: 180,
                width: 180,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: EmailTEC,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your email to receive Analysis Sheet',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.send),
                onPressed: () {
                  var User_Email = EmailTEC.text;
                  print('Your Email: ' + User_Email);
                  sendEmail(User_Email);
                },
                label: Text('SEND'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ));
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

Future<void> sendEmail(
  String user_email, {
  String name = 'WQMS',
}) async {
  final serviceId = 'service_j3hel7m';
  final templateId = 'template_0avudms';
  final userId = '3X_E0WD2dAW0mZvbs';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(
      {
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_email': user_email,
          'user_name': name,
        },
      },
    ),
  );
}
