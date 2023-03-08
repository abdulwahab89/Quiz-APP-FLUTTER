import 'package:flutter/material.dart';
import 'question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> icons = [];

  QuestionBank questionBank = QuestionBank();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    questionBank.getQuestion(),
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white.withOpacity(.7),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (questionBank.isFinished() == true) {
                            Alert(
                              context: context,
                              title: 'Questions Completed',
                            ).show();
                            icons.clear();
                            questionBank.reset();
                          } else {
                            checkAnswer(true);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        height: 50,
                        width: double.infinity,
                        color: Colors.green,
                        child: const Text(
                          'True',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (questionBank.isFinished() == true) {
                            icons.clear();
                            Alert(
                              context: context,
                              title: 'Questions Completed',
                            ).show();
                            questionBank.reset();
                            print('finished');
                          } else {
                            checkAnswer(false);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        width: double.infinity,
                        color: Colors.red,
                        child: const Text(
                          'False',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Row(
                        children: icons,
                      ),
                    )
                  ],
                ),
              )
            ]));
  }

  void checkAnswer(bool userAnswer) {
    bool answer = questionBank.getAnswer();
    if (userAnswer == answer) {
      icons.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      icons.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
    questionBank.nextQuestion();
  }
}
