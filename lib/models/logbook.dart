import 'dart:convert';

Logbook logbookFromJson(String str) => Logbook.fromJson(json.decode(str));

String logbookToJson(Logbook data) => json.encode(data.toJson());

class Logbook {
    String status;
    String message;
    int count;
    Log logs;

    Logbook({
        required this.status,
        required this.message,
        required this.count,
        required this.logs,
    });

    factory Logbook.fromJson(Map<String, dynamic> json) => Logbook(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        logs: Log.fromJson(json["logs"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "count": count,
        "logs": logs.toJson(),
    };
}

class Log{
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
        this.note,
        required this.createdAt,
        required this.updatedAt,
    });

  factory Log.fromJson(Map<String, dynamic> json) {
  return Log(
    id: json["id"] ?? '',
    internshipId: json["internship_id"] ?? '',
    date: json["date"] != null ? DateTime.parse(json["date"]) : DateTime.now(),
    activities: json["activities"] ?? '',
    note: json["note"] ?? '', // Biarkan nullable sesuai respons API
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
  );
}

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
