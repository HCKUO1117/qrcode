
import 'package:flutter/material.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).privacy),
      ),
      body: const WebView(
        initialUrl: 'https://www.privacypolicies.com/live/16f1ea57-7821-466f-87ef-82185a487cb6',
      ),
    );
  }
}
