import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');

    int playerCounter = 1;
    List<Player> allPlayers = [];

    while (true) {
      stdout.write('Enter player name: ');
      String? playerName = stdin.readLineSync();
      if (playerName == null || playerName.isEmpty) break;

      Player player = Player(playerName: playerName, playerId: playerCounter++);
      quiz.addPlayer(player);
      quiz.answers.removeWhere((a) => a.playerId == player.playerId);
      allPlayers.add(player);

    for (var question in quiz.questions) {
      print('Question: ${question.title} - (${question.point} point)');
      print('Choices: ${question.choices}');
      stdout.write('Your answer: ');
      String? userInput = stdin.readLineSync();

      // Check for null input
      if (userInput != null && userInput.isNotEmpty) {
        Answer answer = Answer(question: question, answerChoice: userInput, playerId: player.playerId);
        quiz.addAnswer(answer);
      } else {
        print('No answer entered. Skipping question.');
      }

      print('');
    }
    

    int score = quiz.getScoreInPercentage(player.playerId);
    int scores = quiz.getScoreInPoints(player.playerId);
    print('--- Quiz Finished ${player.playerName}---');
    print('Your score: $score % correct');
    print('Your score: $scores points');
    print('');
  
    print('=== All Players Scores ===');
    for (var p in allPlayers) {
      int scorePercent = quiz.getScoreInPercentage(p.playerId);
      int scorePoints = quiz.getScoreInPoints(p.playerId);
      print('--- Quiz Finished ${p.playerName}---');
      print('Your score: $scorePercent % correct');
      print('Your score: $scorePoints points');
      print('');
    } 
   }
  }
}
 