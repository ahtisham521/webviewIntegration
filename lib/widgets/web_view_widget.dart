import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String url;
  WebViewWidget({this.url});
  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  WebView _webView;
  final _key = UniqueKey();

  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _webView = WebView(
      initialUrl: widget.url,
      key: _key,
      gestureNavigationEnabled: true,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {},
    );
  }

  @override
  void dispose() {
    super.dispose();
    _webView = null;
  }

  @override
  Widget build(BuildContext context) {
    return _webView;
  }
}
