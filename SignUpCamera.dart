import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Auth.dart';
import 'package:http/http.dart' as http;

import 'form.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "route",
      home: Scaffold(
        appBar: AppBar(
          title: Text("SIGN UP PAGE"),
        ),
        body: const InSignupPage(),
      ),
    );
  }
}

class InSignupPage extends StatefulWidget {
  const InSignupPage({Key? key}) : super(key: key);

  @override
  State<InSignupPage> createState() => _InSignupPageState();
}

class _InSignupPageState extends State<InSignupPage> {
  String getResponse = '';
  Future<void> getDataForm() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/add'));
    if (response.statusCode == 200) {
      setState(() {
        getResponse = response.body;
      });
    } else {
      print('Get Error: ${response.body}');
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddDataScreen()));
  }

  void initState() {
    super.initState();
    getDataForm();
    // Delay navigation for 5 seconds
    // Timer(Duration(seconds: 20), () {
    // Navigator.push(
    // context,
    // MaterialPageRoute(builder: (context) => AddDataScreen()),
    // );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1),
        child: ListView(
          children: <Widget>[
            Container(
               alignment: Alignment.center,
               padding: const EdgeInsets.all(20),
                child: const Text(
                  'Dictating Your Face',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(10),
              color: Colors.grey,
              child: MaterialButton(
                  height: 200,
                  minWidth: 200,
                  elevation: 20,
                  color: Colors.green,
                  onPressed: () async {
                    getDataForm();
                  }),
            ),
            Container(
                height: 70,
                width: 70,
                padding: const EdgeInsets.all(10),
                child: Text("Wait  For 25 Seconds")),
            Container(
                height: 70,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: const Text('Its Recognized'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDataScreen()));
                  },
                )),
            Container(
                height: 70,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: const Text('Its not Recognized '),
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPageNotRecognized()));
                  // },
                )),
          ],
        ));
   }
}
