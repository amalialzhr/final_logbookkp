
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/logbook.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../core/app_export.dart';

class EditLogHarianScreen extends StatefulWidget {

  @override
  _EditLogHarianScreenState createState() => _EditLogHarianScreenState();
}

class _EditLogHarianScreenState extends State<EditLogHarianScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _activitiesController;
  late TextEditingController _noteController;
  late Log log;
  late DateTime _selectedDate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log = ModalRoute.of(context)!.settings.arguments as Log;
    _activitiesController = TextEditingController(text: log.activities);
    _noteController = TextEditingController(text: log.note ?? '');
    _selectedDate = log.date;
  }

  @override
  void dispose() {
    _activitiesController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _updateLog() async {
    if (_formKey.currentState!.validate()) {
      final updatedLog = Log(
        id: log.id,
        internshipId: log.internshipId,
        date: _selectedDate,
        activities: _activitiesController.text,
        note: _noteController.text, // Update note from _noteController
        createdAt: log.createdAt,
        updatedAt: DateTime.now(),
      );

      try {
        final token = await _readToken();
        final response = await http.put(
          Uri.parse('https://backend-pmp.unand.dev/api/my-internships/${log.internshipId}/logs/${log.id}'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: json.encode(updatedLog.toJson()),
        );

        if (response.statusCode == 200) {
          final dynamic jsonData = jsonDecode(response.body);
          if (jsonData != null && jsonData['status'] == 'success' && jsonData['log'] != null) {
            Log updatedLog = Log.fromJson(jsonData['log']);
            print('Updated log data: ${updatedLog.toJson()}');
            Navigator.pop(context, updatedLog); 
          } else {
            print('Invalid log data received');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update log. Response does not contain valid log data.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update log. Status code: ${response.statusCode}')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update log. Error: $error')),
        );
      }
    }
  }

  Future<String> _readToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('login_token') ?? '';
    return token;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 42.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildColumnWaktu(context),
                        SizedBox(height: 15.0),
                        _buildColumnKegiatan(context),
                        SizedBox(height: 11.0),
                        _buildColumnRincian(context),
                        SizedBox(height: 70.0),
                        ElevatedButton(
                          onPressed: _updateLog,
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 100.0,
                              vertical: 25.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: 
            () {
              Navigator.pop(context); // Just pop the context to go back
            },  
          ),
          SizedBox(width: 8.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Log Book",
                style: CustomTextStyles.bodyLarge_1,
              ),
            ],
          ),
        ],
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildColumnWaktu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tanggal",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 2.0),
        InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                  style: TextStyle(color: Colors.black),
                ),
                Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColumnKegiatan(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kegiatan",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 1.0),
        TextField(
          controller: _activitiesController,
          maxLines: null,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.blue),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
          ),
        ),
      ],
    );
  }

  Widget _buildColumnRincian(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Catatan",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 1.0),
        TextField(
          controller: _noteController,
          maxLines: null,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.blue),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 12.0),
          ),
        ),
      ],
    );
  }
}
