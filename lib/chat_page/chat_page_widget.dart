import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../components/chat_bubble_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPageWidget extends StatefulWidget {
  ChatPageWidget({
    Key key,
    this.chat,
  }) : super(key: key);

  final ChatsRecord chat;

  @override
  _ChatPageWidgetState createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget> {
  ChatMessagesRecord newMessage;
  TextEditingController messageFieldController;
  String uploadedFileUrl = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    messageFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text(
          widget.chat.displayName,
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Lato',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: StreamBuilder<List<ChatMessagesRecord>>(
                stream: queryChatMessagesRecord(
                  queryBuilder: (chatMessagesRecord) => chatMessagesRecord
                      .where('user', isEqualTo: widget.chat.userA)
                      .where('user', isEqualTo: widget.chat.userB)
                      .orderBy('timestamp', descending: true),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: FlutterFlowTheme.primaryColor,
                        ),
                      ),
                    );
                  }
                  List<ChatMessagesRecord> listViewChatMessagesRecordList =
                      snapshot.data;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewChatMessagesRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewChatMessagesRecord =
                          listViewChatMessagesRecordList[listViewIndex];
                      return StreamBuilder<UsersRecord>(
                        stream: UsersRecord.getDocument(
                            listViewChatMessagesRecord.user),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  color: FlutterFlowTheme.primaryColor,
                                ),
                              ),
                            );
                          }
                          final chatBubbleUsersRecord = snapshot.data;
                          return ChatBubbleWidget(
                            sender: chatBubbleUsersRecord,
                            message: listViewChatMessagesRecord,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Material(
              color: Colors.transparent,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: TextFormField(
                            controller: messageFieldController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Type here...',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Lato',
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lato',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if ((messageFieldController.text) != ('')) {
                            final chatMessagesCreateData =
                                createChatMessagesRecordData(
                              user: currentUserReference,
                              chat: widget.chat.reference,
                              text: messageFieldController.text,
                              image: uploadedFileUrl,
                            );
                            final chatMessagesRecordReference =
                                ChatMessagesRecord.collection.doc();
                            await chatMessagesRecordReference
                                .set(chatMessagesCreateData);
                            newMessage = ChatMessagesRecord.getDocumentFromData(
                                chatMessagesCreateData,
                                chatMessagesRecordReference);
                          }

                          setState(() {});
                        },
                        child: Icon(
                          Icons.send,
                          color: FlutterFlowTheme.primaryColor,
                          size: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final selectedMedia =
                              await selectMediaWithSourceBottomSheet(
                            context: context,
                            allowPhoto: true,
                          );
                          if (selectedMedia != null &&
                              validateFileFormat(
                                  selectedMedia.storagePath, context)) {
                            showUploadMessage(context, 'Uploading file...',
                                showLoading: true);
                            final downloadUrl = await uploadData(
                                selectedMedia.storagePath, selectedMedia.bytes);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            if (downloadUrl != null) {
                              setState(() => uploadedFileUrl = downloadUrl);
                              showUploadMessage(context, 'Success!');
                            } else {
                              showUploadMessage(
                                  context, 'Failed to upload media');
                              return;
                            }
                          }
                        },
                        child: Icon(
                          Icons.photo_camera,
                          color: FlutterFlowTheme.primaryColor,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
