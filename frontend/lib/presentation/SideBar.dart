import 'dart:io';

import 'package:dating_your_date/theme/custom_text_style.dart';
import 'package:dating_your_date/theme/theme_helper.dart';
import 'package:dating_your_date/widgets/custom_sideBar.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  SideBar({Key? key, this.name, this.imageUrl, this.purpose}) : super(key: key);

  final String? purpose;
  final String? name;
  final File? imageUrl;

  @override
  State<StatefulWidget> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double mediaH = mediaQueryData.size.height;
    double mediaW = mediaQueryData.size.width;
    return SizedBox(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        decoration: BoxDecoration(color: appTheme.pinkA100, borderRadius: BorderRadius.zero),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // add date
            Text("2023-11-01から", style: TextStyle(color: appTheme.grey800)),
            SizedBox(height: mediaH / 300),

            _buildUserRow(context, mediaH, mediaW),
            _buildCheckPointRow(context, mediaH, mediaW),

            // 写真解放
            CustomSideBar(item: "写真解放"),
            SizedBox(height: mediaH / 25),

            // 連絡解放
            CustomSideBar(item: "連絡解放"),
            SizedBox(height: mediaH / 25),

            // 位置共有
            CustomSideBar(item: "位置共有"),
            SizedBox(height: mediaH / 25),

            // デート解放
            CustomSideBar(item: "デート解放"),
            SizedBox(height: mediaH / 25),

            // SNS共有
            CustomSideBar(item: "SNS共有"),
            SizedBox(height: mediaH / 25),
          ],
        ),
      ),
    );
  }

  /// User data box
  Widget _buildUserRow(BuildContext context, double mediaH, double mediaW) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mediaW / 100),
      padding: EdgeInsets.symmetric(horizontal: mediaW / 30, vertical: mediaH / 100),
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: FileImage(widget.imageUrl!), maxRadius: 25),
          Padding(
            padding: EdgeInsets.only(left: mediaW / 75),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name!, style: CustomTextStyles.sideBarTitle),
                Text(widget.purpose!, style: CustomTextStyles.sideBarTitle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// item Title
  Widget _buildCheckPointRow(BuildContext context, double mediaH, double mediaW) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: mediaH / 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Link 1
          Padding(
            padding: EdgeInsets.only(top: mediaH / 65, bottom: mediaH / 65, right: mediaW / 30),
            child: SizedBox(width: mediaW / 10, child: Divider()),
          ),
          // title
          Text("チェックポイント", style: CustomTextStyles.msgWordOfMsgBox),
          // Link 2
          Padding(
            padding: EdgeInsets.only(top: mediaH / 65, bottom: mediaH / 65, left: mediaW / 30),
            child: SizedBox(width: mediaW / 10, child: Divider()),
          ),
        ],
      ),
    );
  }
}
