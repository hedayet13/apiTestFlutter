import 'dart:developer';

import 'package:apitest/editPage.dart';
import 'package:apitest/models/apiResopnse.dart';
import 'package:apitest/models/noteForListing.dart';
import 'package:apitest/noteDelete.dart';
import 'package:apitest/noteModify.dart';
import 'package:apitest/services/noteService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RestApi extends StatefulWidget {
  RestApi({Key? key}) : super(key: key);

  @override
  _RestApiState createState() => _RestApiState();
}

class _RestApiState extends State<RestApi> {
  // final service = NoteService();
  NoteService get service => GetIt.I<NoteService>();

  late APIResponse<List<NoteForListing>> _apiResponse;
  bool _isloading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isloading = true;
    });

    _apiResponse = await service.getNotesList();
    setState(() {
      _isloading = false;
    });
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
        child: _isloading
            ? CircularProgressIndicator()
            : ListView.separated(
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: ValueKey(_apiResponse.data[index].noteID),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {},
                    confirmDismiss: (direction) async {
                      final result = await showDialog(
                          context: context, builder: (_) => NoteDelete());
                      print(result);
                      return result;
                    },
                    background: Container(
                      color: Colors.red[900],
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
                                  builder: (context) => EditPAge(
                                      noteID:
                                          _apiResponse.data[index].noteID)));
                        },
                        title: Text(_apiResponse.data[index].noteTitles),
                        subtitle: Text(
                            " Last edited on ${formatDateTime(_apiResponse.data[index].lastEditDateTime)}")),
                  );
                },
                separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: Colors.green,
                    ),
                itemCount: _apiResponse.data.length),
      ),
    );
  }
}
