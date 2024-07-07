// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:amalia_s_application1/models/login.dart';

// class Repository {
//   final String baseUrl = "https://backend-pmp.unand.dev/";

//   Future<Welcome> welcome(String email, String password) async {
//     final response = await http.post(
//       Uri.parse("${baseUrl}/api/login"),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "email": email,
//         "password": password,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       print(data);  // Tambahkan ini untuk melihat struktur JSON
//       var login = Welcome.fromJson(data['data']['authorization']);
//       return login;
//     } else {
//       throw Exception("Failed to login: ${response.statusCode}, ${response.body}");
//     }
//   }
// }
