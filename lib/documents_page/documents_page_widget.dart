import 'package:cam_doc_finder/backend/search/search.dart';
import 'package:easy_debounce/easy_debounce.dart';
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
  String searchString = "";

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
    // print(isSearching);
    if (isSearching == false)
      setState(() {
        isSearching = true;
      });

    if (documentsPageLostDocumentsRecordList != null) {
      EasyDebounce.debounce('search-chat', Duration(milliseconds: 400),
          () async {
        setState(() {
          searchString = value;
        });
      });
    }
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

          filteredLostDocs = SearchItems.documentsSearch(
              query: searchString,
              collection: documentsPageLostDocumentsRecordList);
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.secondaryColor,
            appBar: searchBar.build(context),
            floatingActionButton: FloatingActionButton(
                backgroundColor: FlutterFlowTheme.primaryColor,
                child: Icon(
                  Icons.add,
                ),
                tooltip: "new post",
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.scale,

                      // duration: Duration(milliseconds: 300),
                      alignment: Alignment.bottomLeft,
                      reverseDuration: Duration(milliseconds: 300),
                      child: CreatPostPageWidget(),
                    ),
                  );
                }),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(1, 0, 1, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                                  // physics: BouncingScrollPhysics(),
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
