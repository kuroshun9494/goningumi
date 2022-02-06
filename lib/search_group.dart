import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:goningumi/riverpods.dart';
import 'package:flutter/material.dart';
import 'package:rich_text_controller/rich_text_controller.dart';
import 'chat_page.dart';
import 'entry_user.dart';
import 'list_channel.dart';
import 'create_group.dart';

// class SearchGroup extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Text Search Test",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light(),
//       home: HomeScreenO(),
//     );
//   }
// }

class HomeScreenO extends StatefulWidget {
  @override
  _HomeScreenOState createState() => _HomeScreenOState();
}

class _HomeScreenOState extends State<HomeScreenO> {
// ここまではお決まりのコード

  // 検索ワードを入れるプロパティ。初期値は""にしておく
  String searchWordO = "";

  // テキスト本文に設定するTextEditingControllerの拡張クラスのインスタンスを定義
  // 後で具体的内容を入れるため、lateで宣言
  late MainTextControllerO mainTextControllerO;

  // 検索ワードを入力するTextFieldに設置する
  // TextEditingControllerクラスのインスタンスを作成
  TextEditingController searchWordControllerO = TextEditingController();

  // テキスト本文のTextFieldの高さ
  double textFieldHeightO = 200;

  // テキスト本文のTextFieldの左右パディング
  double paddingO = 10;

  @override
  void initState() {
    // mainTextControllerOを初期設定
    // 引数として検索ワードを渡す
    mainTextControllerO = MainTextControllerO(searchWordO: searchWordO);
    super.initState();
  }

