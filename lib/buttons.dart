import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{

  final color;
  final textColor;
  final String buttonText;

  MyButton({this.color , this.textColor , required this.buttonText});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(50), //平滑直角
          child:Container(
            color: color,
            child: Center(child: Text(buttonText,style: TextStyle(color: textColor),),)
          ),
      ),
    );
  }
}