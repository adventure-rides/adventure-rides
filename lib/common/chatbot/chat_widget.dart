import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tawk.to Chat'),
      ),
      body: WebView(
        initialUrl: Uri.dataFromString(
          '''
          <!DOCTYPE html>
          <html>
          <head>
            <title>Tawk.to Chat</title>
          </head>
          <body>
            <script type="text/javascript">
              var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
              (function(){
                var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
                s1.async=true;
                s1.src='https://embed.tawk.to/674ed1112480f5b4f5a70989/1ie5u1bd1';
                s1.charset='UTF-8';
                s1.setAttribute('crossorigin','*');
                s0.parentNode.insertBefore(s1,s0);
              })();
            </script>
          </body>
          </html>
          ''',
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}