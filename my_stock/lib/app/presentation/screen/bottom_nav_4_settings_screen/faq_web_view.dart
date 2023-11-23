part of 'settings_screen.dart';

class _FaqWebView extends StatefulWidget {
  const _FaqWebView({super.key});

  @override
  State<_FaqWebView> createState() => _FaqWebViewState();
}

class _FaqWebViewState extends State<_FaqWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://volcano-clove-878.notion.site/FAQ-9b559d6c0ece4d5386f38e1213ad1263?pvs=4'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: _controller,
        ),
      ),
    );
  }
}
