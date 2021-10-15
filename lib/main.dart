import 'package:flutter/material.dart';
import 'package:goningumi/group_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goningumi',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: '五人組 Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _formController = TextEditingController();
  List _formTexts = [];

  @override
  Widget build(BuildContext context) {
    //キーボードの高さを取得
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    //print(bottomSpace);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        leading: ElevatedButton(
          child: Text('menu'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GroupMenu()),

          ),

        ),

      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomSpace),
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                buildChatArea(),
                buildFormArea(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildChatArea() {
    return Expanded(
      child: Container(
        color: Colors.greenAccent,
        //スクロール可能にすうる
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: Column(
              children: [
                for (var text in _formTexts)
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(text),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildFormArea() {
    return Container(
      //height: 68,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  controller: _formController,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    //fontStyle: FontStyle.normal
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your comment',
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () => setState(
                      () {
                        _formTexts.add(_formController.text);
                        print(_formTexts);
                      },
                    ),
                icon: Icon(Icons.send)),
          ],
        ),
      ),
    );
    //
  }
}
