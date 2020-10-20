import 'package:dropbox_integration/Classes/ALL.dart';
import 'package:dropbox_integration/dropbox_integration.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

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
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() { 
    super.initState();
    Dropbox.initDropbox('test_package', '76622irrovj4cu9', 'ovb3zknaaf73nvy');
  }

  List<DropboxFileTypes> userFilesList = [];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([

            RaisedButton(
              onPressed: () => Dropbox.login(),
              child: Text('login'),
            ),

            RaisedButton(
              onPressed: () async => await Dropbox.getAccessToken().then((value) => setState(() {})),
              child: Text('getToken'),
            ),

            RaisedButton(
              onPressed: (Dropbox.instance != null) ? (() => Dropbox.instance.filesActions.getFilesList('')
                .then((value) => setState(() => userFilesList = value))) : null,
              child: Text('getFilesList'),
            ),


            RaisedButton(
              onPressed: (Dropbox.instance != null) ? (() => Dropbox.logout().then((value) => setState(() {
                userFilesList = [];
              }))) : null,
              child: Text('log out'),
            ),

          ])),


          //A builder for the files list
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, n) {
              if(userFilesList[n].isFile) {
                return ListTile(
                  title: Text(userFilesList[n].name),
                  subtitle: Text('File'),
                );
              } else {
                return ListTile(
                  title: Text(userFilesList[n].name),
                  subtitle: Text('Folder'),
                );
              }
            },
            childCount: userFilesList.length,
          ))
        ],
      )
    );
  }
}
