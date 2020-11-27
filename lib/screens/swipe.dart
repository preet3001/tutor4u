import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'MatchCard.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Card Stack')
    );
  }
}
class MyHomePage extends StatefulWidget{
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyPageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{
  List<Widget> cardList;
  void removeCard(){
    setState(() {
    });
  }  @override void initState(){super.initState();}
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(Widget.title),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: _getMatchCard(),
        )
      )
    )
  }
  List<Widget> _getMatchCard() {
    List<MatchCard> cards = new List();
    cards.add(MatchCard(255, 0, 0, 10));
    cards.add(MatchCard(0, 255, 0, 20));
    cards.add(MatchCard(0, 0, 255, 30));
    List<Widget> cardList = new List();
    for (int x = 0; x < 3; x++) {
      cardList.add(Positioned(
        top:cards[x].margin,
        child: Draggable(
          onDragCompleted: (

              ){

          },
          childWhenDragging: Container(),
          feedback: Card(
            elevation: 12,
            color: Color.fromARGB(255, cards[x].redColor, cards[x].greenColor, cards[x].blueColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: 240,
              height: 300,
            ),
          ),
          child: Card(
            elevation: 12,
            color: Color.fromARGB(255, cards[x].redColor, cards[x].greenColor, cards[x].blueColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: 240,
              height: 300,
            ),
          ),
        ),
      )
      );
      return cardList;
    }
}