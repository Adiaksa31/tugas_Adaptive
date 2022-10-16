import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_adaptive/background.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:intl/intl.dart';

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
  TextEditingController dateInput = TextEditingController();
  late TextEditingController textController;
  DateTime date = DateTime(2016, 10, 26);

  @override
  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Peringatan'),
        content: const Text('Apakah tanggal yang anda masukkan sudah benar?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  void initState() {
    dateInput.text = "";
    textController = TextEditingController(text: 'initial text');
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

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
              middle: CupertinoSearchTextField(
                controller: textController,
                placeholder: 'Search',
              ),
            ),
            child: Column(
              children: <Widget>[
                _DatePickerItem(
                  children: <Widget>[
                    const Text('Date'),
                    CupertinoButton(
                      onPressed: () => _showDialog(
                        CupertinoDatePicker(
                          initialDateTime: date,
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() => date = newDate);
                          },
                        ),
                      ),
                      child: Text(
                        '${date.month}-${date.day}-${date.year}',
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () => _showAlertDialog(context),
                      child: const Text('SUBMIT'),
                      color: Color.fromARGB(255, 0, 153, 255),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Flutter Adaptive"),
              backgroundColor: Color.fromARGB(255, 21, 19, 179),
              shadowColor: Colors.grey,
              actions: [
                IconButton(
                  onPressed: () {
                    // method to show the search bar
                    showSearch(
                        context: context,
                        // delegate to customize the search bar
                        delegate: CustomSearchDelegate());
                  },
                  icon: const Icon(Icons.search),
                )
              ],
            ),
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 270),
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
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                              color: Color.fromARGB(255, 255, 255, 255),
                              height: MediaQueryHeight * 0.3,
                              width: MediaQueryWidth,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(15),
                                      child: Center(
                                          child: TextField(
                                        controller: dateInput,
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.calendar_today),
                                            labelText: "Enter Date"),
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950),
                                                  lastDate: DateTime(2100));

                                          if (pickedDate != null) {
                                            print(pickedDate);
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            print(formattedDate);
                                            setState(() {
                                              dateInput.text = formattedDate;
                                            });
                                          } else {}
                                        },
                                      ))),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Color.fromARGB(255, 4, 0, 5),
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 212, 250),
                                    ),
                                    onPressed: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('PERINGATAN'),
                                        content: const Text(
                                            'Apakah tanggal yang dimasukkan sudah benar?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: const Text('SUBMIT'),
                                  ),
                                ],
                              )),
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
                          AspectRatio(
                            aspectRatio: 1,
                            child: SizedBox(
                              width: double.infinity,
                              child: GridView.builder(
                                  itemCount: 12,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemBuilder: (context, index) {
                                    return NewContainer(MediaQueryWidth);
                                  }),
                            ),
                          )
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Color.fromARGB(255, 247, 247, 247),
      ),
    );
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

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
