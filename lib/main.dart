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
    'C','<=','%','/',
    '9','8','7','x',
    '6','5','4','-',
    '3','2','1','+',
    '+/-','0','.','='
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white, //背景色(最底色)
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Container(
              //color:Colors.deepPurple,), //在背景色上層一層，位於計算輸入按鈕處
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), //每排的數量
                itemBuilder: (BuildContext Context, int index){

                  if((index - 3) < 0) { // -3 <0 指前三個

                    return MyButton(
                      buttonText: buttons[index], //按照有多少的button陣列元素，依序排列(每排4個)
                      color: Colors.grey,
                      textColor: Colors.white,
                    );

                  }else{
                    return MyButton(
                      buttonText: buttons[index], //按照有多少的button陣列元素，依序排列(每排4個)
                      color: isOperator(buttons[index])?  Colors.orange : Colors.black , //是否為 isOperator 之文字? T為左，F為右
                      textColor: Colors.white,
                    );

                  }
                })
              //child: Center(child: MyButton( color: Colors.deepPurple, textColor:Colors.white , buttonText: '0',),
              ),
            ),
        ],
      ),
    );
  }

  bool isOperator(String x)
  {
    if(x == '/' || x == 'x' || x == '-' || x == '+' || x == '='){
      return true;
    }
    return false;
  }
}
