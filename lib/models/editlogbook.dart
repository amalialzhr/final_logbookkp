// To parse this JSON data, do
//
//     final logbook = logbookFromJson(jsonString);

import 'dart:convert';

Logbook logbookFromJson(String str) => Logbook.fromJson(json.decode(str));

String logbookToJson(Logbook data) => json.encode(data.toJson());

class Logbook {
    String status;
    String message;
    Log log;

    Logbook({
        required this.status,
        required this.message,
        required this.log,
    });

    factory Logbook.fromJson(Map<String, dynamic> json) => Logbook(
        status: json["status"],
        message: json["message"],
        log: Log.fromJson(json["log"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "log": log.toJson(),
    };
}

class Log {
    String id;
    String internshipId;
    DateTime date;
    String activities;
    dynamic note;
    DateTime createdAt;
    DateTime updatedAt;

    Log({
        required this.id,
        required this.internshipId,
        required this.date,
        required this.activities,
        required this.note,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Log.fromJson(Map<String, dynamic> json) => Log(
        id: json["id"],
        internshipId: json["internship_id"],
        date: DateTime.parse(json["date"]),
        activities: json["activities"],
        note: json["note"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "internship_id": internshipId,
        "date": date.toIso8601String(),
        "activities": activities,
        "note": note,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
