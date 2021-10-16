import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HTTPReq extends StatefulWidget {
  HTTPReq({Key? key}) : super(key: key);

  @override
  _HTTPReqState createState() => _HTTPReqState();
}

class _HTTPReqState extends State<HTTPReq> {
  PostService postService = PostService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UserData"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder<List>(
          future: postService.getPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return Text(snapshot.data!.toString());
              if (snapshot.data?.length == 0) {
                return Center(
                  child: Text("No data available"),
                );
              } else
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data?[index]['username']),
                        subtitle: Text(snapshot.data?[index]['name']),
                        trailing: Text(snapshot.data?[index]['email']),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewPage(
                                        name: snapshot.data?[index]['name'],
                                        email: snapshot.data?[index]['email'],
                                        username: snapshot.data?[index]
                                            ['username'],
                                        phoneNumber: snapshot.data?[index]
                                            ['phone'],
                                        website: snapshot.data?[index]
                                            ['website'],
                                      )));
                        },
                        // subtitle: Text("${}"),
                      );
                    });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  final String name, username, email, phoneNumber, website;

  const NewPage(
      {Key? key,
      required this.name,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.website})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Personal Details",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  decorationThickness: 1.2),
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(100, 0, 0, 0)),
                        Text(
                          "Full Name:  ",
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          name,
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(100, 0, 0, 0)),
                        Text(
                          "User Name:  ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          username,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(100, 0, 0, 0)),
                        Text(
                          "Email:  ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          email,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(100, 0, 0, 0)),
                        Text(
                          "Phone Number:  ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          phoneNumber,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(100, 0, 0, 0)),
                        Text(
                          "Website:  ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          website,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   username,
                  //   style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  // ),
                  // Text(
                  //   email,
                  //   style: TextStyle(fontSize: 20),
                  // ),
                  // Text(
                  //   phoneNumber,
                  //   style: TextStyle(fontSize: 20),
                  // ),
                  // Text(
                  //   website,
                  //   style: TextStyle(fontSize: 20),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostService {
  String url = "https://jsonplaceholder.typicode.com/users";

  Future<List> getPost() async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.body);
        return jsonDecode(response.body);
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error("Error fetching deta");
    }
  }
}

// Future<Album> fetchAlbum() async {
//   final response =
//       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

