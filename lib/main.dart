import 'package:flutter/material.dart';
import 'package:quizzler/quizbarin.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Quiz App')),
        ),
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> ScoreKeeper = [];

  QuizBrain quiz = QuizBrain();

  void checkAnswer(bool check){

    setState(() {
    bool iscorrect = quiz.getAnswer();
    if(iscorrect == check){
      ScoreKeeper.add(Icon(Icons.check,color: Colors.green,),);
    }else{
      ScoreKeeper.add(Icon(Icons.close,color: Colors.red,),);
    }
      quiz.nextQuestion();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quiz.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Caladea',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true
                checkAnswer(true);
                if(quiz.isFinished() == true){
                  Alert(context: context,title: 'Finished', desc: 'you have reached at the end of the question').show();
                  quiz.setQuestionNumber();
                  ScoreKeeper.clear();

                }
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
                if(quiz.isFinished() == true){
                  print('hello');
                  Alert(context: context,title: 'Finished', desc: 'you have reached at the end of the question').show();
                }
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: ScoreKeeper,
        ),
      ],
    );
  }
}

/*

question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,

*/
