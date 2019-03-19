import 'package:demo/grid_list_demo.dart';
import 'package:demo/layout_tutorial.dart';
import 'package:demo/navigator_tutorial.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcom to Flutter'),
        ),
        body: MyHomePage(),
      ),
      initialRoute: '/',
      routes: {
        LayoutTutorialWidget.routeName: (context) => LayoutTutorialWidget(),
        '/grid': (context) => GridDemo(),
        '/list': (context) => ListDemo(),
        SelectionScreen.routeName: (context) => SelectionScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: const Text("Layout tutorial"),
            onPressed: () {
              Navigator.pushNamed(context, LayoutTutorialWidget.routeName);
            },
          ),
          RaisedButton(
            child: const Text("Grid View"),
            onPressed: () {
              Navigator.pushNamed(context, '/grid');
            },
          ),
          RaisedButton(
            child: const Text("List View"),
            onPressed: () {
              Navigator.pushNamed(context, '/list');
            },
          ),
          RaisedButton(
            child: const Text("Selection"),
            onPressed: () async {
              final result = await Navigator.pushNamed(context, SelectionScreen.routeName);
              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text('$result')));
            },
          ),
        ],
      ),
    );
  }
}
