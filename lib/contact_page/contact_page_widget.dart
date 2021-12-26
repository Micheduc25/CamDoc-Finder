import 'package:cam_doc_finder/auth/firebase_user_provider.dart';
import 'package:cam_doc_finder/d_e_t_a_i_l_s_chat/d_e_t_a_i_l_s_chat_widget.dart';
import 'package:cam_doc_finder/flutter_flow/flutter_flow_icon_button.dart';
import 'package:cam_doc_finder/image_viewer/image_viewer_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      backgroundColor: FlutterFlowTheme.secondaryColor,
      // resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                              return Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  return Hero(
                                    tag: "viewlostdoc$index",
                                    child: Image.network(
                                      documentImages[index],
                                      width: MediaQuery.of(context).size.width,
                                      height: 250,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes
                                                : null,
                                          ),
                                        );
                                      },
                                      errorBuilder: (ctx, o, s) {
                                        return Image.asset(
                                          'assets/images/emptyState@2x.png',
                                          width: double.infinity,
                                        );
                                      },
                                    ),
                                  );
                                },
                                itemHeight: 250,
                                loop: true,
                                autoplay: true,
                                itemCount: documentImages.length,
                                pagination: new SwiperPagination(),
                                control: new SwiperControl(),
                                onTap: (index) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ImageViewWidget(
                                            imageUrl: documentImages[index],
                                            heroTag: 'viewlostdoc$index',
                                          )));
                                },
                              ).animated(
                                  [animationsMap['rowOnPageLoadAnimation']]);
                            },
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.95, -0.80),
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
                    SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 15, 0),
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
                        FlutterFlowIconButton(
                            icon: Icon(
                              FontAwesomeIcons.phoneAlt,
                              color: FlutterFlowTheme.secondaryColor,
                              size: 22,
                            ),
                            borderRadius: 5,
                            fillColor: FlutterFlowTheme.primaryColor,
                            buttonSize: 38,
                            onPressed: () {
                              launchURL("tel://${widget.author.phoneNumber}");
                            })
                      ],
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              Navigator.of(context).push(PageTransition(
                                  child: DETAILSChatWidget(
                                      chatUser: widget.author),
                                  alignment: Alignment.center,
                                  type: PageTransitionType.scale));
                            },
                            text: 'Send a Message',
                            options: FFButtonOptions(
                              width: 200,
                              height: 50,
                              color: FlutterFlowTheme.primaryColor,
                              textStyle: FlutterFlowTheme.subtitle2.override(
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
                          )),
                    ),

                    // Padding(
                    //   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    //   child: StreamBuilder<List<ChatsRecord>>(
                    //     stream: queryChatsRecord(
                    //       queryBuilder: (chatsRecord) => chatsRecord
                    //           .where('users', arrayContains: [
                    //         widget.author.reference,
                    //         currentUserReference
                    //       ]),
                    //       singleRecord: true,
                    //     ),
                    //     builder: (context, snapshot) {
                    //       if (!snapshot.hasData) {
                    //         return Center(
                    //           child: SizedBox(
                    //             width: 50,
                    //             height: 50,
                    //             child: CircularProgressIndicator(
                    //               color: FlutterFlowTheme.primaryColor,
                    //             ),
                    //           ),
                    //         );
                    //       }
                    //       List<ChatsRecord> columnChatsRecordList =
                    //           snapshot.data;
                    //       final columnChatsRecord =
                    //           columnChatsRecordList.isNotEmpty
                    //               ? columnChatsRecordList.first
                    //               : null;
                    //       return Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           Padding(
                    //             padding:
                    //                 EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    //             child: Row(
                    //               mainAxisSize: MainAxisSize.max,
                    //               children: [
                    //                 Text(
                    //                   'Send a message to ${widget.author.displayName}',
                    //                   style:
                    //                       FlutterFlowTheme.bodyText1.override(
                    //                     fontFamily: 'Montserrat',
                    //                     color: Color(0xFF0D1724),
                    //                     fontSize: 20,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding:
                    //                 EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    //             child: Row(
                    //               mainAxisSize: MainAxisSize.max,
                    //               children: [
                    //                 Expanded(
                    //                   child: TextFormField(
                    //                     controller: messageFieldController,
                    //                     obscureText: false,
                    //                     decoration: InputDecoration(
                    //                       hintText: 'Write Here....',
                    //                       hintStyle: FlutterFlowTheme.bodyText2
                    //                           .override(
                    //                         fontFamily: 'Lexend Deca',
                    //                         color: Color(0xFF8B97A2),
                    //                         fontSize: 14,
                    //                         fontWeight: FontWeight.normal,
                    //                       ),
                    //                       enabledBorder: OutlineInputBorder(
                    //                         borderSide: BorderSide(
                    //                           color:
                    //                               FlutterFlowTheme.primaryColor,
                    //                           width: 2,
                    //                         ),
                    //                         borderRadius:
                    //                             BorderRadius.circular(8),
                    //                       ),
                    //                       focusedBorder: OutlineInputBorder(
                    //                         borderSide: BorderSide(
                    //                           color:
                    //                               FlutterFlowTheme.primaryColor,
                    //                           width: 2,
                    //                         ),
                    //                         borderRadius:
                    //                             BorderRadius.circular(8),
                    //                       ),
                    //                       contentPadding:
                    //                           EdgeInsetsDirectional.fromSTEB(
                    //                               20, 32, 20, 12),
                    //                     ),
                    //                     style:
                    //                         FlutterFlowTheme.bodyText1.override(
                    //                       fontFamily: 'Lexend Deca',
                    //                       color: Color(0xFF090F13),
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.normal,
                    //                     ),
                    //                     textAlign: TextAlign.start,
                    //                     maxLines: 4,
                    //                     keyboardType: TextInputType.multiline,
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //           Align(
                    //             alignment: AlignmentDirectional(0, 0),
                    //             child: Padding(
                    //               padding: EdgeInsetsDirectional.fromSTEB(
                    //                   0, 16, 0, 0),
                    //               child: FFButtonWidget(
                    //                 onPressed: () async {
                    //                   if ((messageFieldController.text) !=
                    //                       ('')) {
                    //                     setState(() => _loadingButton = true);
                    //                     try {
                    //                       if (columnChatsRecord == null) {
                    //                         final chatsCreateData = {
                    //                           ...createChatsRecordData(
                    //                               userA: currentUserReference,
                    //                               userB:
                    //                                   widget.author.reference,
                    //                               lastMessage:
                    //                                   messageFieldController
                    //                                       .text),
                    //                         };
                    //                         final chatsRecordReference =
                    //                             ChatsRecord.collection.doc();
                    //                         await chatsRecordReference
                    //                             .set(chatsCreateData);
                    //                         newChat =
                    //                             ChatsRecord.getDocumentFromData(
                    //                                 chatsCreateData,
                    //                                 chatsRecordReference);
                    //                       }

                    //                       final chatMessagesCreateData =
                    //                           createChatMessagesRecordData(
                    //                         user: currentUserReference,
                    //                         chat: functions.getChatRecord(
                    //                             newChat, columnChatsRecord),
                    //                         text: messageFieldController.text,
                    //                         timestamp: DateTime.now(),
                    //                       );
                    //                       final chatMessagesRecordReference =
                    //                           ChatMessagesRecord.collection
                    //                               .doc();
                    //                       await chatMessagesRecordReference
                    //                           .set(chatMessagesCreateData);
                    //                       newMessage = ChatMessagesRecord
                    //                           .getDocumentFromData(
                    //                               chatMessagesCreateData,
                    //                               chatMessagesRecordReference);

                    //                       ScaffoldMessenger.of(context)
                    //                           .showSnackBar(
                    //                         SnackBar(
                    //                           content: Text(
                    //                             'Message successfully sent',
                    //                             style: GoogleFonts.getFont(
                    //                               'Roboto',
                    //                               color: Colors.white,
                    //                               fontSize: 16,
                    //                             ),
                    //                           ),
                    //                           duration:
                    //                               Duration(milliseconds: 4000),
                    //                           backgroundColor:
                    //                               FlutterFlowTheme.primaryColor,
                    //                         ),
                    //                       );

                    //                       setState(() {
                    //                         messageFieldController.clear();
                    //                       });
                    //                     } finally {
                    //                       setState(
                    //                           () => _loadingButton = false);
                    //                     }
                    //                   }
                    //                 },
                    //                 text: 'Send',
                    //                 options: FFButtonOptions(
                    //                   width: 120,
                    //                   height: 50,
                    //                   color: FlutterFlowTheme.primaryColor,
                    //                   textStyle:
                    //                       FlutterFlowTheme.subtitle2.override(
                    //                     fontFamily: 'Montserrat',
                    //                     color: Colors.white,
                    //                     fontSize: 18,
                    //                     fontWeight: FontWeight.w500,
                    //                   ),
                    //                   elevation: 2,
                    //                   borderSide: BorderSide(
                    //                     color: Colors.transparent,
                    //                     width: 2,
                    //                   ),
                    //                   borderRadius: 8,
                    //                 ),
                    //                 loading: _loadingButton,
                    //               ),
                    //             ),
                    //           )
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
