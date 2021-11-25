import 'package:flutter_search_bar/flutter_search_bar.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/post_item_widget.dart';
import '../creat_post_page/creat_post_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../login_page/login_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DocumentsPageWidget extends StatefulWidget {
  DocumentsPageWidget({Key key}) : super(key: key);

  @override
  _DocumentsPageWidgetState createState() => _DocumentsPageWidgetState();
}

class _DocumentsPageWidgetState extends State<DocumentsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  SearchBar searchBar;
  List<LostDocumentsRecord> filteredLostDocs;
  List<LostDocumentsRecord> documentsPageLostDocumentsRecordList;
  bool isSearching = false;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        backgroundColor: FlutterFlowTheme.tertiaryColor,
        title: Text(
          'CamDoc Finder',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Condiment',
            color: FlutterFlowTheme.secondaryColor,
            fontSize: 27,
            fontWeight: FontWeight.w900,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 300),
                    child: CreatPostPageWidget(),
                  ),
                );
              },
              child: Icon(
                Icons.add_box_outlined,
                color: FlutterFlowTheme.secondaryColor,
                size: 30,
              ),
            ),
          ),
          searchBar.getSearchAction(context),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 20, 0),
            child: InkWell(
              onTap: () {
                //switch to dark mode here
                ThemeData.dark();
              },
              child: Icon(
                Icons.settings_outlined,
                color: FlutterFlowTheme.secondaryColor,
                size: 30,
              ),
            ),
          ),
        ]);
  }

  void searchDocs(String value) {
    if (isSearching == false) isSearching = true;
    // print(isSearching);

    if (documentsPageLostDocumentsRecordList != null)
      setState(() {
        if (value.isNotEmpty)
          filteredLostDocs = filteredLostDocs.where((doc) {
            return (doc.title.toLowerCase().contains(value.toLowerCase())) ||
                (doc.description.toLowerCase().contains(value.toLowerCase()));
          }).toList();
        else
          filteredLostDocs = documentsPageLostDocumentsRecordList;
      });
  }

  _DocumentsPageWidgetState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        // onSubmitted: searchDocs,
        onChanged: searchDocs,
        onCleared: () {
          if (documentsPageLostDocumentsRecordList != null)
            setState(() {
              filteredLostDocs = documentsPageLostDocumentsRecordList;
            });
        },
        onClosed: () {
          setState(() {
            isSearching = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: StreamBuilder<List<LostDocumentsRecord>>(
        stream: queryLostDocumentsRecord(
          queryBuilder: (lostDocumentsRecord) =>
              lostDocumentsRecord.orderBy('date_added', descending: true),
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
          documentsPageLostDocumentsRecordList = snapshot.data;
          if (filteredLostDocs == null) filteredLostDocs = snapshot.data;
          print(documentsPageLostDocumentsRecordList.length);
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.secondaryColor,
            appBar: searchBar.build(context),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(1, 0, 1, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Padding(
                    //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: 60,
                    //     decoration: BoxDecoration(
                    //       color: FlutterFlowTheme.tertiaryColor,
                    //     ),
                    //     child:
                    //     Row(
                    //       mainAxisSize: MainAxisSize.max,
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Padding(
                    //           padding:
                    //               EdgeInsetsDirectional.fromSTEB(4, 4, 0, 0),
                    //           child: InkWell(
                    //             onTap: () async {
                    //               await signOut();
                    //               await Navigator.pushAndRemoveUntil(
                    //                 context,
                    //                 PageTransition(
                    //                   type: PageTransitionType.fade,
                    //                   duration: Duration(milliseconds: 300),
                    //                   reverseDuration:
                    //                       Duration(milliseconds: 300),
                    //                   child: LoginPageWidget(),
                    //                 ),
                    //                 (r) => false,
                    //               );
                    //             },
                    //             child: Text(
                    //               'CamDoc Finder',
                    //               style: FlutterFlowTheme.bodyText1.override(
                    //                 fontFamily: 'Condiment',
                    //                 color: FlutterFlowTheme.secondaryColor,
                    //                 fontSize: 27,
                    //                 fontWeight: FontWeight.w900,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         SingleChildScrollView(
                    //           child: Row(
                    //             mainAxisSize: MainAxisSize.max,
                    //             children: [
                    //               Padding(
                    //                 padding: EdgeInsetsDirectional.fromSTEB(
                    //                     0, 0, 20, 0),
                    //                 child: InkWell(
                    //                   onTap: () async {
                    //                     await Navigator.push(
                    //                       context,
                    //                       PageTransition(
                    //                         type: PageTransitionType.fade,
                    //                         duration:
                    //                             Duration(milliseconds: 300),
                    //                         reverseDuration:
                    //                             Duration(milliseconds: 300),
                    //                         child: CreatPostPageWidget(),
                    //                       ),
                    //                     );
                    //                   },
                    //                   child: Icon(
                    //                     Icons.add_box_outlined,
                    //                     color: FlutterFlowTheme.secondaryColor,
                    //                     size: 30,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: EdgeInsetsDirectional.fromSTEB(
                    //                     0, 4, 20, 0),
                    //                 child: Container(
                    //                   width: 36,
                    //                   height: 36,
                    //                   child: Padding(
                    //                     padding: EdgeInsetsDirectional.fromSTEB(
                    //                         0, 0, 2, 0),
                    //                     child: Icon(
                    //                       Icons.search,
                    //                       color:
                    //                           FlutterFlowTheme.secondaryColor,
                    //                       size: 30,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: EdgeInsetsDirectional.fromSTEB(
                    //                     0, 4, 20, 0),
                    //                 child: InkWell(
                    //                   onTap: () {
                    //                     //switch to dark mode here
                    //                     ThemeData.dark();
                    //                   },
                    //                   child: Icon(
                    //                     Icons.settings_outlined,
                    //                     color: FlutterFlowTheme.secondaryColor,
                    //                     size: 30,
                    //                   ),
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    Expanded(
                      child: Builder(
                        builder: (context) {
                          // final lostDocumentsList =
                          //     documentsPageLostDocumentsRecordList?.toList() ??
                          //         [];
                          return filteredLostDocs.length == 0
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      isSearching
                                          ? 'No match found'
                                          : "No document available for now",
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.title2),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: filteredLostDocs.length,
                                  itemBuilder:
                                      (context, lostDocumentsListIndex) {
                                    final lostDocumentsListItem =
                                        filteredLostDocs[
                                            lostDocumentsListIndex];
                                    return StreamBuilder<UsersRecord>(
                                      stream: UsersRecord.getDocument(
                                          lostDocumentsListItem.author),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: CircularProgressIndicator(
                                                color: FlutterFlowTheme
                                                    .primaryColor,
                                              ),
                                            ),
                                          );
                                        }
                                        final postItemUsersRecord =
                                            snapshot.data;
                                        return PostItemWidget(
                                          author: postItemUsersRecord,
                                          lost: lostDocumentsListItem,
                                          docIndex: lostDocumentsListIndex,
                                        );
                                      },
                                    );
                                  },
                                );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
