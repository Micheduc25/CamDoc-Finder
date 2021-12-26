// import 'package:camer_connect/gen_l10n/app_localizations.dart';

import 'package:cam_doc_finder/backend/search/search.dart';
import 'package:cam_doc_finder/flutter_flow/flutter_flow_icon_button.dart';
import 'package:easy_debounce/easy_debounce.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../d_e_t_a_i_l_s_chat/d_e_t_a_i_l_s_chat_widget.dart';
import '../flutter_flow/chat/index.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MAINChatWidget extends StatefulWidget {
  const MAINChatWidget({Key key}) : super(key: key);

  @override
  _MAINChatWidgetState createState() => _MAINChatWidgetState();
}

class _MAINChatWidgetState extends State<MAINChatWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController textController;
  List<ChatsRecord> searchResults;
  List<ChatsRecord> loadedChats = [];
  String searchString = "";
  bool _isLoading = false;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final loc = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.tertiaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Messages',
            style: FlutterFlowTheme.title3.override(
              fontFamily: 'Lexend Deca',
              color: FlutterFlowTheme.secondaryColor,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 1,
        ),
        backgroundColor: FlutterFlowTheme.secondaryColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 8, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 4, 0),
                                        child: Icon(
                                          Icons.search_rounded,
                                          color: Color(0xFF95A1AC),
                                          size: 24,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 10,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 0, 0, 0),
                                          child: TextFormField(
                                              controller: textController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Search recent chats here...',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Color(0xFF82878C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x004B39EF),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(4.0),
                                                    topRight:
                                                        Radius.circular(4.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x004B39EF),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(4.0),
                                                    topRight:
                                                        Radius.circular(4.0),
                                                  ),
                                                ),
                                              ),
                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Color(0xFF151B1E),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              textAlign: TextAlign.start,
                                              onChanged: (value) async {
                                                if (loadedChats.isNotEmpty)
                                                  EasyDebounce.debounce(
                                                      'search-chat',
                                                      Duration(
                                                          milliseconds: 400),
                                                      () async {
                                                    setState(() {
                                                      _isLoading = true;
                                                    });
                                                    final res = await SearchItems
                                                        .chatsSearch(
                                                            query: searchString,
                                                            collection:
                                                                loadedChats);

                                                    setState(() {
                                                      searchResults = res;
                                                      _isLoading = false;
                                                    });
                                                  });
                                              }),
                                        ),
                                      ),
                                    ],
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
                Expanded(
                  child: StreamBuilder<List<ChatsRecord>>(
                    stream: queryChatsRecord(
                      queryBuilder: (chatsRecord) => chatsRecord
                          .where('users', arrayContains: currentUserReference)
                          .orderBy('last_message_time', descending: true),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData || _isLoading) {
                        return Center(
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: SpinKitThreeBounce(
                              color: FlutterFlowTheme.primaryColor,
                              size: 50,
                            ),
                          ),
                        );
                      }

                      loadedChats = snapshot.data;
                      if (searchResults == null) searchResults = loadedChats;

                      if (loadedChats.isEmpty || searchResults.isEmpty) {
                        return Center(
                          child: Image.asset(
                            'assets/images/empty_NoMessges@2x.png',
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: searchResults.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewChatsRecord =
                              searchResults[listViewIndex];
                          return StreamBuilder<ChatsRecord>(
                            stream: ChatsRecord.getDocument(
                                listViewChatsRecord.reference),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: SpinKitThreeBounce(
                                      color: FlutterFlowTheme.primaryColor,
                                      size: 50,
                                    ),
                                  ),
                                );
                              }
                              final chatPreviewChatsRecord = snapshot.data;
                              return FutureBuilder<UsersRecord>(
                                future: () async {
                                  final chatUserRef = FFChatManager.instance
                                      .getChatUserRef(currentUserReference,
                                          chatPreviewChatsRecord);
                                  return UsersRecord.getDocument(chatUserRef)
                                      .first;
                                }(),
                                builder: (context, snapshot) {
                                  final chatUser = snapshot.data;
                                  return FFChatPreview(
                                    onTap: chatUser != null
                                        ? () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DETAILSChatWidget(
                                                  chatUser: chatUser,
                                                ),
                                              ),
                                            )
                                        : null,
                                    lastChatText:
                                        chatPreviewChatsRecord.lastMessage,
                                    lastChatTime:
                                        chatPreviewChatsRecord.lastMessageTime,
                                    seen: chatPreviewChatsRecord
                                        .lastMessageSeenBy
                                        .contains(currentUserReference),
                                    userName:
                                        chatUser?.displayName ?? "Anonymous",
                                    userProfilePic: chatUser?.photoUrl ?? '',
                                    color: FlutterFlowTheme.secondaryColor,
                                    unreadColor: FlutterFlowTheme.tertiaryColor,
                                    titleTextStyle: GoogleFonts.getFont(
                                      'Lexend Deca',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    dateTextStyle: GoogleFonts.getFont(
                                      'Lexend Deca',
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                    previewTextStyle: GoogleFonts.getFont(
                                      'Lexend Deca',
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            12, 3, 12, 3),
                                    borderRadius: BorderRadius.circular(0),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
