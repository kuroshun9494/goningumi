import 'package:flutter/material.dart';
import 'package:goningumi/group_menu.dart';
import 'package:goningumi/new_group.dart';
import 'package:goningumi/main.dart';

class GroupMenu extends StatefulWidget {
  GroupMenu();

  // NewGroup groupname = NewGroup();
  // List groupname = groupname_GroupText
  //final String name ="";
  List _GroupTexts = [];

  @override
  _GroupMenuState createState() => _GroupMenuState();
}

class _GroupMenuState extends State<GroupMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('グループメニュー'),
      ),
      body: SafeArea(
        child: ListView(
          children: const <Widget>[
            ListTile(
              leading: Icon(Icons.sports_soccer),
              title: Text('サッカー'),
            ),
            ListTile(
              leading: Icon(Icons.sports_baseball),
              title: Text('野球'),
            ),
            ListTile(
              leading: Icon(Icons.sports_baseball),
              title: Text('バスケ'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewGroup(_GroupTexts)),
        ),
        child: Icon(Icons.add_box),
      ),
    );
    //
  }
}
