import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart';

import 'API.dart';

class AuthInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "route",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Authorised PAGE"),
        ),
        body: const InAuthInPage(),
      ),
    );
  }
}

class InAuthInPage extends StatefulWidget {
  const InAuthInPage({Key? key}) : super(key: key);

  @override
  State<InAuthInPage> createState() => _InAuthInPageState();
}

class _InAuthInPageState extends State<InAuthInPage> {
  String url = '';
  var data;
  String output = '';

  void initState() {
    super.initState();
    // Delay navigation for 5 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 70,
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            child: const Text('Attendance  taken Succefully'),
            onPressed: () async {
              Future.delayed(Duration(seconds: 2), () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              });
            },
          )),
    );
  }
}
