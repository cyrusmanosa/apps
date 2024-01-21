<<<<<<< HEAD
import 'dart:typed_data';
=======
import 'dart:io';
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a

import 'package:dating_your_date/core/app_export.dart';
import 'package:dating_your_date/pb/canChange.pb.dart';
import 'package:dating_your_date/pb/fix.pb.dart';
import 'package:dating_your_date/presentation/ChatBox.dart';
import 'package:dating_your_date/presentation/Profile/widgets/showDataBar.dart';
<<<<<<< HEAD
import 'package:dating_your_date/widgets/Custom_Show_Image.dart';
=======
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a
import 'package:dating_your_date/widgets/app_bar/Custom_App_bar.dart';
import 'package:dating_your_date/widgets/button/custom_outlined_button.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
<<<<<<< HEAD
  UserPage({super.key, this.canData, this.fixData, this.img, this.allImage});

  final Fix? fixData;
  final Uint8List? img;
  final CanChange? canData;
  final List<Uint8List>? allImage;

=======
  UserPage({super.key, this.canData, this.fixData, this.img});

  final Fix? fixData;
  final List<File>? img;
  final CanChange? canData;
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double mediaH = mediaQueryData.size.height;
    double mediaW = mediaQueryData.size.width;
    return Scaffold(
      appBar: buildAppBar(context, "", true),
      backgroundColor: appTheme.bgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // image
<<<<<<< HEAD
            // Container(
            //   decoration: BoxDecoration(shape: BoxShape.circle),
            //   child: CircleAvatar(radius: 80, backgroundImage: MemoryImage(widget.img!)),
            // ),
            // SizedBox(height: mediaH / 50),

            _buildImages(context, mediaH, mediaW),
=======
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: CircleAvatar(radius: 80, backgroundImage: FileImage(widget.img![0])),
            ),
            SizedBox(height: mediaH / 50),
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a

            // name
            Text(
              widget.canData!.nickName + ',' + widget.fixData!.firstName,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            // ago
            Text(widget.fixData!.age.toString() + ' 才', style: TextStyle(fontSize: 18, color: appTheme.black)),
            SizedBox(height: mediaH / 50),

            // Part 1
            Text("マイプロフィール", style: CustomTextStyles.infoTitle),
            _buildPart1(context, mediaH, mediaW),
            SizedBox(height: mediaH / 40),

            // Part 2
            Text("基本情報", style: CustomTextStyles.infoTitle),
            _buildPart2(context, mediaH, mediaW),
            SizedBox(height: mediaH / 40),

            // btn
            _buildNextButton(context),
            SizedBox(height: mediaH / 15),
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildImages(BuildContext context, double mediaH, double mediaW) {
    return SizedBox(
      child: Container(
        height: mediaH / 6.5,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            // far left
            SizedBox(width: mediaW / 25),
            // image
            customImageDesignImage(context, widget.allImage![0], mediaH, mediaW),
            if (widget.allImage!.length >= 2) customImageDesignImage(context, widget.allImage![1], mediaH, mediaW),
            if (widget.allImage!.length >= 3) customImageDesignImage(context, widget.allImage![2], mediaH, mediaW),
            if (widget.allImage!.length >= 4) customImageDesignImage(context, widget.allImage![3], mediaH, mediaW),
            if (widget.allImage!.length >= 5) customImageDesignImage(context, widget.allImage![4], mediaH, mediaW),
            // far right
            SizedBox(width: mediaW / 25),
          ],
        ),
      ),
    );
  }

=======
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a
  /// Part 1
  Widget _buildPart1(BuildContext context, double mediaH, double mediaW) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediaW / 10, vertical: mediaH / 30),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 233, 233, 233),
          borderRadius: BorderRadiusStyle.r15,
          boxShadow: [BoxShadow(color: appTheme.grey800.withOpacity(0.4), blurRadius: 5, offset: Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("自己紹介", style: CustomTextStyles.showDataTitle),
            Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey)))),
            Text(widget.canData!.introduce, style: CustomTextStyles.smallTitle20),
            SizedBox(height: mediaH / 30),

            // gender
            ShownDataBarWidget(item: "性別", data: widget.fixData!.gender),
            SizedBox(height: mediaH / 40),

            // birth
            ShownDataBarWidget(item: "生年月日", data: widget.fixData!.birth),
            SizedBox(height: mediaH / 40),

            // constellations
            ShownDataBarWidget(item: "星座", data: widget.fixData!.constellation),
            SizedBox(height: mediaH / 40),

            // Country
            ShownDataBarWidget(item: "国籍", data: widget.fixData!.country),
            SizedBox(height: mediaH / 40),

            // blood
            ShownDataBarWidget(item: "血液型", data: widget.fixData!.blood),
            SizedBox(height: mediaH / 40),
          ],
        ),
      ),
    );
  }

  /// Part 2
  Widget _buildPart2(BuildContext context, double mediaH, double mediaW) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediaW / 10, vertical: mediaH / 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: appTheme.grey100,
          borderRadius: BorderRadiusStyle.r15,
          boxShadow: [BoxShadow(color: appTheme.grey800.withOpacity(0.4), blurRadius: 5, offset: Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Nick Name
            ShownDataBarWidget(item: "ニックネーム", data: widget.canData!.nickName),
            SizedBox(height: mediaH / 40),

            // height
            ShownDataBarWidget(item: " 身長 - cm", data: widget.canData!.height.toString() + " CM"),
            SizedBox(height: mediaH / 40),

            // weight
            ShownDataBarWidget(item: " 体重 - kg", data: widget.canData!.weight.toString() + " KG"),
            SizedBox(height: mediaH / 40),

            // address
            ShownDataBarWidget(item: "居住地", data: widget.canData!.city),
            SizedBox(height: mediaH / 40),

            // education
            ShownDataBarWidget(item: "学歴", data: widget.canData!.education),
            SizedBox(height: mediaH / 40),

            // hobby
            ShownDataBarWidget(item: "趣味 - タイプ", data: widget.canData!.hobbyType),
            SizedBox(height: mediaH / 40),

            // hobby
            ShownDataBarWidget(item: "経験 - 年:", data: widget.canData!.experience.toString()),
            SizedBox(height: mediaH / 40),

            // job
            ShownDataBarWidget(item: "職種", data: widget.canData!.job),
            SizedBox(height: mediaH / 40),

            // sexual
            ShownDataBarWidget(item: "性的指向", data: widget.canData!.sexual),
            SizedBox(height: mediaH / 40),

            // sociability
            ShownDataBarWidget(item: "社交力", data: widget.canData!.sociability),
            SizedBox(height: mediaH / 40),

            // find target
            ShownDataBarWidget(item: "探す対象", data: widget.canData!.accompanyType),
            SizedBox(height: mediaH / 40),

            // religious
            ShownDataBarWidget(item: "宗教", data: widget.canData!.religious),
            SizedBox(height: mediaH / 100),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "チャット",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
<<<<<<< HEAD
              builder: (context) => ChatBox(name: widget.canData!.nickName, imageUrl: widget.img!, targetid: widget.canData!.userID)),
=======
              builder: (context) => ChatBox(name: widget.canData!.nickName, imageUrl: widget.img![0], targetid: widget.canData!.userID)),
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a
        );
      },
    );
  }
}
