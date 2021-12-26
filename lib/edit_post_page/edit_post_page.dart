import 'package:cam_doc_finder/components/option_dialog.dart';
import 'package:cam_doc_finder/image_viewer/image_viewer_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPostPageWidget extends StatefulWidget {
  EditPostPageWidget({Key key, @required this.postToEdit}) : super(key: key);

  final LostDocumentsRecord postToEdit;

  @override
  _EditPostPageWidgetState createState() => _EditPostPageWidgetState();
}

class _EditPostPageWidgetState extends State<EditPostPageWidget> {
  bool _loadingButton2 = false;
  String uploadedFileUrl = '';
  List<String> uploadedFilesUrls = [];
  List<String> imagesToDelete = [];
  bool _loadingButton1 = false;
  TextEditingController textController1;
  TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: widget.postToEdit.title);
    textController2 =
        TextEditingController(text: widget.postToEdit.description);
    uploadedFilesUrls = widget.postToEdit.images.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Edit Post',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF090F13),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: Icon(
                Icons.close_rounded,
                color: Color(0xFF95A1AC),
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          )
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.94,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.96,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              image: uploadedFilesUrls.length == 0
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.asset(
                                        'assets/images/emptyState@2x.png',
                                      ).image,
                                    )
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 6,
                                  color: Color(0x3A000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 250),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                child: Builder(builder: (context) {
                                  return Swiper(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Hero(
                                            tag: "editlostdoc$index",
                                            child: Image.network(
                                              uploadedFilesUrls[index],
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 250,
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
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
                                          ),
                                          Positioned(
                                              top: 10,
                                              right: 15,
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                width: 30,
                                                height: 30,
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                child: FlutterFlowIconButton(
                                                    onPressed: () async {
                                                      final shouldRemove =
                                                          await showDialog<
                                                                  bool>(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      OptionDialog(
                                                                        title:
                                                                            "Remove Image",
                                                                        content:
                                                                            "Do you want to remove this image?",
                                                                        onConfirm:
                                                                            () =>
                                                                                Navigator.of(context).pop(true),
                                                                        onCancel:
                                                                            () =>
                                                                                Navigator.of(context).pop(false),
                                                                      ));
                                                      if (shouldRemove == true)
                                                        setState(() {
                                                          imagesToDelete.add(
                                                              uploadedFilesUrls
                                                                  .removeAt(
                                                                      index));
                                                        });
                                                    },
                                                    borderRadius: 0,
                                                    buttonSize: 30,
                                                    icon: Icon(
                                                        FontAwesomeIcons.trash,
                                                        size: 20,
                                                        color: Colors.red)),
                                              ))
                                        ],
                                      );
                                    },
                                    itemHeight: 250,
                                    loop: false,
                                    itemCount: uploadedFilesUrls.length,
                                    pagination: uploadedFilesUrls.length > 1
                                        ? new SwiperPagination()
                                        : null,
                                    control: uploadedFilesUrls.length > 1
                                        ? new SwiperControl()
                                        : null,
                                    onTap: (index) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ImageViewWidget(
                                                    imageUrl: uploadedFilesUrls[
                                                        index],
                                                    heroTag:
                                                        'editlostdoc$index',
                                                  )));
                                    },
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
                          child: FFButtonWidget(
                            onPressed: () async {
                              setState(() => _loadingButton1 = true);
                              try {
                                final selectedMedia =
                                    await selectMediaWithSourceBottomSheet(
                                  context: context,
                                  allowPhoto: true,
                                );
                                if (selectedMedia != null &&
                                    validateFileFormat(
                                        selectedMedia.storagePath, context)) {
                                  showUploadMessage(
                                      context, 'Uploading file...',
                                      showLoading: true);
                                  final downloadUrl = await uploadData(
                                      selectedMedia.storagePath,
                                      selectedMedia.bytes);
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  if (downloadUrl != null) {
                                    setState(() =>
                                        uploadedFilesUrls.add(downloadUrl));
                                    showUploadMessage(
                                        context, 'File Successfully uploaded!');
                                  } else {
                                    showUploadMessage(
                                        context, 'Failed to upload media');
                                    return;
                                  }
                                }
                              } finally {
                                setState(() => _loadingButton1 = false);
                              }
                            },
                            text: 'Add image',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FlutterFlowTheme.primaryColor,
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Quicksand',
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                            loading: _loadingButton1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: TextFormField(
                            controller: textController1,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Title...',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Lato',
                                color: Colors.black,
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
                                  EdgeInsetsDirectional.fromSTEB(10, 3, 10, 3),
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lato',
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: textController2,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Description....',
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
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  if (_loadingButton2 == false) {
                    setState(() => _loadingButton2 = true);
                    try {
                      //if any previous image of the post is to be deleted we delete it here

                      if (imagesToDelete.isNotEmpty) {
                        for (String im in imagesToDelete) {
                          final isdeleted = await deleteFile(im);
                          if (!isdeleted)
                            showSnackbar(context, "unable to delete image $im");
                        }
                      }

                      //we update the other fields now
                      final lostDocumentsCreateData = {
                        ...createLostDocumentsRecordData(
                            title: textController1.text,
                            description: textController2.text,
                            author: currentUserReference,
                            // dateAdded: DateTime.now(),
                            views: 0),
                        'images': uploadedFilesUrls,
                      };
                      final lostDocumentsRecordReference =
                          widget.postToEdit.reference;
                      await lostDocumentsRecordReference
                          .update(lostDocumentsCreateData);

                      setState(() {
                        textController1.clear();
                        textController2.clear();
                      });
                      // newPost = LostDocumentsRecord.getDocumentFromData(
                      //     lostDocumentsCreateData, lostDocumentsRecordReference);
                      showSnackbar(
                          context, "Succesfully updated post information!");
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pop(context);
                    } finally {
                      setState(() => _loadingButton2 = false);
                    }
                  }
                },
                text: 'Edit Post',
                options: FFButtonOptions(
                  width: 270,
                  height: 60,
                  color: FlutterFlowTheme.primaryColor,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  elevation: 3,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 8,
                ),
                loading: _loadingButton2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
