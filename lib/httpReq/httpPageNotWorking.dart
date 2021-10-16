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
  // @override
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
        body: FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // print(users[1].id);
              return Center(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  // print(users.length);
                  return ListTile(
                    title: Text("users[index].title"),
                    subtitle: Text("100"),
                  );
                },
              ));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future getUserData() async {
    var response =
        await http.get(Uri.https("jsonplaceholder.typicode.com", "/albums"));
    if (response.statusCode == 200) {
      setState(() {
        dataResponse = response.body;
      });
      var jsonData = jsonDecode(response.body);
      List<User> users = [];
      for (var u in jsonData) {
        User user = User(u["userId"], u["id"], u["title"]);
        users.add(user);
      }
      // for (var i in users) {
      //   print(i.email);
      // }
      // print(users.toString());
      // print(dataResponse);
      print(users.length);
      return users;
    }
  }
}

// List<User> users = [];

class User {
  final String title;
  final int userId;
  final int id;

  User(
    this.id,
    this.userId,
    this.title,
  );
}
