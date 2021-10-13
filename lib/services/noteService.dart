import 'dart:convert';

import 'package:apitest/models/apiResopnse.dart';
import 'package:apitest/models/noteForListing.dart';
import 'package:apitest/restApi.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const headers = {"apiKey": "96c2294f-c3af-4a67-a83c-667151182507"};
  var API = Uri.https(
      "https://tq-notes-api-jkrgrdggbq-el.a.run.app/apiKey", '/notes', headers);
  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          final note = NoteForListing(
              noteID: item['noteID'],
              noteTitles: item['noteTitles'],
              createDateTime: DateTime.parse(item['createDateTime']),
              lastEditDateTime: DateTime.parse(item['lastEditDateTime']));
          notes.add(note);
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errorMessage: "An error occured", data: []);
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMessage: "An error occured", data: []));
  }
}
