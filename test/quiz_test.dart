import 'package:my_first_project/domain/quiz.dart';
import 'package:test/test.dart';
main() {
  // Create 2 questions and the quiz
  Question q1 =
      Question(title: "2+2", choices: ["1", "2", "4"], goodChoice: "4");

  Question q2 =
      Question(title: "2+3", choices: ["1", "2", "5"], goodChoice: "5");

  Quiz quiz = Quiz(questions: [q1, q2]);

  test('All answers are good (100%)', () {
    // Create the answer here
    Answer a1 = Answer(question: q1, answerChoice: "4", playerId: 1);
    Answer a2 = Answer(question: q2, answerChoice: "5", playerId: 1);

    quiz.answers = [a1, a2];

    // Check something
    expect(quiz.getScoreInPercentage(1), equals(100));
  });
 // Create 2 questions and the quiz
  Question q3 =
      Question(title: "Animal", choices: ["Lion", "Door", "Airplane"], goodChoice: "Lion");

  Question q4 =
      Question(title: "Number", choices: ["1", "Hello", "Hi"], goodChoice: "1");

  Quiz quizs = Quiz(questions: [q3, q4]);

  test('Some answers are wrong', () {
    // Create the answer here
    Answer a3 = Answer(question: q3, answerChoice: "Door", playerId: 1);
    Answer a4 = Answer(question: q4, answerChoice: "1", playerId: 1);

    quizs.answers = [a3, a4];

    // Check something
    expect(quizs.getScoreInPercentage(1), equals(50));
  });
   // Create 2 questions and the quiz
  Question q5 =
      Question(title: "2-2", choices: ["1", "2", "0"], goodChoice: "0");

  Question q6 =
      Question(title: "2+3", choices: ["1", "2", "5"], goodChoice: "5");

  Quiz quizss = Quiz(questions: [q5, q6]);

  test('All wrong answers', () {
    // Create the answer here
    Answer a5 = Answer(question: q5, answerChoice: "4", playerId: 1);
    Answer a6 = Answer(question: q6, answerChoice: "1", playerId: 1);

    quizss.answers = [a5, a6];

    // Check something
    expect(quizss.getScoreInPercentage(1), equals(0));
  });
}