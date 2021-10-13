import 'package:apitest/editPage.dart';
import 'package:apitest/models/noteForListing.dart';
import 'package:apitest/noteDelete.dart';
import 'package:apitest/noteModify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestApi extends StatefulWidget {
  RestApi({Key? key}) : super(key: key);

  @override
  _RestApiState createState() => _RestApiState();
}

class _RestApiState extends State<RestApi> {
  final notes = [
    new NoteForListing(
        noteID: "1",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitles: "Note 1"),
    new NoteForListing(
        noteID: "2",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitles: "Note 2"),
    new NoteForListing(
        noteID: "3",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitles: "Note 3")
  ];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Note"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CreateNotePage()));
        },
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ListView.separated(
            itemBuilder: (_, index) {
              return Dismissible(
                key: ValueKey(notes[index].noteID),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context, builder: (_) => NoteDelete());
                  print(result);
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerLeft),
                ),
                child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditPAge(noteID: notes[index].noteID)));
                    },
                    title: Text(notes[index].noteTitles),
                    subtitle: Text(
                        " Last edited on ${formatDateTime(notes[index].lastEditDateTime)}")),
              );
            },
            separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: Colors.green,
                ),
            itemCount: notes.length),
      ),
    );
  }
}
