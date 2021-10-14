import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Map mapResponse;

class HtttpPage extends StatefulWidget {
  HtttpPage({Key? key}) : super(key: key);

  @override
  _HtttpPageState createState() => _HtttpPageState();
}

String dataResponse = "";

class _HtttpPageState extends State<HtttpPage> {
  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User Data"),
        ),
        body: Container(child: Card(child: Text(dataResponse.toString()))));
  }

  Future getUserData() async {
    var response =
        await http.get(Uri.https("jsonplaceholder.typicode.com", "/users"));
    if (response.statusCode == 200) {
      setState(() {
        dataResponse = response.body;
      });
      var jsonData = jsonDecode(response.body);
      List<User> users = [];
      for (var u in jsonData) {
        User user = User(u["name"], u["email"], u["username"]);
        users.add(user);
      }
      print(users.length);
      return users;
    }
  }
}

class User {
  final String name, email, userName;

  User(this.name, this.email, this.userName);
}
