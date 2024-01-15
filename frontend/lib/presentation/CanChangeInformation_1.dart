import 'package:dating_your_date/models/GlobalModel.dart';
import 'package:dating_your_date/pb/rpc_canChange.pb.dart';
import 'package:dating_your_date/presentation/CanChangeInformation_2.dart';
import 'package:dating_your_date/theme/theme_helper.dart';
import 'package:dating_your_date/widgets/app_bar/Custom_App_bar.dart';
import 'package:dating_your_date/widgets/Custom_WarningLogoBox.dart';
import 'package:dating_your_date/widgets/app_bar/custom_Input_Bar.dart';
import 'package:dating_your_date/widgets/Custom_Input_Form_Bar.dart';
import 'package:dating_your_date/widgets/Custom_Loading.dart';
import 'package:dating_your_date/widgets/button/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

class CanChangeInformation1 extends StatefulWidget {
  CanChangeInformation1({Key? key}) : super(key: key);
  @override
  _CanChangeInformation1State createState() => _CanChangeInformation1State();
}

class _CanChangeInformation1State extends State<CanChangeInformation1> {
  bool isPureNumber(String value) {
    final pattern = RegExp(r'^\d+$');
    return pattern.hasMatch(value);
  }

  TextEditingController canChangeNickNameController = TextEditingController();
  TextEditingController canChangeCityController = TextEditingController();
  TextEditingController canChangeSexualController = TextEditingController();
  TextEditingController canChangeHeightController = TextEditingController();
  TextEditingController canChangeWeightController = TextEditingController();
  TextEditingController canChangeSpeakLanguageController = TextEditingController();
  TextEditingController canChangeEducationController = TextEditingController();

  // Grpc
  void canChangeGrpcRequest(BuildContext context) async {
    if (canChangeNickNameController.text.isEmpty) {
      showErrorDialog(context, "ニックネームはまだ入力されていません");
    } else if (canChangeCityController.text.isEmpty) {
      showErrorDialog(context, "居住地はまだ入力されていません");
    } else if (canChangeSexualController.text.isEmpty) {
      showErrorDialog(context, "性的指向はまだ入力されていません");
    } else if (canChangeHeightController.text.isEmpty) {
      showErrorDialog(context, "身長はまだ入力されていません");
    } else if (!isPureNumber(canChangeHeightController.text)) {
      showErrorDialog(context, "入力した身長は数字じゃありません");
    } else if (canChangeWeightController.text.isEmpty) {
      showErrorDialog(context, "体重はまだ入力されていません");
    } else if (!isPureNumber(canChangeWeightController.text)) {
      showErrorDialog(context, "入力した体重は数字じゃありません");
    } else if (canChangeSpeakLanguageController.text.isEmpty) {
      showErrorDialog(context, "学歴はまだ入力されていません");
    } else {
      setState(() {
        showLoadDialog(context);
      });
      await Future.delayed(Duration(seconds: 1));
      try {
        String? apiKeyS = await globalSession.read(key: 'SessionId');
        final request = CreateCanChangeRequest(
          sessionID: apiKeyS,
          nickName: canChangeNickNameController.text,
          city: canChangeCityController.text,
          sexual: canChangeSexualController.text,
          height: int.parse(canChangeHeightController.text),
          weight: int.parse(canChangeWeightController.text),
          speaklanguage: canChangeSpeakLanguageController.text,
          education: canChangeEducationController.text,
        );

        onTapNextPage(context, request);
      } on GrpcError {
        Navigator.pop(context);
        showErrorDialog(context, "Error: validatable input data");
        throw Exception("Error occurred while fetching CanChange1.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double mediaH = mediaQueryData.size.height;
    double mediaW = mediaQueryData.size.width;
    return Scaffold(
      appBar: buildAppBar(context, "基本個人情報 - B", true),
      backgroundColor: appTheme.bgColor,
      // 鍵盤彈出後自動調節Size - 要test先知
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaW / 13, vertical: mediaH / 20),
        child: Column(
          children: [
            // Nick Name
            CustomInputBar(titleName: "ニックネーム:", backendPart: _buildcanChangeNickNameInput(context)),
            SizedBox(height: mediaH / 50),

            // City
            CustomInputBar(titleName: "居住地:", backendPart: _buildcanChangeCityInput(context)),
            SizedBox(height: mediaH / 50),

            // Sexual
            CustomInputBar(titleName: "性的指向:", backendPart: _buildcanChangeSexualInput(context)),
            SizedBox(height: mediaH / 50),

            // Height
            CustomInputBar(titleName: "身長:", backendPart: _buildcanChangeHeightInput(context)),
            SizedBox(height: mediaH / 50),

            // Width
            CustomInputBar(titleName: "体重:", backendPart: _buildcanChangeWeightInput(context)),
            SizedBox(height: mediaH / 50),

            // Speak Language
            CustomInputBar(titleName: "言語:", backendPart: _buildcanChangeSpeakLanguageInput(context)),
            SizedBox(height: mediaH / 50),

            // Job
            CustomInputBar(titleName: "学歴:", backendPart: _buildcanChangeEducationInput(context)),
            SizedBox(height: mediaH / 25),

            // Button
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  /// Nickname
  Widget _buildcanChangeNickNameInput(BuildContext context) {
    return CustomInputFormBar(
      controller: canChangeNickNameController,
      hintText: "仆街",
      focusNode: FocusNode(),
      onTap: () {
        FocusNode().requestFocus();
      },
    );
  }

  /// City
  Widget _buildcanChangeCityInput(BuildContext context) {
    return CustomInputFormBar(controller: canChangeCityController, hintText: "大阪");
  }

  /// Sexual
  Widget _buildcanChangeSexualInput(BuildContext context) {
    return CustomInputFormBar(controller: canChangeSexualController, hintText: "異性愛");
  }

  /// Height
  Widget _buildcanChangeHeightInput(BuildContext context) {
    return CustomInputFormBar(controller: canChangeHeightController, hintText: "170cm");
  }

  /// Width
  Widget _buildcanChangeWeightInput(BuildContext context) {
    return CustomInputFormBar(controller: canChangeWeightController, hintText: "60kg");
  }

  /// Education
  Widget _buildcanChangeEducationInput(BuildContext context) {
    return CustomInputFormBar(controller: canChangeEducationController, hintText: "高校生");
  }

  /// Speak Language
  Widget _buildcanChangeSpeakLanguageInput(BuildContext context) {
    return CustomInputFormBar(controller: canChangeSpeakLanguageController, hintText: "EN,HK,CN,JP");
  }

  /// Next Button
  Widget _buildNextButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "次へ",
      onPressed: () {
        canChangeGrpcRequest(context);
      },
    );
  }

  onTapNextPage(BuildContext context, CreateCanChangeRequest request) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CanChangeInformation2(can1: request)));
  }
}