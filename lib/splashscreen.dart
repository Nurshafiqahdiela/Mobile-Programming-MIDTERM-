import 'package:flutter/material.dart';
import 'package:visitmalaysia/mainscreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double screenHeight;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.brown,
      ),
      title: 'Material App',
      home: Scaffold(
          body: Container(
        child: Stack(
          children: <Widget>[
            Container(
               margin: EdgeInsets.only(top: 0 ),
      
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/main.jpg'),
                        fit: BoxFit.fill))),
             
            Container(height: 1500, child: ProgressIndicator()),
          ], 
      )),
    ));
  }
}

class ProgressIndicator extends StatefulWidget {
  @override
  _ProgressIndicatorState createState() => new _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          //updating states
          if (animation.value > 0.99) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Mainscreen()));
          }
        });

      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      
    child: 
      new Container(
         
         //width: 300,
         //color: Colors.redAccent, 
         child: CircularProgressIndicator(
          
        value: animation.value,
        backgroundColor: Colors.brown,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.yellowAccent),

         ),
         
      ),
      
    );
        
    
    
        
  }
}