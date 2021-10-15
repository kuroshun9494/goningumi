import 'package:flutter/material.dart';
import 'package:goningumi/group_menu.dart';
//import 'package:goningumi/main.dart';

class NewGroup extends StatefulWidget {
  NewGroup();

  //final String name ="";

  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('新規グループ作成'),
      ),


    );
    //
  }
}
