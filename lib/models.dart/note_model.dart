// To parse this JSON data, do
//
//final noteResponse = noteResponseFromJson(jsonString);

import 'dart:convert';

NoteResponse noteResponseFromJson(String str) =>
    NoteResponse.fromJson(json.decode(str));

String noteResponseToJson(NoteResponse data) => json.encode(data.toJson());

class NoteResponse {
  String? status;
  int? results;
  List<Note>? notes;
  Note? note;
  String? message;

  NoteResponse({this.status, this.results, this.notes, this.message});

  factory NoteResponse.fromJson(Map<String, dynamic> json) => NoteResponse(
        status: json["status"],
        results: json["results"],
        notes: json["notes"] == null
            ? []
            : List<Note>.from(json["notes"]!.map((x) => Note.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "results": results,
        "notes": notes == null
            ? []
            : List<dynamic>.from(notes!.map((x) => x.toJson())),
      };
}

class Note {
  String id;
  String? title;
  String? content;
  String uid;

  Note({
    required this.id,
    this.title,
    this.content,
    required this.uid,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
        "uid": uid,
      };
}
