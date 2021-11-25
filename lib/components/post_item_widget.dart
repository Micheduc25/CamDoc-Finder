import 'package:cam_doc_finder/auth/auth_util.dart';
import 'package:cam_doc_finder/auth/firebase_user_provider.dart';
import 'package:cam_doc_finder/image_viewer/image_viewer_widget.dart';

import '../backend/backend.dart';
import '../contact_page/contact_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PostItemWidget extends StatefulWidget {
  PostItemWidget({Key key, this.author, this.lost, @required this.docIndex})
      : super(key: key);

  final UsersRecord author;
  final LostDocumentsRecord lost;
  final int docIndex;

  @override
  _PostItemWidgetState createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  bool _loadingButton = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 25),
      // decoration: BoxDecoration(
      //   color: Color(0x97000000),
      // ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: FlutterFlowTheme.primaryColor)),
                      child: Image.network(
                        widget.author.photoUrl,
                        errorBuilder: (ctx, o, s) {
                          return Icon(Icons.person, color: Colors.grey[300]);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.author.displayName,
                            style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Lato',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: FlutterFlowTheme.tertiaryColor),
                          ),
                          Text(
                            dateTimeFormat('relative', widget.lost.dateAdded),
                            style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Lato',
                                fontSize: 12,
                                color: FlutterFlowTheme.tertiaryColor),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                if (currentUserUid != widget.author.uid)
                  FFButtonWidget(
                    onPressed: () async {
                      setState(() => _loadingButton = true);
                      try {
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 300),
                            reverseDuration: Duration(milliseconds: 300),
                            child: ContactPageWidget(
                              lost: widget.lost,
                              author: widget.author,
                            ),
                          ),
                        );
                      } finally {
                        setState(() => _loadingButton = false);
                      }
                    },
                    text: 'Contact',
                    options: FFButtonOptions(
                      width: 100,
                      height: 35,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Quicksand',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 6,
                    ),
                    loading: _loadingButton,
                  )
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Text(
                widget.lost.title,
                style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lato',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: FlutterFlowTheme.tertiaryColor),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
              child: Text(
                widget.lost.description,
                style: FlutterFlowTheme.bodyText1
                    .copyWith(color: FlutterFlowTheme.tertiaryColor),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 250),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                child: Builder(builder: (context) {
                  final documentImages =
                      (widget.lost.images?.toList() ?? []).take(3).toList();
                  return Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Hero(
                        tag: "lostdoc${widget.docIndex}$index",
                        child: Image.network(
                          documentImages[index],
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
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
                    itemCount: documentImages.length,
                    pagination: new SwiperPagination(),
                    control: new SwiperControl(),
                    onTap: (index) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ImageViewWidget(
                                imageUrl: documentImages[index],
                                heroTag: 'lostdoc${widget.docIndex}$index',
                              )));
                    },
                  );
                }),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 3, 0),
                  child: Icon(
                    Icons.visibility,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                Text(
                  widget.lost.views.toString(),
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
