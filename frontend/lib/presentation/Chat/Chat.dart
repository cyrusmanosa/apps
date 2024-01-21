import 'package:dating_your_date/client/grpc_services.dart';
import 'package:dating_your_date/core/app_export.dart';
import 'package:dating_your_date/models/ChatModel.dart';
import 'package:dating_your_date/models/GlobalModel.dart';
import 'package:dating_your_date/pb/rpc_canChange.pb.dart';
import 'package:dating_your_date/pb/rpc_chatRecord.pb.dart';
import 'package:dating_your_date/pb/rpc_images.pb.dart';
import 'package:dating_your_date/presentation/Chat/widgets/conversationList.dart';
import 'package:dating_your_date/widgets/app_bar/Custom_App_bar.dart';
import 'package:dating_your_date/widgets/Custom_WarningLogoBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grpc/grpc.dart';

class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool isEmpty = false;
  List<int> targetID = [];
  List<TargetInfos> users = [];

  @override
  void initState() {
    super.initState();
    fetchData(context);
  }

  Future<void> fetchData(BuildContext context) async {
    await _getTargetID(context);
    _getUserInfoGrpcRequest(context);
  }

// Grpc
  Future<void> _getTargetID(BuildContext context) async {
    try {
      String? apiKeyU = await globalUserId.read(key: 'UserID');
      final userid = int.tryParse(apiKeyU!);
      final targetIDRequest = GetTargetIDRequest(userID: userid);
      final tid = await GrpcChatService.client.getTargetID(targetIDRequest);
      setState(() {
        targetID = tid.targetID;
        if (targetID == []) {
          isEmpty = true;
        }
      });
    } on GrpcError {
      await showErrorDialog(context, "エラー：検証可能な入力データ");
      throw Exception("データの送信中にエラーが発生しました。");
    }
  }

  Future<void> _getUserInfoGrpcRequest(BuildContext context) async {
    try {
      String? apiKeyS = await globalSession.read(key: 'SessionId');
      String? apiKeyU = await globalUserId.read(key: 'UserID');
      final userid = int.tryParse(apiKeyU!);
      for (int i = 0; i < targetID.length; i++) {
        // take info
        final infoRequest = GetCanChangeRequest(sessionID: apiKeyS, userID: targetID[i]);
        final infoResponse = await GrpcInfoService.client.getCanChange(infoRequest);
        // take icon
        final imgRequest = GetImagesRequest(sessionID: apiKeyS, userID: targetID[i]);
        final imgResponse = await GrpcInfoService.client.getImages(imgRequest);
        // take last msg
        final lmsgRequest = GetLastMsgRequest(userID: userid!, targetID: targetID[i]);
        final lmsgResponse = await GrpcChatService.client.getLastMsg(lmsgRequest);
        Uint8List bytes = Uint8List.fromList(imgResponse.img.img1);
<<<<<<< HEAD:frontend/lib/presentation/Chat/Chat.dart
        setState(() {
          users.add(TargetInfos(
              userid: targetID[i], img: bytes, info: infoResponse.canChangeInfo, lastMsg: lmsgResponse.media, isRead: lmsgResponse.isRead));
=======
        Directory tempDir = await getTemporaryDirectory();
        File file = File('${tempDir.path}/data_$i.bin');
        await file.writeAsBytes(bytes);
<<<<<<< HEAD:Flutter/lib/presentation/Chat/Chat.dart

        setState(() {
          users.add(TargetInfos(
            userid: targetID[i],
            img: file,
            info: infoResponse.canChangeInfo,
            lastMsg: lmsgResponse.media,
            isRead: lmsgResponse.isread,
          ));
=======
        setState(() {
          users.add(TargetInfos(
              userid: targetID[i], img: file, info: infoResponse.canChangeInfo, lastMsg: lmsgResponse.media, isRead: lmsgResponse.isRead));
>>>>>>> parent of f9b9b1f (delete bug):frontend/lib/presentation/Chat/Chat.dart
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a:Flutter/lib/presentation/Chat/Chat.dart
        });
      }
      isEmpty = false;
    } on GrpcError {
      isEmpty = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double mediaH = mediaQueryData.size.height;
    return Scaffold(
      appBar: buildAppBar(context, "チャット", false),
      backgroundColor: appTheme.bgColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isEmpty == true)
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: mediaH / 4),
                  child: Text("相手とまだおしゃべりしておりません", style: CustomTextStyles.smallTitle20),
                ),
              ),
            ListView.separated(
              itemCount: users.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: mediaH / 50),
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: mediaH / 50),
              itemBuilder: (context, index) {
                return ConversationList(
                  targetid: users[index].userid,
                  name: users[index].info.nickName,
                  messageText: users[index].lastMsg,
                  imageUrl: users[index].img,
                  isMessageRead: users[index].isRead,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
