class NoteForListing {
  String noteID;
  String noteTitles;
  DateTime createDateTime;
  DateTime lastEditDateTime;

  NoteForListing(
      {required this.noteID,
      required this.noteTitles,
      required this.createDateTime,
      required this.lastEditDateTime});
}
