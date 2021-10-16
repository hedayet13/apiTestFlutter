import 'package:apitest/httpReq/httpPageNotWorking.dart';
import 'package:apitest/httpReq/httpReq.dart';
import 'package:apitest/restapiNotWorking/restApi.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {},
                child: Text("Apicall"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RestApi()));
                },
                child: Text("RestApi"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HtttpPage()));
                },
                child: Text("HTTP Req Only show json data"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HTTPReq()));
                },
                child: Text("HTTP req"),
              )
            ],
          ),
        ],
      )),
    );
  }
}