  @override
  void dispose() {
    // 画面遷移時やアプリ終了時にリソースを開放するため
    // 2つのcontrollerをdispose処理
    mainTextControllerO.dispose();
    searchWordControllerO.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // 検索ワード入力ボックスを設置するAppBar
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search),
            Container(
              // 検索ワードを入力するTextFieldの横幅を設定
              width: 200,
              child: TextFormField(
                // コントローラーの設置
                controller: searchWordControllerO,
                decoration: InputDecoration(
                  // デフォルトの下線の削除
                  border: InputBorder.none,
                  // 改行時の行ズレを防ぐため設定
                  isDense: true,
                  // TextField内の色を塗るため設定
                  filled: true,
                  // 色はprimaryColor（青）の明るい色を設定
                  fillColor: Theme.of(context).primaryColorLight,
                ),

                // 検索ワード入力完了時の処理
                onFieldSubmitted: (wordO) {

                  // 検索マッチ位置の色変更を反映するため、setStateで画面を再描画
                  setState(() {

                    // 入力した検索ワードをプロパティに格納
                    searchWordO = searchWordControllerO.text;

                    // テキスト本文を一時的にプロパティに格納
                    String tempStringO = mainTextControllerO.text;

                    // 入力後の検索ワードに基づいて改めてMainTextControllerのインスタンスを更新
                    mainTextControllerO = MainTextControllerO(searchWordO: searchWordO);

                    // 更新により、インスタンスが初期化されてしまうため、
                    // コントローラーのテキストに、一時保管していたテキスト本文を代入
                    mainTextControllerO.text = tempStringO;

                  });
                },
              ),
            ),
          ],
        ),
      ),

      // テキスト本文を入力するTextField部分
      // キーボード出現時の画面はみ出しエラーを防ぐため、SingleChildScrollViewでラップ
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("↓テキスト本文"),

            Container(
              // TextFieldに高さを設定
              height: textFieldHeightO,
              // 背景色には、primaryColor（デフォルト青）の明るい色を設定
              color: Theme.of(context).primaryColorLight,
              child: Scrollbar(
                child: TextField(

                  // TextEditingControllerの設置
                  controller: mainTextControllerO,

                  style: TextStyle(
                    // フォントサイズとして、標準のprimaryTextThemeのbodyText1を設定
                    fontSize:
                    Theme.of(context).primaryTextTheme.bodyText1!.fontSize,
                  ),

                  strutStyle: const StrutStyle(
                    // 1行の高さをフォントサイズに対する倍数値で設定
                    height: 1.5,

                    // 改行とともにズレるのを防ぐため、行間強制を設定
                    forceStrutHeight: true,
                  ),

                  // アプリ起動時にフォーカスが当たるよう設定
                  autofocus: true,

                  // 複数行入力可能に設定
                  keyboardType: TextInputType.multiline,
                  maxLines: null,

                  decoration: InputDecoration(

                    // パディングは左右にだけ設定
                    contentPadding:
                    EdgeInsets.fromLTRB(paddingO, 0, paddingO, 0),

                    // 枠の除去、改行時の行ズレ防止、背景色設定
                    border: InputBorder.none,
                    isDense: true,
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TextEditingControllerの拡張クラスとして、
// 特定の文字列に背景色等のスタイルを設定した上で、
// テキスト本文を再構築するクラスを作成
class MainTextControllerO extends TextEditingController {

  // 引数で受けるプロパティを宣言
  final String searchWordO;
  // 引数として検索ワードのプロパティを受けとる
  MainTextControllerO({required this.searchWordO});

  @override
  // buildTextSpanは、編集中のテキストからTextSpanを構築するメソッド
  // 3つの引数名は変更不可
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    // このtextはTextEditingControllerのテキスト内容（つまりテキスト本文の内容）を指している
    // contextは本来不要だが、後段のフォントサイズの設定で「Theme.of(context)」を使うため、引数に設定
    return searchMatchO(text, searchWordO, style, context);
  }

  TextSpan searchMatchO(String mainTextO, String searchWordO, TextStyle? styleO, BuildContext context) {

    // テキスト本文を、異なるスタイルを設定するパーツ（TextSpan）に分けてリスト型で格納するプロパティ
    List<InlineSpan> childrenO = [];

    /// ケースA 検索ワードが空の場合
    // テキスト本文全体を通常のスタイル（黒文字）に設定して、早期リターン
    if (searchWordO == "") {
      childrenO.add(TextSpan(
          style: TextStyle(
            color: Colors.black,
            // マッチ箇所のバックグラウンドカラーが維持されるのを防ぐため、
            // 適当なバックグラウンドカラーを設定し、透過100%にする
            // ※単に背景と同色を設定するだけだと、カーソルが見えなくなってしまうため
            backgroundColor: Colors.white.withOpacity(0.0),
            // フォントサイズとして、標準のprimaryTextThemeのbodyText1を設定
            fontSize: Theme.of(context).primaryTextTheme.bodyText1!.fontSize,
          ),
          text: mainTextO));
      return TextSpan(style: styleO, children: childrenO);
    }

    /// ケースB 検索ワードがあり、本文が検索ワードを含んでいる場合
    if (mainTextO.contains(searchWordO)) {

      /// ケースB① 本文の先頭が検索ワードと一致している場合
      // つまり、本文の0番目〜検索ワードの文字数番目までの文字が、検索ワードと一致している場合
      if (mainTextO.substring(0, searchWordO.length) ==
          searchWordO) {

        // その一致部分のスタイルに、赤背景・白文字（マッチ部分だと分かる目立つスタイル）を
        // 設定して、リスト変数に格納
        childrenO.add(
          TextSpan(
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.redAccent,
              fontSize: Theme.of(context).primaryTextTheme.bodyText1!.fontSize,
            ),
            text: mainTextO.substring(0, searchWordO.length),

            // 上記text:プロパティに続くテキスト部分を、children:プロパティにリスト型で設定
            children: [
              // 自分自身（searchMatchOメソッド）を再帰的に呼ぶことで、
              // 文末まで繰り返しマッチング処理した結果（返り値）を設定
              // ※繰り返しにより複数の返り値が返ってくるため、リスト型になる
              searchMatchO(
                // マッチした検索ワードの次の文字から文末までを
                // 検索対象として引数に入れ直し、マッチング処理
                // ※次はケースB①②③, Cの場合がありうる
                //  B②かCになればそこで終了
                mainTextO.substring(searchWordO.length),
                searchWordO,
                styleO,
                context,
              )
            ],
          ),
        );

        /// ケースB② 本文と検索ワードが完全一致のとき（本文が検索ワードを含み、かつ文長が同じ場合のため）
        // テキスト本文全体を赤背景・白文字（マッチ部分だと分かる目立つスタイル）に設定
        // これ以降、マッチング処理する本文はないため、処理終了（searchMatchOメソッド最後のreturnへ）
      } else if (mainTextO.length == searchWordO.length) {
        childrenO.add(
          TextSpan(
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.redAccent,
                fontSize: Theme.of(context).primaryTextTheme.bodyText1!.fontSize,
              ),
              text: mainTextO),
        );

        /// ケースB③ 本文が検索ワードを含んでいるが、本文先頭での一致や完全一致はしていないとき
        ///         つまり本文の後方で一致がある場合
      } else {

        // その本文の先頭〜検索ワードが出てくる手前までの部分のスタイルに、
        // 通常のスタイル（黒文字）を設定して、リスト変数に格納
        childrenO.add(
          TextSpan(
            style: TextStyle(
              color: Colors.black,
              // マッチ箇所のバックグラウンドカラーが維持されるのを防ぐため、
              // 適当なバックグラウンドカラーを設定し、透過100%にする
              // ※単に背景と同色を設定するだけだと、カーソルが見えなくなってしまうため
              backgroundColor: Colors.white.withOpacity(0.0),
              fontSize: Theme.of(context).primaryTextTheme.bodyText1!.fontSize,
            ),
            text: mainTextO.substring(
                0, mainTextO.indexOf(searchWordO)),

            // 上記text:プロパティに続くテキスト部分を、children:プロパティにリスト型で設定
            children: [
              // 自分自身（searchMatchOメソッド）を再帰的に呼ぶことで、
              // 文末まで繰り返しマッチング処理した結果（返り値）を設定
              // ※繰り返しにより複数の返り値が返ってくるため、リスト型になる
              searchMatchO(
                // 検索ワードが出てくる手前までを除去し、検索ワードの先頭から文末までを
                // 検索対象として引数に入れ直し、マッチング処理
                // ※次は必ず先頭マッチ（B①）か完全マッチ（B②）のいずれかになる
                //  B②になればそこで終了
                  mainTextO
                      .substring(mainTextO.indexOf(searchWordO)),
                  searchWordO,
                  styleO,
                  context),
            ],
          ),
        );
      }

      /// ケースC 本文が検索文字を含んでいない場合
    } else {
      childrenO.add(TextSpan(
          style: TextStyle(
            color: Colors.black,
            // マッチ箇所のバックグラウンドカラーが維持されるのを防ぐため、
            // 適当なバックグラウンドカラーを設定し、透過100%にする
            // ※単に背景と同色を設定するだけだと、カーソルが見えなくなってしまうため
            backgroundColor: Colors.white.withOpacity(0.0),
            fontSize: Theme.of(context).primaryTextTheme.bodyText1!.fontSize,
          ),
          text: mainTextO));
    }

    // テキスト本文の全てにスタイルの設定が完了し、それをTextSpan型で返す
    return TextSpan(style: styleO, children: childrenO);
  }
}