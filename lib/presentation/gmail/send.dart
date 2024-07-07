import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendLogbookEmail(String date, String activities, String note) async {
  print("sendLogbookEmail called with date: $date, activities: $activities, note: $note");
  
  String username = 'amalialzhr13@gmail.com';
  String password = 'gxjrjwhxosdtppvj';

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'Amalia')
    ..recipients.add('amalialzhr13@gmail.com')
    ..subject = 'Logbook Report :: ${DateTime.now()}'
    ..text = 'Date: $date\n\nActivities: $activities\n\nNote: $note';

  try {
    print('Attempting to send message...');
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent. \n${e.toString()}');
  } catch (e) {
    print('Unexpected error: ${e.toString()}');
  }
}
