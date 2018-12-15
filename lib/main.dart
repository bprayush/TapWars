import 'package:flutter/material.dart';

void main() => runApp(new TapWar());

class TapWar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Tap War",
      home: new Canvas(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Canvas extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new CanvasState();
  }
}

class CanvasState extends State<Canvas>{

  int player1Score = 0;
  int player2Score = 0;
  String winner1 = "";
  String winner2 = "";
  int timer = 10;
  bool timerStarted = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: _player1Update,
                    child: new Container(
                      alignment: Alignment.center,
                      height: 200.0,
                      decoration: new BoxDecoration(
                        color: Colors.red,
                      ),
                      child: new Text(
                        "Player 1",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                    ),
                  ),
                )
              ],
            ),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Text(player1Score.toString(), style: TextStyle(fontSize: 50.0)),
                    new Text("Player 1", style: TextStyle(fontSize: 20.0))
                  ],
                ),
                new Column(
                  children: <Widget>[
                    new Text(winner1, style: TextStyle(fontSize: 30.0, color: Colors.green)),
                    new Text(timer.toString(), style: TextStyle(fontSize: 50.0)),
                    new Text("Timer", style: TextStyle(fontSize: 20.0)),
                    GestureDetector(
                      onTap: countDownTimer,
                      child: new Container(
                        width: 100,
                        height: 40,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(10.0),
                          color: Colors.blue
                        ),
                        child: new Text("Start", style: TextStyle(color: Colors.white),),
                        alignment: Alignment.center,
                      ),
                    ),
                    new Text(winner2, style: TextStyle(fontSize: 30.0, color: Colors.green))
                  ],
                ),
                new Column(
                  children: <Widget>[
                    new Text(player2Score.toString(), style: TextStyle(fontSize: 50.0)),
                    new Text("Player 2", style: TextStyle(fontSize: 20.0))
                  ],
                )
              ],
            ),
            new Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: _player2Update,
                  child: new Container(
                    alignment: Alignment.center,
                    height: 200.0,
                    decoration: new BoxDecoration(
                      color: Colors.red,
                    ),
                    child: new Text(
                      "Player 2",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ),
                ),
              )
            ],
            ),
          ],
        ),
      )
    );
  }

  void _player1Update(){
    if( timerStarted )
    {
      setState(() {
        player1Score += 1;         
      });
    }
  }

  void _player2Update(){
    if( timerStarted )
    {
      setState(() {
        player2Score += 1;         
      });
    }
  }

  void _findWinner(){
    if( player1Score > player2Score )
    {
      setState(() {
        winner1 = "Player 1 wins!";
        winner2 = "";        
      });
    }
    else if( player1Score == player2Score )
    {
      setState(() {
        winner1 = "Draw!";
        winner2 = "Draw!";        
      });
    }
    else{
      setState(() {
        winner1 = "";
        winner2 = "Player 2 wins!";        
      });
    }
  }

  Future countDownTimer() async{
    if ( !timerStarted )
    {
      timerStarted = true;
      setState((){
        player1Score = 0;
        player2Score = 0;
        winner1 = "";
        winner2 = "";
      });
        
      for(int i=10; i>=0; i--)
      {
        setState(() {
          timer = i;        
        });
        await new Future.delayed(new Duration(seconds: 1));
      }
    }
    timerStarted = false;
    _findWinner();
  }

}