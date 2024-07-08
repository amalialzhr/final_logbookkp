
// import '../../widgets/custom_icon_button.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../models/internship.dart';
// import 'widgets/listkerja_item_widget.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

// class MainpageScreen extends StatefulWidget {
//   const MainpageScreen({Key? key}) : super(key: key);

//   @override
//   _MainpageScreenState createState() => _MainpageScreenState();
// }

// class _MainpageScreenState extends State<MainpageScreen> {
//   List<InternshipElement> _internships = [];
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _fetchInternships();
//   }

//   Future<void> _fetchInternships() async {
//     try {
//       final token = await _readToken();
//       final response = await http.get(
//         Uri.parse('https://backend-pmp.unand.dev/api/my-internships'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         print('Response data: $jsonData'); // Print response data

//         final internship = Internship.fromJson(jsonData);
//         setState(() {
//           _internships = internship.internships;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _isLoading = false;
//           _errorMessage = 'Failed to load internships. Status code: ${response.statusCode}';
//         });
//         print('Failed to load internships. Status code: ${response.statusCode}');
//       }
//     } catch (error) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = 'Failed to load internships. Error: $error';
//       });
//       print('Failed to load internships. Error: $error');
//     }
//   }

//   Future<String> _readToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('login_token') ?? '';
//     return token;
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage != null
//               ? Center(child: Text(_errorMessage!))
//               : SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(height: 16.0),
//                       _buildRowLockOne(context),
//                       SizedBox(height: 30.0),
//                       _buildListKerja(),
//                       SizedBox(height: 30.0), // Spasi tambahan jika diperlukan
//                     ],
//                   ),
//                 ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//   return PreferredSize(
//     preferredSize: Size.fromHeight(kToolbarHeight),
//     child: CustomAppBar(
//       title: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () {
//               Navigator.pop(context); // Kembali ke halaman sebelumnya
//             },
//           ),
//           SizedBox(width: 8.0),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "List Kerja Praktek",
//                 style: CustomTextStyles.bodyLarge_1.copyWith(color: Colors.white),
//               )
//             ],
//           ),
//         ],
//       ),
//       styleType: Style.bgFill,
//     ),
//   );
// }


//   Widget _buildRowLockOne(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 12.0),
//       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5.0),
//         border: Border.all(color: Theme.of(context).primaryColor),
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: CustomIconButton(
//               height: 54.0,
//               width: 54.0,
//               child: CustomImageView(
//                 imagePath: ImageConstant.imgLock,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "(Nama User)",
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   "(NIM User)",
//                   style: CustomTextStyles.bodySmall9bold,
//                 ),
//                 Text(
//                   "(Prodi User)",
//                   style: CustomTextStyles.bodySmall9,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildListKerja() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: _internships.length,
//       itemBuilder: (context, index) {
//         final internship = _internships[index];
        
//         String formattedTanggal = '';

//         if (internship.startAt != null && internship.endAt != null) {
//           formattedTanggal =
//               '${internship.startAt!.day}-${internship.startAt!.month}-${internship.startAt!.year} - ${internship.endAt!.day}-${internship.endAt!.month}-${internship.endAt!.year}';
//         } else if (internship.startAt == null && internship.endAt == null) {
//           formattedTanggal = 'Tanggal tidak tersedia';
//         } else if (internship.startAt == null) {
//           formattedTanggal =
//               'Tanggal tidak tersedia - ${internship.endAt!.day}-${internship.endAt!.month}-${internship.endAt!.year}';
//         } else if (internship.endAt == null) {
//           formattedTanggal =
//               '${internship.startAt!.day}-${internship.startAt!.month}-${internship.startAt!.year} - Tanggal tidak tersedia';
//         }

//          return ListkerjaItemWidget(
//           internshipId: internship.id, 
//           namaTempat: internship.company,
//           tanggalKP: formattedTanggal,
//           status: internship.status,
//           seminarDate: internship.seminarDate,
//           grade: internship.grade,
//           lecturer: internship.lecturer,
//         );
//       },
//     );
//   }
// }

//KODINGAN DI BAWAH INI ADALAH KODINGAN MODIFIKASI LSIT QUOTES UAS 


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/listquotes_uas.dart';

class MainpageScreen extends StatefulWidget {
  const MainpageScreen({Key? key}) : super(key: key);

  @override
  _MainpageScreenState createState() => _MainpageScreenState();
}

class _MainpageScreenState extends State<MainpageScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  Quote? _quoteOfTheDay;

  @override
  void initState() {
    super.initState();
    _fetchQuoteOfTheDay();
  }

  Future<void> _fetchQuoteOfTheDay() async {
    try {
      final response = await http.get(
        Uri.parse('https://thingproxy.freeboard.io/fetch/https://favqs.com/api/qotd'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final logbook = Logbook.fromJson(jsonData);
        setState(() {
          _quoteOfTheDay = logbook.quote;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load quote of the day. Status code: ${response.statusCode}';
        });
        print('Failed to load quote of the day. Status code: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load quote of the day. Error: $error';
      });
      print('Failed to load quote of the day. Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 16.0),
                      _buildQuoteDisplay(),
                      SizedBox(height: 30.0),
                    ],
                  ),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "List Quotes (Modifikasi UAS)",
                  style: CustomTextStyles.bodyLarge_1.copyWith(color: Colors.white),
                )
              ],
            ),
          ],
        ),
        styleType: Style.bgFill,
      ),
    );
  }

  Widget _buildQuoteDisplay() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: _quoteOfTheDay != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _quoteOfTheDay!.body,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Author: ${_quoteOfTheDay!.author}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 16.0,
                  ),
                ),
              ],
            )
          : Center(child: Text("No Quote Available")),
    );
  }
}
