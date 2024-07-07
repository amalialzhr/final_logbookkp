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
    String internshipId;
    DateTime date;
    String activities;
    dynamic note;
    String id;
    DateTime updatedAt;
    DateTime createdAt;

    Log({
        required this.internshipId,
        required this.date,
        required this.activities,
        required this.note,
        required this.id,
        required this.updatedAt,
        required this.createdAt,
    });

    factory Log.fromJson(Map<String, dynamic> json) => Log(
        internshipId: json["internship_id"],
        date: DateTime.parse(json["date"]),
        activities: json["activities"],
        note: json["note"],
        id: json["id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "internship_id": internshipId,
        "date": date.toIso8601String(),
        "activities": activities,
        "note": note,
        "id": id,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
    };
}
