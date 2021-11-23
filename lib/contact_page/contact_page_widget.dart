import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPageWidget extends StatefulWidget {
  ContactPageWidget({
    Key key,
    this.lost,
    this.author,
  }) : super(key: key);

  final LostDocumentsRecord lost;
  final UsersRecord author;

  @override
  _ContactPageWidgetState createState() => _ContactPageWidgetState();
}

class _ContactPageWidgetState extends State<ContactPageWidget>
    with TickerProviderStateMixin {
  ChatsRecord newChat;
  ChatMessagesRecord newMessage;
  bool _loadingButton = false;
  TextEditingController messageFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = {
    'rowOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
    ),
  };

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );

    messageFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 240,
                  child: Stack(
                    alignment: AlignmentDirectional(-0.95, -0.7),
                    children: [
                      Builder(
                        builder: (context) {
                          final documentImages =
                              (widget.lost.images?.toList() ?? [])
                                  .take(3)
                                  .toList();
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(documentImages.length,
                                  (documentImagesIndex) {
                                final documentImagesItem =
                                    documentImages[documentImagesIndex];
                                return Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 5, 0),
                                    child: CachedNetworkImage(
                                      imageUrl: documentImagesItem,
                                      width: MediaQuery.of(context).size.width,
                                      height: 240,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ).animated([animationsMap['rowOnPageLoadAnimation']]);
                        },
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.95, -0.55),
                        child: InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFF5F5F5),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: Color(0xFF4B39EF),
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.lost.title,
                  style: FlutterFlowTheme.title1.override(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Text(
                    widget.lost.description,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lato',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    'posted by ${widget.author.displayName}  at ${dateTimeFormat('d/M h:m a', widget.lost.dateAdded)}',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lato',
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 7, 0),
                      child: Text(
                        'Phone number: ${widget.author.phoneNumber}',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Lato',
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.phone,
                      color: FlutterFlowTheme.primaryColor,
                      size: 24,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: StreamBuilder<List<ChatsRecord>>(
                    stream: queryChatsRecord(
                      queryBuilder: (chatsRecord) => chatsRecord.where('users',
                          arrayContains: widget.author.reference),
                      singleRecord: true,
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
                      List<ChatsRecord> columnChatsRecordList = snapshot.data;
                      final columnChatsRecord = columnChatsRecordList.isNotEmpty
                          ? columnChatsRecordList.first
                          : null;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Send a message to ${widget.author.displayName}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF0D1724),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: messageFieldController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Write Here....',
                                      hintStyle:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.primaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.primaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20, 32, 20, 12),
                                    ),
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF090F13),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 4,
                                    keyboardType: TextInputType.multiline,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  setState(() => _loadingButton = true);
                                  try {
                                    if (!(columnChatsRecord != null)) {
                                      final chatsCreateData = {
                                        ...createChatsRecordData(
                                          userA: currentUserReference,
                                          userB: widget.author.reference,
                                          email: '',
                                          displayName: '',
                                        ),
                                        'users': FieldValue.arrayUnion([
                                          currentUserReference,
                                          widget.author.reference
                                        ]),
                                      };
                                      final chatsRecordReference =
                                          ChatsRecord.collection.doc();
                                      await chatsRecordReference
                                          .set(chatsCreateData);
                                      newChat = ChatsRecord.getDocumentFromData(
                                          chatsCreateData,
                                          chatsRecordReference);
                                    }
                                    if ((messageFieldController.text) != ('')) {
                                      final chatMessagesCreateData =
                                          createChatMessagesRecordData(
                                        user: currentUserReference,
                                        chat: functions.getChatRecord(
                                            newChat, columnChatsRecord),
                                        text: messageFieldController.text,
                                      );
                                      final chatMessagesRecordReference =
                                          ChatMessagesRecord.collection.doc();
                                      await chatMessagesRecordReference
                                          .set(chatMessagesCreateData);
                                      newMessage = ChatMessagesRecord
                                          .getDocumentFromData(
                                              chatMessagesCreateData,
                                              chatMessagesRecordReference);
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Message successfully sent',
                                          style: GoogleFonts.getFont(
                                            'Roboto',
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.primaryColor,
                                      ),
                                    );

                                    setState(() {});
                                  } finally {
                                    setState(() => _loadingButton = false);
                                  }
                                },
                                text: 'Send',
                                options: FFButtonOptions(
                                  width: 120,
                                  height: 50,
                                  color: FlutterFlowTheme.primaryColor,
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: 8,
                                ),
                                loading: _loadingButton,
                              ),
                            ),
                          )
                        ],
                      );
                    },
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
