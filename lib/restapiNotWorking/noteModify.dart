import 'package:flutter/material.dart';

class CreateNotePage extends StatelessWidget {
  const CreateNotePage({Key? key}) : super(key: key);
  // CreateNotePage(this.noteID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create note"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Note Title"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "Note Content"),
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  //create note in api
                  Navigator.of(context).pop();
                },
                child: Text("button"),
                color: Colors.greenAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
