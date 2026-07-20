
      import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(SixHitApp());
}
class SixHitApp extends StatelessWidget {
  @override Widget build(BuildContext c){return MaterialApp(debugShowCheckedModeBanner:false,home:GameScreen());}
}
class GameScreen extends StatefulWidget {
  @override _GameScreenState createState()=>_GameScreenState();
}
class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late AnimationController con;
  double ballY=0; bool bowling=false, canHit=false;
  int score=0,sixes=0,balls=0; String msg="REAL EARNING ADS ON! BOWL dabao!";
  double batAngle=0; BannerAd? banner; InterstitialAd? interAd;
  @override void initState(){
    super.initState();
    con=AnimationController(vsync:this,duration:Duration(milliseconds:1000));
    con.addListener((){
      setState((){
        ballY=con.value*380;
        canHit=ballY>220 && ballY<300;
      });
      if(con.isCompleted && bowling){ setState((){msg="DOT Ball"; balls++; bowling=false; checkAd();});}
    });
    banner=BannerAd(adUnitId:'ca-app-pub-8618493376314684/8594326372',size:AdSize.banner,request:AdRequest(),listener:BannerAdListener())..load();
    loadInter();
  }
  void loadInter(){
    InterstitialAd.load(adUnitId:'ca-app-pub-8618493376314684/8506696461',request:AdRequest(),adLoadCallback:InterstitialAdLoadCallback(onAdLoaded:(ad){interAd=ad;},onAdFailedToLoad:(e){}));
  }
  void checkAd(){ if(balls%5==0 && balls!=0){interAd?.show(); loadInter();}}
  void bowl(){ if(bowling) return; setState((){bowling=true; msg="Ball aa raha hai..."; ballY=0; batAngle=0;}); con.reset(); con.forward();}
  void hit(){
    if(!bowling){setState((){msg="Pehle BOWL!";}); return;}
    setState((){batAngle=-1.2;}); Future.delayed(Duration(milliseconds:200),(){setState((){batAngle=0;});});
    if(canHit){
      con.stop();
      setState((){score+=6; sixes++; balls++; msg="SIXXXX! 💰 Earning!"; bowling=false;}); checkAd();
    } else { if(ballY>320){con.stop(); setState((){msg="OUT! 😭"; balls++; bowling=false;}); checkAd();}}
  }
  @override Widget build(BuildContext context){
    return Scaffold(backgroundColor:Color(0xFF1B5E20),appBar:AppBar(title:Text("Six Hit Challenge 💰 REAL ADS"),backgroundColor:Colors.green[900]),
      body:Column(children:[
        Container(margin:EdgeInsets.all(10),padding:EdgeInsets.all(14),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(12)),child:Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[
          Column(children:[Text("SCORE"),Text("$score",style:TextStyle(fontSize:24,fontWeight:FontWeight.bold))]),
          Column(children:[Text("SIXES",style:TextStyle(color:Colors.orange)),Text("$sixes",style:TextStyle(fontSize:24,color:Colors.orange))]),
          Column(children:[Text("BALLS"),Text("$balls",style:TextStyle(fontSize:24))]),
        ])),
        Container(padding:EdgeInsets.all(8),decoration:BoxDecoration(color:Colors.amber,borderRadius:BorderRadius.circular(20)),child:Text(msg,style:TextStyle(fontWeight:FontWeight.bold))),
        Expanded(child:Stack(alignment:Alignment.center,children:[
          Container(width:110,height:double.infinity,color:Color(0xFFBC9C7A)),
          Positioned(top:10,child:Text("🎳",style:TextStyle(fontSize:35))),
          Positioned(top:50+ballY,child:Container(width:32,height:32,decoration:BoxDecoration(color:canHit?Colors.yellow:Colors.red,shape:BoxShape.circle,border:Border.all(color:Colors.white,width:3)),child:Icon(Icons.sports_cricket,size:18,color:Colors.white))),
          Positioned(bottom:60,child:Transform.rotate(angle:batAngle,child:Text("🏏",style:TextStyle(fontSize:70)))),
          if(canHit) Positioned(bottom:150,child:Container(padding:EdgeInsets.all(6),decoration:BoxDecoration(color:Colors.greenAccent,borderRadius:BorderRadius.circular(10)),child:Text("HIT NOW!!!"))),
        ])),
        Row(children:[
          Expanded(child:ElevatedButton(onPressed:bowl,style:ElevatedButton.styleFrom(backgroundColor:Colors.blue,padding:EdgeInsets.symmetric(vertical:16)),child:Text("BOWL 🎳",style:TextStyle(color:Colors.white)))),
          SizedBox(width:10),
          Expanded(child:ElevatedButton(onPressed:hit,style:ElevatedButton.styleFrom(backgroundColor:Colors.red,padding:EdgeInsets.symmetric(vertical:16)),child:Text("HIT SIX! 💥",style:TextStyle(color:Colors.white)))),
        ]),
        if(banner!=null) Container(height:50,child:AdWidget(ad:banner!)),
      ]),
    );
  }
}
    
  

    
  

