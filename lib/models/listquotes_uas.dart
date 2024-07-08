// To parse this JSON data, do
//
//     final logbook = logbookFromJson(jsonString);

import 'dart:convert';

Logbook logbookFromJson(String str) => Logbook.fromJson(json.decode(str));

String logbookToJson(Logbook data) => json.encode(data.toJson());

class Logbook {
    DateTime qotdDate;
    Quote quote;

    Logbook({
        required this.qotdDate,
        required this.quote,
    });

    factory Logbook.fromJson(Map<String, dynamic> json) => Logbook(
        qotdDate: DateTime.parse(json["qotd_date"]),
        quote: Quote.fromJson(json["quote"]),
    );

    Map<String, dynamic> toJson() => {
        "qotd_date": qotdDate.toIso8601String(),
        "quote": quote.toJson(),
    };
}

class Quote {
    int id;
    bool dialogue;
    bool private;
    List<String> tags;
    String url;
    int favoritesCount;
    int upvotesCount;
    int downvotesCount;
    String author;
    String authorPermalink;
    String body;

    Quote({
        required this.id,
        required this.dialogue,
        required this.private,
        required this.tags,
        required this.url,
        required this.favoritesCount,
        required this.upvotesCount,
        required this.downvotesCount,
        required this.author,
        required this.authorPermalink,
        required this.body,
    });

    factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["id"],
        dialogue: json["dialogue"],
        private: json["private"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        url: json["url"],
        favoritesCount: json["favorites_count"],
        upvotesCount: json["upvotes_count"],
        downvotesCount: json["downvotes_count"],
        author: json["author"],
        authorPermalink: json["author_permalink"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dialogue": dialogue,
        "private": private,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "url": url,
        "favorites_count": favoritesCount,
        "upvotes_count": upvotesCount,
        "downvotes_count": downvotesCount,
        "author": author,
        "author_permalink": authorPermalink,
        "body": body,
    };
}
