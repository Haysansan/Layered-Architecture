import 'package:uuid/uuid.dart';
var uuid = Uuid();

class Question{
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int point;

  Question({required this.title, required this.choices, required this.goodChoice, this.point =1, String? id})
      : id = id ?? uuid.v4();
}

class Answer{
  final String id;
  final String questionId;
  final String answerChoice;
  final int playerId;
  

  Answer({required this.questionId, required this.answerChoice, required this.playerId, String? id}) : id = id ?? uuid.v4();

  bool isGood(Question question) {
    return this.answerChoice == question.goodChoice;
  }
}

class Player {
  final String playerName;
  final int playerId;

  Player({required this.playerName, required this.playerId});
}


class Quiz{
  final String id;
  List<Question> questions;
  List<Answer> answers =[];
  List<Player> players =[];

  Quiz({required this.questions, String? id}) : id = id ?? uuid.v4();

  void addPlayer(Player player) {
    players.removeWhere((p) => p.playerId == player.playerId);
    players.add(player);
  }

  void addAnswer(Answer asnwer) {
     this.answers.add(asnwer);
  }

    Question? getQuestionById(String qId) {
    return questions.firstWhere((q) => q.id == qId);
  }

  Answer? getAnswerById(String aId) {
    return answers.firstWhere((a) => a.id == aId);
  }
  
    int getScoreInPoints(int playerId){
    int totalScore = 0;
    for (var ans in answers.where((a) => a.playerId == playerId)) { 
      var question = getQuestionById(ans.questionId);
      if (question != null && ans.isGood(question)) {
      totalScore += question.point;
      }
    }
    return totalScore;
    }
  int getScoreInPercentage(int playerId){
    int totalScore =0;
    for (var ans in answers.where((a) => a.playerId == playerId)) {
     var question = getQuestionById(ans.questionId);
      if (question != null && ans.isGood(question)) {
      totalScore += question.point;
      }
    }
    return ((totalScore/ questions.length)*100).toInt();

  }
}