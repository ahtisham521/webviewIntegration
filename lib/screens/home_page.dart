import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/web_view_widget.dart';

class MyHomePage extends StatefulWidget {
  static Future<String> get _url async {
    await Future.delayed(Duration(seconds: 1));
    return 'https://www.hangree.com.pk';
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebViewController controllerGlobal;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hangree'),
        ),
        body: Center(
          child: FutureBuilder(
              future: MyHomePage._url,
              builder: (BuildContext context, AsyncSnapshot snapshot) =>
                  snapshot.hasData
                      ? WebViewWidget(
                          url: snapshot.data,
                        )
                      : CircularProgressIndicator()),
        ),
      ),
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    bool goBack;
    var value = await controllerGlobal.canGoBack(); // check webview can go back

    if (value) {
      controllerGlobal.goBack(); // perform webview back operation

      return false;
    } else {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title:
              new Text('Confirmation ', style: TextStyle(color: Colors.purple)),

          // Are you sure?

          content: new Text('Do you want to exit app ? '),

          // Do you want to go back?

          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);

                setState(() {
                  goBack = false;
                });
              },

              child: new Text('Yes'), // No
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();

                setState(() {
                  goBack = true;
                });
              },

              child: new Text('No'), // Yes
            ),
          ],
        ),
      );
      if (goBack) Navigator.pop(context); // If user press Yes pop the page

      return goBack;
    }
  }
}
