part of 'settings_screen.dart';

class _HowToUseWebView extends StatefulWidget {
  const _HowToUseWebView({super.key});

  @override
  State<_HowToUseWebView> createState() => _HowToUseWebViewState();
}

class _HowToUseWebViewState extends State<_HowToUseWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://volcano-clove-878.notion.site/f4cc866d4ccf432aa747a75dbc45d84c?pvs=4'));
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
