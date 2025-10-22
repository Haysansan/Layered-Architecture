import 'dart:convert';
import 'dart:io';
import '../domain/quiz.dart';

class QuizFileProvider {
  final String filePath;
  QuizFileProvider(this.filePath);

  /// Read a Quiz from JSON file
  Quiz readQuiz() {
    final file = File(filePath);
    final content = file.readAsStringSync();
    final data = jsonDecode(content);

    // Read Questions
    var questionsJson = data['questions'] as List;
    var questions = questionsJson.map((q) {
      return Question(
        id: q['id'],
        title: q['title'],
        choices: List<String>.from(q['choices']),
        goodChoice: q['goodChoice'],
        point: q['point'],
      );
    }).toList();

    // Read Answers (if any submissions exist)
    var answersJson = data['answers'] as List? ?? [];
    var answers = answersJson.map((a) {
      return Answer(
        id: a['id'],
        playerId: a['playerId'],
        questionId: a['questionId'],
        answerChoice: a['answerChoice'],
      );
    }).toList();

    return Quiz(questions: questions)..answers.addAll(answers);
  }

  /// Write a Quiz to JSON file
  void writeQuiz(Quiz quiz) {
    final data = {
      'questions': quiz.questions.map((q) => {
        'id': q.id,
        'title': q.title,
        'choices': q.choices,
        'goodChoice': q.goodChoice,
        'point': q.point,
      }).toList(),
      'answers': quiz.answers.map((a) => {
        'id': a.id,
        'playerId': a.playerId,
        'questionId': a.questionId,
        'answerChoice': a.answerChoice,
      }).toList(),
    };

    File(filePath).writeAsStringSync(jsonEncode(data));
  }
}