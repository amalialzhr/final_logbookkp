import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_floating_button.dart';

import '../../models/logbook.dart';
import '../../../widgets/custom_icon_button.dart';

class LogbookpageScreen extends StatefulWidget {
  @override
  _LogbookpageScreenState createState() => _LogbookpageScreenState();
}

class _LogbookpageScreenState extends State<LogbookpageScreen> {
  List<Log> _logbooks = [];
  bool _isLoading = true;
  String? _errorMessage;
  late String internshipId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    internshipId = arguments['internshipId'];
    _fetchLogbooks();
  }

  Future<void> _fetchLogbooks() async {
  try {
    final token = await _readToken();
    final response = await http.get(
      Uri.parse('https://backend-pmp.unand.dev/api/my-internships/$internshipId/logs'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      if (jsonData != null && jsonData['status'] == 'success') {
        if (jsonData['logs'] != null) { // Check if 'logs' is not null
          List<Log> logs = List<Log>.from(jsonData["logs"].map((x) => Log.fromJson(x)));
          setState(() {
            _logbooks = logs;
            _isLoading = false;
          });
        } else {
          _setError('Failed to load logbooks. Logs data is null or not found.');
        }
      } else {
        _setError('Failed to load logbooks. Response body does not indicate success.');
      }
    } else {
      _setError('Failed to load logbooks. Status code: ${response.statusCode}');
    }
  } catch (error) {
    _setError('Failed to load logbooks. Error: $error');
  }
}

  void _setError(String message) {
    setState(() {
      _isLoading = false;
      _errorMessage = message;
    });
    print(message);
  }

  Future<String> _readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('login_token') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(child: Text(_errorMessage!))
                : Column(
                    children: [
                      SizedBox(height: 16.0),
                      _buildRowLockOne(context),
                      SizedBox(height: 16.0),
                      Expanded(child: _buildLogbookList()),
                    ],
                  ),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
            ),
            SizedBox(width: 8.0),
            Text(
              "List Logbook",
              style: CustomTextStyles.bodyLarge_1.copyWith(color: Colors.white),
            ),
          ],
        ),
        styleType: Style.bgFill,
      ),
    );
  }

  void updateLogbook(Log updatedLog) {
    setState(() {
      int index = _logbooks.indexWhere((log) => log.id == updatedLog.id);
      if (index != -1) {
        _logbooks[index] = updatedLog;
      }
    });
  }

  Widget _buildLogbookList() {
    return ListView.builder(
      itemCount: _logbooks.length,
      itemBuilder: (context, index) {
        final log = _logbooks[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: UserprofileItemWidget(
            log: log,
            index: index + 1,
            onUpdateLog: updateLogbook,
          ),
        );
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
      height: 41,
      width: 39,
      child: Icon(Icons.add, color: Colors.white),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.addLogHarianScreen, arguments: {'internshipId': internshipId});
      },
    );
  }

  Widget _buildRowLockOne(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CustomIconButton(
              height: 54.0,
              width: 54.0,
              child: CustomImageView(
                imagePath: ImageConstant.imgLock,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "(Nama User)",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "(NIM User)",
                  style: CustomTextStyles.bodySmall9bold,
                ),
                Text(
                  "(Jurusan User)",
                  style: CustomTextStyles.bodySmall9,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
                  switch (value) {
                    case 'Edit':
                      Navigator.pushNamed(context, AppRoutes.editLogHarianScreen, arguments: log).then((updatedLog) {
                        if (updatedLog != null && updatedLog is Log) {
                          onUpdateLog(updatedLog);
                        }
                      });
                      break;
                    case 'Send':
                      // Implement send functionality here
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
            ],
          ),
        ],
      ),
    );
  }
}

