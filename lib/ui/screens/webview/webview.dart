import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'components/jsModeDialog.dart';
import 'components/webview_actions.dart';

class ArticleWebView extends StatefulWidget {
  final String url;

  const ArticleWebView({Key? key, required this.url,}) : super(key: key);

  @override
  State<ArticleWebView> createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Hive.box("settings").get("doNotShowJsWarning") == false && Hive.box("settings").get("jsMode") == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (context) {
              return EnableJsDialog(
                lang: Hive.box('settings').get("lang") as String,
              );
            });
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    var loadingPercentage = 0;
    return Scaffold(
      appBar: AppBar(
        actions: [NavigationControls(controller: controller)],
      ),
      body: StatefulBuilder(
        builder: (context, setState) {
          return Stack(
            children: [
              ValueListenableBuilder<Box>(
                valueListenable: Hive.box('settings').listenable(),
                builder: (context, box, child) {
                  return WebView(
                    initialUrl: widget.url,
                    javascriptMode: box.get("jsMode") as bool
                        ? JavascriptMode.unrestricted
                        : JavascriptMode.disabled,
                    onWebViewCreated: (webViewController) {
                      controller.complete(webViewController);
                    },
                    onPageStarted: (url) {
                      setState(() {
                        loadingPercentage = 0;
                      });
                    },
                    onProgress: (progress) {
                      setState(() {
                        loadingPercentage = progress;
                      });
                    },
                    onPageFinished: (url) {
                      setState(() {
                        loadingPercentage = 100;
                      });
                    },
                  );
                },
              ),
              if (loadingPercentage < 100)
                LinearProgressIndicator(
                  value: loadingPercentage / 100.0,
                ),
            ],
          );
        },
      ),
    );
  }
}
