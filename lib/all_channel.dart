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
    // Providerから値を受け取る
    final channel =  watch(channelProvider).state;
    final User user = watch(userProvider).state!;
    final userName = watch(userNameProvider).state;
    final AsyncValue<QuerySnapshot> asyncChannelQuery = watch(channelQueryProvider);

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
            child: asyncChannelQuery.when(
              // 値が取得できたとき
              data: (QuerySnapshot query) {
                return ListView(
                  children: [
                    for (var doc in query.docs)
                        Card(
                          child: ListTile(
                            title: Text(doc['channelName']),
                            subtitle: Text("1"),
                            trailing: 1 == 1
                                ? IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () async {
                                // 投稿メッセージのドキュメントを削除
                                await FirebaseFirestore.instance
                                    .collection('posts')
                                    .doc(doc.id)
                                    .delete();
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