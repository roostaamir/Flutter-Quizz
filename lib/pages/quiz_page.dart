import 'package:flutter/material.dart';

import 'package:flutter_quiz/utils/question.dart';
import 'package:flutter_quiz/utils/quiz.dart';
import 'package:flutter_quiz/ui/answer_button.dart';
import 'package:flutter_quiz/ui/question_text.dart';
import 'package:flutter_quiz/ui/corret_wrong_overlay.dart';

import 'package:flutter_quiz/pages/score_page.dart';


class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Elon Musk is Human", false),
    new Question("Pizza is healthy", false),
    new Question("Flutter is awesome", true),
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = currentQuestion.answer == answer;
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column( //main page container
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false)),
          ],
        ),
        overlayShouldBeVisible ? new CorrectWrongOverlay(
          isCorrect, () {
            if (quiz.length == questionNumber) {
              Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(
                  builder: (context) => new ScorePage(quiz.score, quiz.length)
                )
                ,(route) => route == null
              );
            }
            currentQuestion = quiz.nextQuestion;
            this.setState(() {
              overlayShouldBeVisible = false;
              questionText = currentQuestion.question;
              questionNumber = quiz.questionNumber;
            });
          }
        ) : new Container() //not the best solution
      ],
    );
  }

}