
      import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(SixHitApp());

class SixHitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: GameScreen());
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late AnimationController c;
  double ballY=0; bool bowling=false, canHit=false;
  int score=0,sixes=0,balls=0; String msg="Tap BOWL to start!";

  @override
  void initState(){
    super.initState();
    c=AnimationController(vsync:this,duration:Duration(milliseconds:900));
    c.addListener((){
      setState((){
        ballY=c.value*350;
        canHit=ballY>200 && ballY<280;
      });
      if(c.isCompleted){
        setState((){
          if(!msg.contains("SIX") &&!msg.contains("OUT")){
            msg="Miss! DOT Ball"; balls++; bowling=false;
          }
        });
      }
    });
  }

  void bowl(){
    if(bowling) return;
    setState((){bowling=true; msg="HIT NOW! 💥"; ballY=0;});
    c.reset(); c.forward();
  }

  void hit(){
    if(!bowling) return;
    c.stop();
    if(canHit){
      setState((){
        score+=6; sixes++; balls++;
        msg="SIX! 🏏💥 What a Shot!"; bowling=false;
      });
    } else {
      setState((){
        msg="OUT! 😭 Wrong Timing!"; bowling=false; balls++;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Color(0xFF1B5E20),
      appBar:AppBar(title:Text("Six Hit Challenge 🏏"),backgroundColor:Colors.green[900],centerTitle:true),
      body:Column(children:[
        Container(margin:EdgeInsets.all(12),padding:EdgeInsets.all(16),
          decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(15)),
          child:Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[
            Column(children:[Text("SCORE"),Text("$score",style:TextStyle(fontSize:26,fontWeight:FontWeight.bold))]),
            Column(children:[Text("SIXES"),Text("$sixes",style:TextStyle(fontSize:26,fontWeight:FontWeight.bold,color:Colors.orange))]),
            Column(children:[Text("BALLS"),Text("$balls",style:TextStyle(fontSize:26,fontWeight:FontWeight.bold))]),
          ]),
        ),
        Container(padding:EdgeInsets.all(8),decoration:BoxDecoration(color:Colors.amber,borderRadius:BorderRadius.circular(20)),
          child:Text(msg,style:TextStyle(fontWeight:FontWeight.bold))),
        Expanded(child:Stack(alignment:Alignment.center,children:[
          Container(width:100,height:double.infinity,color:Colors.brown[300]),
          Positioned(top:20,child:Text("🎳",style:TextStyle(fontSize:40))),
          Positioned(top:60+ballY,child:Container(width:28,height:28,decoration:BoxDecoration(color:Colors.red,shape:BoxShape.circle,border:Border.all(color:Colors.white,width:2)))),
          Positioned(bottom:80,child:Text("🏏",style:TextStyle(fontSize:60))),
        ])),
        Padding(padding:EdgeInsets.all(16),child:Row(children:[
          Expanded(child:ElevatedButton(onPressed:bowl,style:ElevatedButton.styleFrom(backgroundColor:Colors.blue,padding:EdgeInsets.symmetric(vertical:18)),child:Text("BOWL 🎳",style:TextStyle(fontSize:18,fontWeight:FontWeight.bold,color:Colors.white)))),
          SizedBox(width:12),
          Expanded(child:ElevatedButton(onPressed:hit,style:ElevatedButton.styleFrom(backgroundColor:canHit?Colors.orange:Colors.red,padding:EdgeInsets.symmetric(vertical:18)),child:Text("HIT SIX! 💥",style:TextStyle(fontSize:18,fontWeight:FontWeight.bold,color:Colors.white)))),
        ])),
        TextButton(onPressed:(){setState((){score=0;sixes=0;balls=0;msg="Tap BOWL to start!";});},child:Text("Reset",style:TextStyle(color:Colors.white70))),
      ]),
    );
  }
}
    
  

