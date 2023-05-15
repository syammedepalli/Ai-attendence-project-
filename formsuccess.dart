import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'API.dart';
import 'package:http/http.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _newUserIdController = TextEditingController();

  get userid => null;

  get username => null;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newUsername = _newUsernameController.text;
      final newUserId = _newUserIdController.text;
      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:5000/add_data?username=${newUsername}&userid=${newUserId}'),
        body: {
          'newusername': newUsername,
          'newuserid': newUserId,
        },
      );
      if (response.statusCode == 200) {
        // Handle successful response from the backend
        print(response.body);
      } else {
        // Handle error response from the backend
        print('Request failed : ${response.statusCode}');
      }
    }
  }

  String url = '';
  var data;
  String output = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _newUsernameController,
                decoration: InputDecoration(
                  labelText: 'New Username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _newUserIdController,
                decoration: InputDecoration(
                  labelText: 'New User ID',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a user ID';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Capture'),
                  // onPressed: () async {
                  // url =
                  // 'http://127.0.0.1:5000/add_data?username=harirs&userid=87888';
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
                  // },
                ),
              ),
              Text(
                output,
                style: TextStyle(fontSize: 40, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
