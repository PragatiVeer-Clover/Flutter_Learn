import 'Question.dart';

class Quizbrain {
  int _questionNumber = 0;

  final List<Question> _questionBank = [
    Question('Water freezes at zero degrees Celsius.', true),
    Question('The Earth is the closest planet to the Sun.', false),
    Question('The Atlantic Ocean is the largest ocean on Earth.', false),
    Question('A leap year has 366 days.', true),
    Question('Sound travels faster in air than in water.', false),
    Question('The Sahara is the largest desert in the world.', false),
    Question('Humans have five senses.', false),
    Question('Mount Everest is the tallest mountain in the world.', true),
    Question('Gold is a magnetic metal.', false),
    Question('The human heart has four chambers.', true)
  ];

  String getQuestionText(){
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer(){
    return _questionBank[_questionNumber].questionAnswer;
  }

  void nextQuestion(){
   if(_questionNumber < _questionBank.length - 1){
     _questionNumber++;
   }
  }

  bool isFinished(){
    if(_questionNumber == _questionBank.length - 1){
      return true;
    }else{
      return false;
    }
  }

  void reset() {
  _questionNumber = 0;
}
}
