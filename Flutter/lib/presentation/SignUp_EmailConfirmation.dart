import 'package:dating_your_date/core/app_export.dart';
import 'package:dating_your_date/client/grpc_services.dart';
import 'package:dating_your_date/pb/rpc_checkEmail.pb.dart';
import 'package:dating_your_date/widgets/app_bar/custom_Input_bar.dart';
import 'package:dating_your_date/widgets/Custom_Outlined_Button.dart';
import 'package:dating_your_date/widgets/Custom_Input_Form_Bar.dart';
import 'package:dating_your_date/widgets/Custom_WarningLogoBox.dart';
import 'package:dating_your_date/widgets/loading.dart';
import 'package:flutter/material.dart';

class EmailConfirmation extends StatefulWidget {
  EmailConfirmation({Key? key}) : super(key: key);
  @override
  _EmailConfirmationtate createState() => _EmailConfirmationtate();
}

class _EmailConfirmationtate extends State<EmailConfirmation> {
  TextEditingController emailController = TextEditingController();

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  void emailConfirmationGrpcRequest(BuildContext context) async {
    if (!isEmailValid(emailController.text)) {
      showErrorDialog(context, "無効なメールアドレス", false);
    } else {
      try {
        setState(() {
          showLoadDialog(context);
        });
        final request = CheckEmailRequest(email: emailController.text);
        await GrpcInfoService.client.checkEmail(request);
        onTapNextPage(context);
      } catch (error) {
        Navigator.pop(context);
        showErrorDialog(context, "Error: validatable input data", false);
        throw Exception("Error occurred while fetching email Confirmation.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double mediaH = mediaQueryData.size.height;
    double mediaW = mediaQueryData.size.width;
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaW / 13),
        child: Column(
          children: [
            // Logo and Slogan
            CustomImageView(imagePath: ImageConstant.imgLogo, width: mediaW / 4.5),
            CustomImageView(imagePath: ImageConstant.imgSlogan, width: mediaW / 3.5),
            SizedBox(height: mediaH / 30),

            // input
            CustomInputBar(titleName: "メールアドレス", backendPart: _buildEmailInputSection(context)),
            SizedBox(height: mediaH / 50),

            // send button
            _buildNextButton(context),
            SizedBox(height: mediaH / 30),

            // 手続き
            Align(
              alignment: Alignment.topLeft,
              child: Container(child: Text("・ご手続きは1回のみです", overflow: TextOverflow.ellipsis, style: CustomTextStyles.titleOfUnderLogo)),
            ),

            // information note
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Text("・メールアドレスの受信確認は必須です。", overflow: TextOverflow.ellipsis, style: CustomTextStyles.titleOfUnderLogo),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Text("・ご登録済みのお客様は受信確認をお願いします。", overflow: TextOverflow.ellipsis, style: CustomTextStyles.titleOfUnderLogo),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailInputSection(BuildContext context) {
    return CustomInputFormBar(
      controller: emailController,
      hintText: "example@email.com",
      textInputType: TextInputType.emailAddress,
      focusNode: FocusNode(),
      onTap: () {
        FocusNode().requestFocus();
      },
    );
  }

  // Next Button
  Widget _buildNextButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "送信",
      onPressed: () {
        emailConfirmationGrpcRequest(context);
      },
    );
  }

  onTapNextPage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.confirmationCore);
  }
}
