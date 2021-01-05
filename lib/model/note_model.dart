class Note {
  int id;
  String title;
  String content;
  String date_created;
  int note_color;

  Note({this.id, this.title, this.content, this.date_created, this.note_color});

  Note.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.title = map["title"];
    this.content = map["content"];
    this.date_created = map["date_created"];
    this.note_color = map["note_color"];
  }

  Map<String, dynamic> toMap() {
    return {
      "title": this.title,
      "content": this.content,
      "date_created": this.date_created,
      "note_color": this.note_color,
    };
  }
}
