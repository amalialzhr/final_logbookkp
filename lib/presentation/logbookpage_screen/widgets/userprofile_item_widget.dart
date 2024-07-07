
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../../../core/app_export.dart';
import '../../../models/logbook.dart';
class UserprofileItemWidget extends StatelessWidget {
  final Log log;
  final int index;
  final Function(Log) onUpdateLog;

  UserprofileItemWidget({
    required this.log,
    required this.index,
    required this.onUpdateLog,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 14.0,
                child: Text(
                  "${index.toString()}",
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
              Text(
                log.date.toString(),
                style: TextStyle(),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            log.activities,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Note: ${log.note ?? '-'}",
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  print("Menu selected: $value");
                  switch (value) {
                    case 'Edit':
                      Navigator.pushNamed(context, AppRoutes.editLogHarianScreen, arguments: log).then((updatedLog) {
                        if (updatedLog != null && updatedLog is Log) {
                          onUpdateLog(updatedLog);
                        }
                      });
                      break;
                    case 'Send':
                      print("Send menu clicked");
                      sendLogbookEmail(log.date.toString(), log.activities, log.note ?? '-');
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'Edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8.0),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Send',
                    child: Row(
                      children: [
                        Icon(Icons.email),
                        SizedBox(width: 8.0),
                        Text('Send'),
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  print("Send button clicked");
                  sendLogbookEmail(log.date.toString(), log.activities, log.note ?? '-');
                },
                child: Text('Send Email Test'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> sendLogbookEmail(String date, String activities, String note) async {
  print("sendLogbookEmail called");  // Log function call
  String username = 'amalialzhr13@gmail.com';
  String password = 'tes';

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'Amalia')
    ..recipients.add('amalialzhrh13@gmail.com')
    ..subject = 'Logbook Report :: ${DateTime.now()}'
    ..text = 'Date: $date\n\nActivities: $activities\n\nNote: $note';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent. \n${e.toString()}');
  }
}

