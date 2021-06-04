import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewPage extends StatefulWidget {

  //传参赋值
  final String webUrl;
  final String title;
  const WebViewPage(this.webUrl,{this.title});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _controller;
  String _title = "webview";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title ?? "$_title"),
      ),
      child: SafeArea(
        child: WebView(
          initialUrl: widget.webUrl,
          //JS执行模式 是否允许JS执行
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            _controller = controller;
          },
          onPageFinished: (url) {
            _controller.evaluateJavascript("document.title").then((result){
              setState(() {
                _title = result;
              });
            }
            );
          },
          navigationDelegate: (NavigationRequest request) {
            if(request.url.startsWith("myapp://")) {
              print("即将打开 ${request.url}");

              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          } ,
          javascriptChannels: <JavascriptChannel>[
            JavascriptChannel(
                name: "share",
                onMessageReceived: (JavascriptMessage message) {
                  print("参数： ${message.message}");
                }
            ),
          ].toSet(),

        ),
      ),
    );
  }
}