import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  String url;
  WebView({super.key, required this.url});

  @override
  State<WebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("NEWS NOW"),
      ),
    );
  }
}
