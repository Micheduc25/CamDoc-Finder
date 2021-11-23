import '../backend/backend.dart';
import '../contact_page/contact_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostItemWidget extends StatefulWidget {
  PostItemWidget({
    Key key,
    this.author,
    this.lost,
  }) : super(key: key);

  final UsersRecord author;
  final LostDocumentsRecord lost;

  @override
  _PostItemWidgetState createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  bool _loadingButton = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0x97000000),
      ),
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
                      ),
                      child: Image.network(
                        widget.author.photoUrl,
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
                            ),
                          ),
                          Text(
                            dateTimeFormat('relative', widget.lost.dateAdded),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lato',
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
              child: Text(
                widget.lost.description,
                style: FlutterFlowTheme.bodyText1,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
              child: Builder(
                builder: (context) {
                  final documentImages =
                      (widget.lost.images?.toList() ?? []).take(3).toList();
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(documentImages.length,
                          (documentImagesIndex) {
                        final documentImagesItem =
                            documentImages[documentImagesIndex];
                        return Image.network(
                          documentImagesItem,
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          fit: BoxFit.cover,
                        );
                      }),
                    ),
                  );
                },
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
