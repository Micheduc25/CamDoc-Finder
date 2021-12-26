import 'package:cam_doc_finder/image_viewer/image_viewer_widget.dart';

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
  ChatPageWidget({Key key, this.chat, this.otherUser}) : super(key: key);

  final ChatsRecord chat;
  final UsersRecord otherUser;

  @override
  _ChatPageWidgetState createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget> {
  ChatMessagesRecord newMessage;
  TextEditingController messageFieldController;
  String uploadedFileUrl;
  ScrollController scrollController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool currentMessageSent = false;
  bool messageSending = false;

  @override
  void initState() {
    super.initState();
    messageFieldController = TextEditingController();
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text(
          widget.otherUser.displayName,
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
                      .where('chat', isEqualTo: widget.chat.reference)
                      .orderBy('timestamp', descending: false),
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
                    controller: scrollController,
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
                            return Container(height: 40);
                          }
                          final chatBubbleUsersRecord = snapshot.data;
                          return Align(
                            alignment: listViewChatMessagesRecord.user ==
                                    currentUserReference
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: ChatBubbleWidget(
                              sender: chatBubbleUsersRecord,
                              message: listViewChatMessagesRecord,
                              messageSent: true,
                            ),
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
                      !messageSending
                          ? InkWell(
                              onTap: () async {
                                await _sendMessage(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Icon(
                                  Icons.send,
                                  color: FlutterFlowTheme.primaryColor,
                                  size: 30,
                                ),
                              ))
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Center(
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                      InkWell(
                        onTap: () async {
                          if (!messageSending) {
                            final selectedMedia =
                                await selectMediaWithSourceBottomSheet(
                              context: context,
                              allowPhoto: true,
                            );
                            if (selectedMedia != null &&
                                validateFileFormat(
                                    selectedMedia.storagePath, context)) {
                              setState(() {
                                messageSending = true;
                              });
                              showUploadMessage(context, 'Uploading file...',
                                  showLoading: true);
                              final downloadUrl = await uploadData(
                                  selectedMedia.storagePath,
                                  selectedMedia.bytes);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              if (downloadUrl != null) {
                                setState(() => uploadedFileUrl = downloadUrl);
                                showUploadMessage(context, 'Success!');
                              } else {
                                showUploadMessage(
                                    context, 'Failed to upload media');
                                return;
                              }

                              final Map<String, dynamic> message =
                                  await Navigator.of(context)
                                      .push(PageTransition(
                                          type: PageTransitionType.fade,
                                          child: ImageViewWidget(
                                            heroTag: "chatimg",
                                            imageUrl: uploadedFileUrl,
                                            showTextInput: true,
                                            textController:
                                                messageFieldController,
                                          )));

                              if (message != null) await _sendMessage(context);
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

  Future<void> _sendMessage(BuildContext context) async {
    if ((messageFieldController.text) != ('') && messageSending == false) {
      setState(() {
        messageSending = true;
      });
      final now = DateTime.now();
      final message = messageFieldController.text;
      final chatMessagesCreateData = createChatMessagesRecordData(
          user: currentUserReference,
          chat: widget.chat.reference,
          text: message,
          image: uploadedFileUrl,
          timestamp: now);

      final chatMessagesRecordReference = ChatMessagesRecord.collection.doc();

      try {
        await chatMessagesRecordReference.set(chatMessagesCreateData);
        newMessage = ChatMessagesRecord.getDocumentFromData(
            chatMessagesCreateData, chatMessagesRecordReference);
        messageFieldController.clear();

        final chatRef = ChatsRecord.collection.doc(widget.chat.reference.id);

        await chatRef.update({
          "last_message": newMessage.text,
          "last_message_time": newMessage.timestamp
        });
      } catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("An error occured while sending the message")));
      } finally {
        setState(() {
          messageSending = false;
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        });
      }
    }
  }
}
