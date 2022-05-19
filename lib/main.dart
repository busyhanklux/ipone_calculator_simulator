import 'package:flutter/material.dart';

import 'buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(title: '仿 iphone 計算機'),
    );
  }
}

class HomePage extends StatefulWidget {

  //title
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  final List<String> buttons =
  [
    'C','DEL','%','/',
    '9','8','7','x',
    '6','5','4','-',
    '3','2','1','+',
    '0','.','ANS','=',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.deepPurple[100], //背景色(最底色)
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Container(
              //color:Colors.deepPurple,), //在背景色上層一層，位於計算輸入按鈕處

              child: Center(child: MyButton(
                color: Colors.deepPurple,
                textColor:Colors.white ,
                buttonText: '0',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
