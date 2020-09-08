import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  @override
  final String url;
  WebScreen(this.url);
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  @override
  final Completer<WebViewController> completer = Completer<WebViewController>();

  String finalUrl;
  void initState() {
    // TODO: implement initState
    if (widget.url.contains("http://")) {
      finalUrl = widget.url.replaceAll("http://", "https://");
    } else {
      finalUrl = widget.url;
    }
    super.initState();
  }

  var isloading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Color(0xff1C3044), Color(0xff0A192D)],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "HomeMade",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Recipes",
                      style: TextStyle(
                          color: Colors.blue[700], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: WebView(
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    setState(() {
                      completer.complete(controller);
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 10),
                  child: FloatingActionButton(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                    backgroundColor: Colors.pink,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
