import 'package:flutter/material.dart';
import 'QuizBrain.dart';

class Quizpage extends StatefulWidget {
  const Quizpage({super.key});

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  Quizbrain quizebrain = Quizbrain();
  List<Icon> scoreKeeper = [];
  int correctAnswerCount = 0;

  void checkAnswer(bool answer) {
    bool correctAnswer = quizebrain.getCorrectAnswer();

    setState(() {
      if (correctAnswer == answer) {
        scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        correctAnswerCount++;
      } else {
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }

      if (quizebrain.isFinished() == true) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text('Quiz Completed!'),
            content: Text(
              'You answered $correctAnswerCount out of ${scoreKeeper.length} questions correctly.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    quizebrain = Quizbrain();
                    scoreKeeper.clear();
                    correctAnswerCount = 0;
                  });
                },
                child: Text('Restart Quiz'),
              ),
            ],
          ),
        );
      } else {
        quizebrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 700),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header
            Text(
              'Quiz Time 🧠',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 40),

            // Question Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),

              child: Text(
                quizebrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  height: 1.6,
                ),
              ),
            ),
            SizedBox(height: 30),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: _answerButton(
                    'True',
                    const Color.fromRGBO(105, 240, 174, 1),
                    Colors.black,
                    () {
                      checkAnswer(true);
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _answerButton(
                    'False',
                    const Color.fromRGBO(255, 82, 82, 1),
                    Colors.white,
                    () {
                      checkAnswer(false);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Score Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [...scoreKeeper],
            ),
          ],
        ),
      ),
    );
  }

  Widget _answerButton(
    String label,
    Color bg,
    Color fg,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        padding: EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
