import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'API.dart';
import 'Auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController newusernameController = TextEditingController();
  TextEditingController newuseridController = TextEditingController();

  String url = '';
  var data;
  String output = '';

  void login(String newusername, newuserid) async {
    try {
      Response response = await post(
          Uri.parse(
              'http://127.0.0.1:5000/add_data?username=#&userid=@'),
          body: {'newusername': '', 'newuserid': ''});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login successfully');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: newusernameController,
              decoration: InputDecoration(hintText: 'newusername'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: newuseridController,
              decoration: InputDecoration(hintText: 'newuserid'),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                login(newusernameController.text.toString(),
                    newuseridController.text.toString());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  child: Text('Login'),
                  onPressed: () async {
                    url = 'http://127.0.0.1:5000/add';
                    data = await fetchdata(url);
                    var decoded = jsonDecode(data);
                    setState(() {
                      output = decoded['output'];
                    });
                    Future.delayed(Duration(seconds: 60), () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AuthInPage()),
                      );
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
