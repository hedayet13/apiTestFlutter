import 'package:flutter/material.dart';

class EditPAge extends StatelessWidget {
  

  final String noteID;
  const EditPAge({Key? key, required this.noteID} ) : super(key: key);
  // EditPAge(this.noteID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Nore"),
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
                  //update note in api
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
