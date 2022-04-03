import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:goningumi/riverpods.dart';
import 'add_post_page.dart';
import 'main.dart';
import 'package:riverpod/riverpod.dart';


// flutter_chat_uiを使うためのパッケージをインポート



class AllChannel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    int ableToJoinOrNot(var doc, String userName) {
      // List<String>memberList=[doc["member1"],doc["member2"],doc["member3"],doc["member4"],doc["member5"]];
      for (int i = 1; i < 6; i++) {
        if (doc['member${i}'] == userName) return 0;
        if (doc['member${i}'] == "") return i;
      }
      return 0;
    }
    void addMember(var doc, int user_number, String userName) {
        FirebaseFirestore.instance
            .collection('channels').
        doc(doc.id).update({
          'member${user_number}': userName
      });
    }
    // Providerから値を受け取る
    final channel =  watch(channelProvider).state;
    final User user = watch(userProvider).state!;
    final userName = watch(userNameProvider).state;
    final AsyncValue<QuerySnapshot> asyncPostsQuery = watch(channelQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('チャンネル一覧'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            // child: Text('ログイン情報：${user.email}'),
            child: Text('ログイン情報：$userName'),
          ),
          Expanded(
            // StreamProviderから受け取った値は .when() で状態に応じて出し分けできる
            child: asyncPostsQuery.when(
              // 値が取得できたとき
              data: (QuerySnapshot query) {
                return ListView(
                    children: [
                      for (var doc in query.docs)
                          Card(
                            child: ListTile(
                              title: Text(doc['channelName']),
                              subtitle: Text(ableToJoinOrNot(doc,userName).toString()),
                              trailing: 0!=ableToJoinOrNot(doc,userName)
                                  ? IconButton(
                                icon: Icon(Icons.add),
                                onPressed: (){
                                  addMember(doc, ableToJoinOrNot(doc,userName), userName);
                                },
                              )
                                  : null,
                            ),
                          )
                    ]
                );
              },
              // 値が読込中のとき
              loading: () {
                return Center(
                  child: Text('読込中...'),
                );
              },
              // 値の取得に失敗したとき
              error: (e, stackTrace) {
                return Center(
                  child: Text(e.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}