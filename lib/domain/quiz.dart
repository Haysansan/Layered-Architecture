class Question{
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int point;

  Question({required this.title, required this.choices, required this.goodChoice, this.point =1});
}

class Answer{
  final Question question;
  final String answerChoice;
  final int playerId;
  

  Answer({required this.question, required this.answerChoice, required this.playerId});

  bool isGood(){
    return this.answerChoice == question.goodChoice;
  }
}

class Player {
  final String playerName;
  final int playerId;

  Player({required this.playerName, required this.playerId});
}


class Quiz{
  List<Question> questions;
  List<Answer> answers =[];
  List<Player> players =[];

  Quiz({required this.questions});

  void addPlayer(Player player) {
    players.removeWhere((p) => p.playerId == player.playerId);
    players.add(player);
  }

  void addAnswer(Answer asnwer) {
     this.answers.add(asnwer);
  }
  
    int getScoreInPoints(int playerId){
    int totalScore = 0;
    for (var ans in answers.where((a) => a.playerId == playerId)) { 
      if (ans.isGood()) {
      totalScore += ans.question.point;
      }
    }
    return totalScore;
    }
  int getScoreInPercentage(int playerId){
    int totalScore =0;
    for (var ans in answers.where((a) => a.playerId == playerId)) {
      if (ans.isGood()) {
      totalScore += ans.question.point;
      }
    }
    return ((totalScore/ questions.length)*100).toInt();

  }
}