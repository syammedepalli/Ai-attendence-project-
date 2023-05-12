import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_application_1/signin.dart';

import 'API.dart';
import 'Auth.dart';
import 'form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Facial AI App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String url = '';
  var data;
  String output = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.7,
                  image: AssetImage('assets/aiimage.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(60),
                child: const Text(
                  'First Page',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                height: 70,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: const Text('Signin'),
                  onPressed: () async {
                    url = 'http://127.0.0.1:5000/api';
                    data = await fetchdata(url);
                    var decoded = jsonDecode(data);
                    setState(() {
                      output = decoded['Status'];
                    });
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AuthInPage()),
                      );
                    });
                  },
                )),
            Container(
                height: 70,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: const Text('Signup'),
                  onPressed: () async {
                    // url = 'http://127.0.0.1:5000/add';
                    // data = await fetchdata(url);
                    // var decoded = jsonDecode(data);
                    // setState(() {
                    // output = decoded['Status'];
                    // });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDataScreen()));
                    // Future.delayed(Duration(seconds: 15), () {
                    // Navigator.of(context).pushReplacement(
                    // MaterialPageRoute(
                    // builder: (context) => AddDataScreen()),
                    // );
                    // });
                  },
                )),
            Container(
                height: 70,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: const Text('Visitor'),
                  onPressed: () async {
                    // url = 'http://127.0.0.1:5000/add';
                    // data = await fetchdata(url);
                    // var decoded = jsonDecode(data);
                    // setState(() {
                    // output = decoded['Status'];
                    // });
                    // Future.delayed(Duration(seconds: 5), () {
                    // Navigator.of(context).pushReplacement(
                    // MaterialPageRoute(
                    // builder: (context) => AddDataScreen()),
                    // );
                    // });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                )),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TextField(
                  // onChanged: (value) {
                  // url = 'http://127.0.0.1:5000/api';
                  // },
                  // ),
                  // TextButton(
                  // onPressed: () async {
                  // url = 'http://127.0.0.1:5000/api';
                  // data = await fetchdata(url);
                  // var decoded = jsonDecode(data);
                  // setState(() {
                  // output = decoded['Status'];
                  // });
                  // },
                  // child: Text(
                  // 'Fetch Ascii Value',
                  // style: TextStyle(fontSize: 20),
                  // )),
                  Text(
                    output,
                    style: TextStyle(fontSize: 40, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

Future getData(url) async {
  Response response = await get(url);
  return response.body;
}
