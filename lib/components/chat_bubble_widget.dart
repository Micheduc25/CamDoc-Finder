import 'package:cam_doc_finder/auth/auth_util.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubbleWidget extends StatefulWidget {
  ChatBubbleWidget({
    Key key,
    this.sender,
    this.message,
  }) : super(key: key);

  final UsersRecord sender;
  final ChatMessagesRecord message;

  @override
  _ChatBubbleWidgetState createState() => _ChatBubbleWidgetState();
}

class _ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85, minWidth: 10),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
        child: Material(
          color: Colors.transparent,
          elevation: 14,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: widget.sender.uid == currentUserUid
                  ? Color(0xFF0A3A8A)
                  : Colors.pink[600],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                    child: Text(
                      widget.sender.displayName.maybeHandleOverflow(
                        maxChars: 15,
                        replacement: '…',
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (widget.message.image != null &&
                      widget.message.image.isNotEmpty)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xFF09275F),
                      ),
                      child: Image.network(
                        widget.message.image,
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  Divider(
                    color: Color(0xFFC0BFBF),
                  ),
                  Text(
                    widget.message.text,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lato',
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      dateTimeFormat('relative', widget.message.timestamp),
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lato',
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
