import 'package:cam_doc_finder/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class ImageViewWidget extends StatelessWidget {
  const ImageViewWidget(
      {key,
      @required this.imageUrl,
      this.isNetworkImage = true,
      @required this.heroTag,
      this.initialCaption = "",
      this.showTextInput = false,
      this.textController})
      : super(key: key);
  final String imageUrl;
  final bool isNetworkImage;
  final String heroTag;
  final String initialCaption;
  final bool showTextInput;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              InteractiveViewer(
                child: isNetworkImage
                    ? Hero(
                        tag: heroTag,
                        child: Image.network(
                          imageUrl,
                          errorBuilder: (ctx, o, s) =>
                              Text("Unable to load image"),
                          fit: BoxFit.contain,
                        ))
                    : Hero(
                        tag: heroTag,
                        child: Image.asset(
                          imageUrl,
                          errorBuilder: (ctx, o, s) =>
                              Text("Unable to load image"),
                          fit: BoxFit.contain,
                        )),
              ),
              Positioned(
                  top: 10,
                  left: 15,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[500],
                                  blurRadius: 4,
                                  spreadRadius: 3)
                            ]),
                        child: Icon(Icons.arrow_back,
                            color: FlutterFlowTheme.tertiaryColor, size: 30),
                      ))),
              if (showTextInput)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                                controller: textController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2)))),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop(<String, dynamic>{
                                  'text': textController.text,
                                  'send': true
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.send,
                                    size: 30, color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              if (!showTextInput && initialCaption != "")
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        color: Colors.black.withOpacity(0.6),
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(initialCaption,
                            style: TextStyle(color: Colors.white))))
            ],
          ),
        ),
      ),
    );
  }
}
