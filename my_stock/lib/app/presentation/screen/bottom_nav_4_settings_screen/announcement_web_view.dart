part of 'settings_screen.dart';

class _AnnouncementWebView extends StatefulWidget {
  const _AnnouncementWebView({super.key});

  @override
  State<_AnnouncementWebView> createState() => _AnnouncementWebViewState();
}

class _AnnouncementWebViewState extends State<_AnnouncementWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://volcano-clove-878.notion.site/2d3fe7da025e4aeb99cee5fe7f71a07d?pvs=4'));
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
