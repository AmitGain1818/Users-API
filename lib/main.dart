import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _jsonPost = [];

  Future fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _jsonPost = jsonData;
      });
    } catch (err) {
      print('this the $err error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Api',
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('API')),
        ),
        body: ListView.builder(
          itemCount: _jsonPost.length,
          itemBuilder: (context, index) {
            final post = _jsonPost[index];
            return Text(
              "Name: ${post['name']}\n Email: ${post['email']}\n Address: ${post['address']}\n Phone: ${post['phone']} \n Website: ${post['website']} \n Company: ${post['company']} \n \n",
            );
          },
        ),
      ),
    );
  }
}
