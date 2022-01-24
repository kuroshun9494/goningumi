import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goningumi/riverpods.dart';
import 'package:goningumi/list_channel.dart';


// ConsumerWidgetでProviderから値を受け渡す
class CreateGroup extends ConsumerWidget {
  @override
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context, ScopedReader watch) {
    // Providerから値を受け取る
    final user = watch(userProvider).state!;
    final userName = watch(userNameProvider).state;
    final messageText = watch(messageTextProvider).state;
    // String value2;

    return Form(
        key: _formKey,
    child: Scaffold(
      appBar: AppBar(
        title: Text('グループ作成'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'グループ名'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onChanged: (String value) {
                  // Providerから値を更新
                  context.read(messageTextProvider).state = value;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  // value2 = value.toString();
                  if (value!.isEmpty) {
                    return 'Please enter a group-name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('作成'),
                  onPressed: () async {
                    // if (value! isEqualsTo "") {
                    //   return 'Please enter a region.';
                    // }
                    if (_formKey.currentState!.validate()) {
                    final date = DateTime.now().toLocal().toIso8601String();
                    final email = user.email;
                    await FirebaseFirestore.instance
                        .collection('channels')
                        .doc()
                        .set({
                      // 'text': messageText,
                      // 'email': email,
                      // 'date': date
                      'channelName': messageText,
                      'createDate' : date,
                      'updateDate' : date,
                      'member1' : userName,
                      'member2' : email,
                      'member3' : email,
                      'member4' : email,
                      'member5' : email
                    });
                    print(userName);
                    // Navigator.of(context).pop()
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {

                        return ListChannel();
                      }),
                    );
                  }
                    },
                ),
              )
            ],
          ),
        ),
      ),
    )
    );

  }
}