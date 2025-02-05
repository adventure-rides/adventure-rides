import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: SizedBox(
                width: 300,
                height: 400,
                child: WebView(
                  initialUrl: 'https://embed.tawk.to/674ed1112480f5b4f5a70989/1ie5u1bd1',
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
            );
          },
        );
      },
      child: Icon(Icons.chat),
    );
  }
}