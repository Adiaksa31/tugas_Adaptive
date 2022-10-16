import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_adaptive/background.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

void main() {
  //function agar tidak bisa di rotate
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryHeight = MediaQuery.of(context).size.height;
    final MediaQueryWidth = MediaQuery.of(context).size.width;
    AppBar(
      title: Text("Flutter Adaptive"),
      backgroundColor: Color.fromARGB(255, 21, 19, 179),
      shadowColor: Colors.grey,
    );

    final bodyHeight = MediaQueryHeight - MediaQuery.of(context).padding.top;

    final bool islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
              middle: const Text('Flutter Adactive IOS'),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: CustomPaint(
                    painter: BackgroundPainter(),
                    child: Container(
                      width: MediaQueryWidth,
                      height: MediaQueryHeight,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Flutter Adaptive"),
              backgroundColor: Color.fromARGB(255, 21, 19, 179),
              shadowColor: Colors.grey,
            ),
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: CustomPaint(
                    painter: BackgroundPainter(),
                    child: Container(
                      width: MediaQueryWidth,
                      height: MediaQueryHeight,
                    ),
                  ),
                ),
                LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            color: Color.fromARGB(255, 77, 77, 74),
                            height: MediaQueryHeight * 0.3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "REKOMENDASI",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
  }
}

class NewContainer extends StatelessWidget {
  double MediaQueryWidth;

  NewContainer(
    this.MediaQueryWidth,
  );
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      return Container(
        height: Constraints.maxHeight * 0.8,
        width: MediaQueryWidth * 0.15,
        color: Colors.green,
      );
    });
  }
}

class NewCntainer extends StatelessWidget {
  double MediaQueryWidth;

  NewCntainer(
    this.MediaQueryWidth,
  );
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      return Container(
        height: Constraints.maxHeight * 0.8,
        width: MediaQueryWidth * 0.15,
        color: Colors.green,
      );
    });
  }
}
