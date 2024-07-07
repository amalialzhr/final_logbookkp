import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class DetailLogHarianScreen extends StatelessWidget {
  DetailLogHarianScreen({Key? key}) : super(key: key);

  TextEditingController dateoneController = TextEditingController();
  TextEditingController activitydetailsController = TextEditingController();
  TextEditingController weburlController = TextEditingController();

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
                    horizontal: 22.h,
                    vertical: 30.v,
                  ),
                  child: Column(
                    children: [
                      _buildColumnWaktu(context),
                      SizedBox(height: 15.v),
                      _buildColumnKegiatan(context),
                      SizedBox(height: 15.v),
                      _buildColumnRincian(context),
                      SizedBox(height: 15.v),
                      _buildColumn(context),
                      SizedBox(height: 15.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "File Terkait ",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(height: 5.v),
                      CustomTextFormField(
                        width: 80.h,
                        controller: weburlController,
                        hintText: "progress2.pdf",
                        textInputAction: TextInputAction.done,
                        alignment: Alignment.centerLeft,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 11.h,
                          vertical: 8.v,
                        ),
                        borderDecoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide(color: appTheme.gray500),
                        ),
                        fillColor: appTheme.gray50,
                      ),
                      SizedBox(height: 60.v),
                      CustomElevatedButton(
                        text: "Kirim",
                        margin: EdgeInsets.symmetric(horizontal: 100.h),
                        buttonTextStyle: theme.textTheme.titleSmall!,
                      ),
                      SizedBox(height: 20.v)
                    ],
                  ),
                )
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
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
          ),
          SizedBox(width: 8.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detail Log Book",
                style: CustomTextStyles.bodyLarge_1,
              )
            ],
          ),
        ],
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildColumnWaktu(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Waktu",
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 5.v),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(color: appTheme.gray500),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12.v),
                SizedBox(
                  width: 1000.h,
                  child: Text(
                    "40 desember 8453 ",
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: theme.textTheme.bodySmall!.copyWith(
                      height: 1.82,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildColumnKegiatan(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kegiatan",
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 5.v),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(color: appTheme.gray500),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12.v),
                SizedBox(
                  width: 1000.h,
                  child: Text(
                    "Membuat FE untuk Role XYZ ",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: theme.textTheme.bodySmall!.copyWith(
                      height: 1.82,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildColumnRincian(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rincian Kegiatan",
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 5.v),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(color: appTheme.gray500),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12.v),
                SizedBox(
                  width: 1000.h,
                  child: Text(
                    "Langkah-langkah utama yang saya ambil termasuk merancang tata letak (layout) halaman, mendesain elemen UI seperti tombol dan input field, serta menyesuaikan desain dengan kebutuhan fungsional ",
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: theme.textTheme.bodySmall!.copyWith(
                      height: 1.82,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildColumn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Capaian",
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 5.v),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(color: appTheme.gray500),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12.v),
                SizedBox(
                  width: 1000.h,
                  child: Text(
                    "Pengembangan UI Role XYZ menggunakan Flutter.\nIntegrasi fitur UI dengan logika backend.\nPengujian fungsional dan debugging.\nKolaborasi dengan tim backend dan desainer UI.",
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: theme.textTheme.bodySmall!.copyWith(
                      height: 1.82,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
