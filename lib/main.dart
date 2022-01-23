import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:goningumi/riverpods.dart';
import 'chat_page.dart';
import 'entry_user.dart';
import 'list_channel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this
  // Firebase初期化
  await Firebase.initializeApp();
  runApp(
    // Riverpodでデータを受け渡しできる状態にする
    ProviderScope(
      child: ChatApp(),
    ),
  );
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ja', ''), //日本語
        const Locale('en', ''), //英語
      ],
      title: 'ChatApp',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
      ),
      // ログイン画面を表示
      home: LoginPage(),
    );
  }
}

// ConsumerWidgetでProviderから値を受け渡す
class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // Providerから値を受け取る
    final infoText = watch(infoTextProvider).state;
    final email = watch(emailProvider).state;
    final password = watch(passwordProvider).state;

    // GestureDetector 画面をタップしたらキーボードを閉じる
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Goningumi',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                const SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // メールアドレス入力
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'メールアドレス',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value) {
                          // Providerから値を更新
                          context.read(emailProvider).state = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      //
                      // パスワード入力
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'パスワード',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        onChanged: (String value) {
                          // Providerから値を更新
                          context.read(passwordProvider).state = value;
                        },
                      ),

                      Container(
                        padding: EdgeInsets.all(8),
                        // メッセージ表示
                        child: Text(infoText),
                      ),

                      Container(
                        width: double.infinity,
                        // ログイン登録ボタン
                        child: ElevatedButton(
                          child: Text('ログイン'),
                          onPressed: () async {
                            try {
                              // メール/パスワードでログイン
                              final FirebaseAuth auth = FirebaseAuth.instance;
                              final Stream<QuerySnapshot> userStream =
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .where('email', isEqualTo: email)
                                      .snapshots();
                              //print(userStream);
                              userStream.listen((QuerySnapshot snapshot) {
                                final List users = snapshot.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data() as Map<String, dynamic>;
                                  final String userName = data['userName'];
                                  print(userName);
                                  context.read(userNameProvider).state = userName;
                                }).toList();
                              });

                              await auth.signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                              // ログインに成功した場合

                              // チャット画面に遷移＋ログイン画面を破棄
                              await Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return ListChannel();
                                }),
                              );
                            } catch (e) {
                              // Providerから値を更新
                              context.read(infoTextProvider).state =
                                  "ログインに失敗しました：${e.toString()}";
                            }
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text('パスワードを忘れた方',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                            textAlign: TextAlign.right),
                      ),
                      const SizedBox(height: 20),

                      Text('はじめての方はこちら',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        width: double.infinity,
                        // ユーザー登録ボタン
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: Text(
                            '新規登録',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return EntryUser();
                              }),
                            );
                            /*try {
                              // メール/パスワードでユーザー登録
                              final FirebaseAuth auth = FirebaseAuth.instance;
                              final result = await auth.createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                              // ユーザー情報を更新
                              context.read(userProvider).state = result.user;
                              // チャット画面に遷移＋ログイン画面を破棄
                              await Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                                  return ChatPage();
                                }),
                              );
                            } catch (e) {
                              // Providerから値を更新
                              context.read(infoTextProvider).state =
                                  "登録に失敗しました：${e.toString()}";
                            }*/
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
/*Future<String> getData(String collection, String inputField,
    String inputValue, String field) async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection(collection)
        .where(inputField, "==", inputValue)
        .get();
    //final queryDocSnapshot = querySnapshot.docs;
    Map<String, dynamic> record = querySnapshot.data;
    return record[field];
  }*/
}
