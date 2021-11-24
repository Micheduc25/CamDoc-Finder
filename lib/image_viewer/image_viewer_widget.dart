import 'package:cam_doc_finder/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class ImageViewWidget extends StatelessWidget {
  const ImageViewWidget({key, this.imageUrl, this.isNetworkImage = true})
      : super(key: key);
  final String imageUrl;
  final bool isNetworkImage;

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
                        tag: 'imagetoview',
                        child: Image.network(
                          imageUrl,
                          errorBuilder: (ctx, o, s) =>
                              Text("Unable to load image"),
                          fit: BoxFit.contain,
                        ))
                    : Hero(
                        tag: 'imagetoview',
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
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
