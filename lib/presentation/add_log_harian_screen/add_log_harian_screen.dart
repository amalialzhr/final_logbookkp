import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';

class AddLogHarianScreen extends StatefulWidget {
  AddLogHarianScreen({Key? key}) : super(key: key);

  @override
  _AddLogHarianScreenState createState() => _AddLogHarianScreenState();
}

class _AddLogHarianScreenState extends State<AddLogHarianScreen> {
  TextEditingController edittextoneController = TextEditingController();
  TextEditingController edittexttuController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late String internshipId;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    internshipId = args['internshipId'];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _addLogbook() async {
    setState(() {
      _isLoading = true;
    });

    if (edittextoneController.text.isEmpty || edittexttuController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kegiatan dan Catatan harus diisi.'),
          duration: Duration(seconds: 3),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    String url = 'https://backend-pmp.unand.dev/api/my-internships/$internshipId/logs';
    try {
      var token = await _readToken();

      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

      var logbook = {
        "internship_id": internshipId,
        "date": selectedDate.toIso8601String(),
        "activities": edittextoneController.text, // Menggunakan edittextoneController untuk activities
        "note": edittexttuController.text, // Menggunakan edittexttwoController untuk note
      };

      var body = jsonEncode(logbook);
      print(body); // Debugging output

      var response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logbook berhasil ditambahkan!'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menambahkan logbook. Silakan coba lagi.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
       print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}"); // Debugging output untuk melihat response body
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan logbook. Silakan coba lagi.'),
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> _readToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('login_token') ?? '';
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.h,
                          vertical: 42.v,
                        ),
                        child: Column(
                          children: [
                            _buildColumnWaktu(context),
                            SizedBox(height: 15.v),
                            _buildColumnKegiatan(context),
                            SizedBox(height: 11.v),
                            _buildColumnRincian(context),
                            SizedBox(height: 70.v),
                            CustomElevatedButton(
                              text: "Tambah",
                              margin: EdgeInsets.only(
                                left: 100.h,
                                right: 100.h,
                              ),
                              buttonTextStyle: theme.textTheme.titleSmall!,
                              onPressed: () {
                                _addLogbook();
                              },
                            ),
                            SizedBox(height: 5.v),
                          ],
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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(width: 8.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tambah Log Book",
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
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 2.v),
        InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.v, horizontal: 10.h),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 8, 8, 8)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
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
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 1.v),
        TextField(
          controller: edittextoneController,
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
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 1.v),
        TextField(
          controller: edittexttuController,
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
