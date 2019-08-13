import 'package:flutter/material.dart';
import 'package:sendhappiness/pages/HomePage.dart';
import 'package:sendhappiness/pages/LoginPage.dart';

void main() async{

  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Happiness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor:Colors.deepOrange,

        // Define the default font family.
        //fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),

      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        //"/singup":(BuildContext context) =>SingUp(),
        "/LoginPage":(BuildContext context) =>LoginPage(),

      },
    );
  }
}


sendsms(){
}
