import 'package:flutter/material.dart';
import 'package:flutter_quiz/pages/landing_page.dart';

class ScorePage extends StatelessWidget {

  final int _score;
  final int _totalQuestions;

  ScorePage(this._score, this._totalQuestions);

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blueAccent,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Your Score is",
            style: new TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              fontWeight: FontWeight.bold
            ),
          ),
          new Text(
            "$_score out of $_totalQuestions",
            style: new TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.bold
            )
          ),
          new Padding(
            padding: new EdgeInsets.only(bottom: 50.0)
          ),
          new Container(
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              border: new Border.all(color: Colors.white, width: 5.0)
            ),
            child: new IconButton(
                icon: new Icon(Icons.chevron_right),
                color: Colors.white,
                iconSize: 50.0,
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    new MaterialPageRoute(
                        builder: (context) => new LandingPage()
                    )
                    ,(route) => route == null
                )
            ),
          )
        ],
      ),
    );
  }

}