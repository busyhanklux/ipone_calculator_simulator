import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(child,
          maxWidth: 480,
          minWidth: 165,
          defaultName: MOBILE,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(360), //解決
            ResponsiveBreakpoint.resize(600, name: MOBILE),
            ResponsiveBreakpoint.autoScale(120, name: TABLET),
            ResponsiveBreakpoint.autoScale(120, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      initialRoute: "/",
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
  var userInput = '';
  var userAnswer = '0';
  var Isafterequal = 0; //按下等號，使其能夠連續計算
  var Isafternumber = '';

  final List<String> buttons = [
    'C', '<=', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '00', '0', '.', '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, //背景色(最底色)
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2, //藉由調整此，來控制上下比例
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, //均分空間
                children: <Widget>[
                  SizedBox(height: 50,),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userInput, style: TextStyle(fontSize: 40 , color: Colors.white),),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer, style: TextStyle(fontSize: 50 , color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              //color:Colors.deepPurple,), //在背景色上層一層，位於計算輸入按鈕處
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, ), //每排的數量
                  itemBuilder: (BuildContext Context, int index) {
                    if ((index - 3) < 0) {
                      // -3 <0 指前三個

                      if (index == 0) { //C
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userInput = '';
                              userAnswer = '0';
                              Isafterequal = 0;
                              Isafternumber = '';
                            });
                          },
                          buttonText: buttons[index], //按照有多少的button陣列元素，依序排列(每排4個)
                          color: Colors.grey,
                          textColor: Colors.white,
                        );
                      } else if (index == 1) {
                        return MyButton(
                          //<=
                          buttonTapped: () {
                            setState(() {
                              userInput = userInput.substring(0, userInput.length - 1);
                            });
                          },
                          buttonText: buttons[index], //按照有多少的button陣列元素，依序排列(每排4個)
                          color: Colors.grey,
                          textColor: Colors.white,
                        );
                      } else {
                        return MyButton(
                          //%
                          buttonTapped: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                          buttonText: buttons[index], //按照有多少的button陣列元素，依序排列(每排4個)
                          color: Colors.grey,
                          textColor: Colors.white,
                        );
                      }
                    }
                    else if (index == (buttons.length - 1)) //等號
                    {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index], //按照有多少的button陣列元素，依序排列(每排4個)
                        color: Colors.orange,
                        textColor: Colors.white,
                      );
                    }
                    else if (index == (buttons.length - 4)) // 00
                    {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index], //按照有多少的button陣列元素，依序排列(每排4個)
                        color: Colors.white24,
                        textColor: Colors.white,
                      );
                    }
                    else if (index == 15) // +
                    {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            if(Isafterequal == 1) {
                                userInput = Isafternumber + buttons[index];
                                Isafterequal = 0;
                                Isafternumber = '';
                              }
                            else
                            {
                              if(userInput.isNotEmpty){ //是不是空的
                                if(userInput.length >= 2) {
                                  if(userInput.substring((userInput.length - 2),userInput.length) == '+-'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '++'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '+x'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '+/'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '-+'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '--'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '-x'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '-/'
                                      || userInput.substring((userInput.length - 2),userInput.length) == 'x+'
                                      || userInput.substring((userInput.length - 2),userInput.length) == 'x-'
                                      || userInput.substring((userInput.length - 2),userInput.length) == 'xx'
                                      || userInput.substring((userInput.length - 2),userInput.length) == 'x/'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '/+'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '/-'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '/x'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '//'
                                  )
                                  {
                                    userInput = userInput.substring(0,userInput.length - 2) + buttons[index];
                                  }
                                  else if(userInput.substring((userInput.length - 1),userInput.length) == '+'
                                      || userInput.substring((userInput.length - 1),userInput.length) == '-'
                                      || userInput.substring((userInput.length - 1),userInput.length) == 'x'
                                      || userInput.substring((userInput.length - 1),userInput.length) == '/'
                                  )
                                  {
                                    userInput = userInput.substring(0,userInput.length - 1) + buttons[index];
                                  }
                                  else
                                  {
                                    userInput += buttons[index];
                                  }
                                }
                                else if(userInput.substring((userInput.length - 1),userInput.length) == '+'
                                    || userInput.substring((userInput.length - 1),userInput.length) == '-'
                                    || userInput.substring((userInput.length - 1),userInput.length) == 'x'
                                    || userInput.substring((userInput.length - 1),userInput.length) == '/'
                                )
                                {
                                  userInput = userInput.substring(0,userInput.length - 1) + buttons[index];
                                }
                                else
                                {
                                  userInput += buttons[index];
                                }
                              }
                              else //空的話就 0 + 數字
                              {
                                userInput = '0' + buttons[index];
                              }
                            }
                          });
                        },
                        buttonText: buttons[index], //按照有多少的button陣列元素，依序排列(每排4個)
                        color: Colors.orange,
                        textColor: Colors.white,
                      );
                    }
                    else if (index == 11) // -
                        {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            if(Isafterequal == 1)
                            {
                              userInput = Isafternumber + buttons[index];
                              Isafterequal = 0;
                              Isafternumber = '';
                            }
                            else
                            {
                              if(userInput.isNotEmpty) {
                                  if(userInput.length >= 2) {
                                    if(userInput.substring((userInput.length - 2),userInput.length) == '+-'
                                        || userInput.substring((userInput.length - 2),userInput.length) == '++'
                                        || userInput.substring((userInput.length - 2),userInput.length) == '+x'
                                        || userInput.substring((userInput.length - 2),userInput.length) == '+/'
                                        || userInput.substring((userInput.length - 2),userInput.length) == '-+'
                                        || userInput.substring((userInput.length - 2),userInput.length) == '--'
                                        || userInput.substring((userInput.length - 2),userInput.length) == '-x'
                                        || userInput.substring((userInput.length - 2),userInput.length) == '-/'
                                        || userInput.substring((userInput.length - 2),userInput.length) == 'x+'
                                        || userInput.substring((userInput.length - 2),userInput.length) == 'x-'
                                        || userInput.substring((userInput.length - 2),userInput.length) == 'xx'
                                        || userInput.substring((userInput.length - 2),userInput.length) == 'x/'
                                        || userInput.substring((userInput.length - 2),userInput.length) == '/+'
                                        || userInput.substring((userInput.length - 2),userInput.length) == '/-'
                                        || userInput.substring((userInput.length - 2),userInput.length) == '/x'
                                        || userInput.substring((userInput.length - 2),userInput.length) == '//'
                                    )
                                      {
                                        userInput = userInput;
                                      }
                                  else
                                  {
                                    userInput += buttons[index];
                                  }
                                  }
                                  else if(userInput.substring((userInput.length - 1),userInput.length) == '+'
                                      || userInput.substring((userInput.length - 1),userInput.length) == 'x'
                                      || userInput.substring((userInput.length - 1),userInput.length) == '/'
                                  )
                                  {
                                    userInput = userInput.substring(0,userInput.length - 1) + buttons[index];
                                  }
                                  else
                                  {
                                    userInput += buttons[index];
                                  }
                                }
                              else //空的話就 0 - 數字
                                {
                                  userInput = '0' + buttons[index];
                                }
                            }
                          });
                        },
                        buttonText: buttons[index], //按照有多少的button陣列元素，依序排列(每排4個)
                        color: Colors.orange,
                        textColor: Colors.white,
                      );
                    }
                    else if (index == 7) // x
                        {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            if(Isafterequal == 1)
                            {
                              userInput = Isafternumber + buttons[index];
                              Isafterequal = 0;
                              Isafternumber = '';
                            }
                            else
                            {
                              if(userInput.isNotEmpty){ //是不是空的
                                if(userInput.length >= 2) {
                                  if(userInput.substring((userInput.length - 2),userInput.length) == '+-'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '++'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '+x'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '+/'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '-+'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '--'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '-x'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '-/'
                                      || userInput.substring((userInput.length - 2),userInput.length) == 'x+'
                                      || userInput.substring((userInput.length - 2),userInput.length) == 'x-'
                                      || userInput.substring((userInput.length - 2),userInput.length) == 'xx'
                                      || userInput.substring((userInput.length - 2),userInput.length) == 'x/'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '/+'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '/-'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '/x'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '//'
                                  )
                                  {
                                    userInput = userInput.substring(0,userInput.length - 2) + buttons[index];
                                  }
                                  else if(userInput.substring((userInput.length - 1),userInput.length) == '+'
                                      || userInput.substring((userInput.length - 1),userInput.length) == '-'
                                      || userInput.substring((userInput.length - 1),userInput.length) == 'x'
                                      || userInput.substring((userInput.length - 1),userInput.length) == '/'
                                  )
                                  {
                                    userInput = userInput.substring(0,userInput.length - 1) + buttons[index];
                                  }
                                  else
                                  {
                                    userInput += buttons[index];
                                  }
                                }
                                else if(userInput.substring((userInput.length - 1),userInput.length) == '+'
                                    || userInput.substring((userInput.length - 1),userInput.length) == '-'
                                    || userInput.substring((userInput.length - 1),userInput.length) == 'x'
                                    || userInput.substring((userInput.length - 1),userInput.length) == '/'
                                )
                                {
                                  userInput = userInput.substring(0,userInput.length - 1) + buttons[index];
                                }
                                else
                                {
                                  userInput += buttons[index];
                                }
                              }
                              else //空的話就 0 x 數字
                              {
                                userInput = '0' + buttons[index];
                              }
                            }
                          });
                        },
                        buttonText: buttons[index], //按照有多少的button陣列元素，依序排列(每排4個)
                        color: Colors.orange,
                        textColor: Colors.white,
                      );
                    }
                    else if (index == 3) // /
                        {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            if(Isafterequal == 1)
                            {
                              userInput = Isafternumber + buttons[index];
                              Isafterequal = 0;
                              Isafternumber = '';
                            }
                            else
                            {
                              if(userInput.isNotEmpty){ //是不是空的
                                if(userInput.length >= 2) {
                                  if(userInput.substring((userInput.length - 2),userInput.length) == '+-'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '++'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '+x'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '+/'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '-+'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '--'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '-x'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '-/'
                                      || userInput.substring((userInput.length - 2),userInput.length) == 'x+'
                                      || userInput.substring((userInput.length - 2),userInput.length) == 'x-'
                                      || userInput.substring((userInput.length - 2),userInput.length) == 'xx'
                                      || userInput.substring((userInput.length - 2),userInput.length) == 'x/'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '/+'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '/-'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '/x'
                                      || userInput.substring((userInput.length - 2),userInput.length) == '//'
                                  )
                                  {
                                    userInput = userInput.substring(0,userInput.length - 2) + buttons[index];
                                  }
                                  else if(userInput.substring((userInput.length - 1),userInput.length) == '+'
                                      || userInput.substring((userInput.length - 1),userInput.length) == '-'
                                      || userInput.substring((userInput.length - 1),userInput.length) == 'x'
                                      || userInput.substring((userInput.length - 1),userInput.length) == '/'
                                  )
                                  {
                                    userInput = userInput.substring(0,userInput.length - 1) + buttons[index];
                                  }
                                  else
                                  {
                                    userInput += buttons[index];
                                  }
                                }
                                if(userInput.substring((userInput.length - 1),userInput.length) == '+'
                                    || userInput.substring((userInput.length - 1),userInput.length) == '-'
                                    || userInput.substring((userInput.length - 1),userInput.length) == 'x'
                                    || userInput.substring((userInput.length - 1),userInput.length) == '/'
                                )
                                {
                                  userInput = userInput.substring(0,userInput.length - 1) + buttons[index];
                                }
                                else
                                {
                                  userInput += buttons[index];
                                }
                              }
                              else //空的話就 0 / 數字
                              {
                                userInput = '0' + buttons[index];
                              }
                            }
                          });
                        },
                        buttonText: buttons[index], //按照有多少的button陣列元素，依序排列(每排4個)
                        color: Colors.orange,
                        textColor: Colors.white,
                      );
                    }
                    else
                    {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            Isafterequal = 0;
                            Isafternumber = '';
                            userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index], //按照有多少的button陣列元素，依序排列(每排4個)
                        color: isOperator(buttons[index]) ? Colors.orange : Colors.white24, //是否為 isOperator 之文字? T為左，F為右
                        textColor: Colors.white,
                      );
                    }
                  }),
              //child: Center(child: MyButton( color: Colors.deepPurple, textColor:Colors.white , buttonText: '0',),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalInput = userInput;
    finalInput = finalInput.replaceAll('x', '*'); //替代符號(由左邊的x換成右邊的*)
    finalInput = finalInput.replaceAll('%', '*0.01');

    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toStringAsFixed(8);


    if (userAnswer == 'Infinity' || userAnswer == 'NaN') {
      userAnswer = 'Error';
      userInput = '';
    }

    if (userAnswer != 'Error') {

      //10億
      if (double.parse(userAnswer) >= 1000000000) {

        var TempuserAnswer = (double.parse(userAnswer) / 1000000000).toStringAsFixed(8);

        if (TempuserAnswer.substring(TempuserAnswer.length - 1, TempuserAnswer.length) == '0') //處理後，如果小數點後第八位是0
            {
          if (TempuserAnswer.substring(TempuserAnswer.length - 2, TempuserAnswer.length - 1) == '0') //處理後，如果小數點後第七位是0
              {
            if (TempuserAnswer.substring(TempuserAnswer.length - 3, TempuserAnswer.length - 2) == '0') //處理後，如果小數點後第六位是0
                {
              if (TempuserAnswer.substring(TempuserAnswer.length - 4, TempuserAnswer.length - 3) == '0') //處理後，如果小數點後第五位是0
                  {
                if (TempuserAnswer.substring(TempuserAnswer.length - 5, TempuserAnswer.length - 4) == '0') //處理後，如果小數點後第四位是0
                    {
                  if (TempuserAnswer.substring(TempuserAnswer.length - 6, TempuserAnswer.length - 5) == '0') //處理後，如果小數點後第三位是0
                      {
                    if (TempuserAnswer.substring(TempuserAnswer.length - 7, TempuserAnswer.length - 6) == '0') //處理後，如果小數點後第二位是0
                        {
                      if (TempuserAnswer.substring(TempuserAnswer.length - 8, TempuserAnswer.length - 7) == '0') //處理後，如果小數點後第一位是0
                          {
                        userAnswer = double.parse(TempuserAnswer).toStringAsFixed(0) + 'e9';
                      } else {userAnswer = double.parse(TempuserAnswer).toStringAsFixed(1) + 'e9';}
                    } else {userAnswer = double.parse(TempuserAnswer).toStringAsFixed(2) + 'e9';}
                  } else {userAnswer = double.parse(TempuserAnswer).toStringAsFixed(3) + 'e9';}
                } else {userAnswer = double.parse(TempuserAnswer).toStringAsFixed(4) + 'e9';}
              } else {userAnswer = double.parse(TempuserAnswer).toStringAsFixed(5) + 'e9';}
            } else {userAnswer = double.parse(TempuserAnswer).toStringAsFixed(6) + 'e9';}
          } else {userAnswer = double.parse(TempuserAnswer).toStringAsFixed(7) + 'e9';}
        }
      }
      else
      {
        if (userAnswer.substring(userAnswer.length - 1, userAnswer.length) == '0') //處理後，如果小數點後第八位是0
            {
          if (userAnswer.substring(userAnswer.length - 2, userAnswer.length - 1) == '0') //處理後，如果小數點後第七位是0
              {
            if (userAnswer.substring(userAnswer.length - 3, userAnswer.length - 2) == '0') //處理後，如果小數點後第六位是0
                {
              if (userAnswer.substring(userAnswer.length - 4, userAnswer.length - 3) == '0') //處理後，如果小數點後第五位是0
                  {
                if (userAnswer.substring(userAnswer.length - 5, userAnswer.length - 4) == '0') //處理後，如果小數點後第四位是0
                    {
                  if (userAnswer.substring(userAnswer.length - 6, userAnswer.length - 5) == '0') //處理後，如果小數點後第三位是0
                      {
                    if (userAnswer.substring(userAnswer.length - 7, userAnswer.length - 6) == '0') //處理後，如果小數點後第二位是0
                        {
                      if (userAnswer.substring(userAnswer.length - 8, userAnswer.length - 7) == '0') //處理後，如果小數點後第一位是0
                          {
                        userAnswer = eval.toStringAsFixed(0);
                      } else {userAnswer = eval.toStringAsFixed(1);}
                    } else {userAnswer = eval.toStringAsFixed(2);}
                  } else {userAnswer = eval.toStringAsFixed(3);}
                } else {userAnswer = eval.toStringAsFixed(4);}
              } else {userAnswer = eval.toStringAsFixed(5);}
            } else {userAnswer = eval.toStringAsFixed(6);}
          } else {userAnswer = eval.toStringAsFixed(7);}
        }
      }

      userInput = '';
      Isafterequal++;
      Isafternumber = userAnswer;
    }

  }
}
