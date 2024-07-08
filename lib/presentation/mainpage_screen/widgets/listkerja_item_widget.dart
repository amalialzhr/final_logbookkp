// import 'package:flutter/material.dart';
// import '../../../core/app_export.dart';
// import '../../../widgets/custom_elevated_button.dart';

// class ListkerjaItemWidget extends StatelessWidget {
//   final String namaTempat;
//   final String tanggalKP;
//   final String status;
//   final DateTime? seminarDate;
//   final String grade;
//   final String lecturer;
//   final String internshipId;

//   const ListkerjaItemWidget({
//     Key? key,
//     required this.namaTempat,
//     required this.tanggalKP,
//     required this.status,
//     required this.seminarDate,
//     required this.grade,
//     required this.lecturer,
//     required this.internshipId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey[300]!),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 tanggalKP,
//                 style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "Status: $status",
//                 style: TextStyle(
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[700],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8.0),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(
//               namaTempat,
//               style: TextStyle(fontSize: 14.0),
//             ),
//           ),
//           SizedBox(height: 12.0),
//           if (seminarDate != null)
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(
//                 "Seminar Date: ${seminarDate!.toLocal()}",
//                 style: TextStyle(fontSize: 12.0),
//               ),
//             ),
//           SizedBox(height: 8.0),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(
//               "Grade: $grade",
//               style: TextStyle(fontSize: 12.0),
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(
//               "Lecturer: $lecturer",
//               style: TextStyle(fontSize: 12.0),
//             ),
//           ),
//           SizedBox(height: 12.0),
//           Align(
//             alignment: Alignment.centerRight,
//             child: CustomElevatedButton(
//               height: 32.0,
//               width: 120.0,
//               text: "Lihat Logbook",
//               buttonTextStyle: TextStyle(
//                 color: Colors.white,
//                 fontSize: 13.0,
//                 fontWeight: FontWeight.bold,
//               ),
//               onPressed: () {
//                 Navigator.pushNamed(
//                   context,
//                   AppRoutes.logbookpageScreen,
//                   arguments: {'internshipId': internshipId}, // Correctly passing internshipId
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
