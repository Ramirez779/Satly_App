import './quiz_categories/basico_quiz.dart';
import './quiz_categories/intermedio_quiz.dart';
import './quiz_categories/avanzado_quiz.dart';
import './quiz_categories/lightning_quiz.dart';

class QuizCategoriesList {
  static final List<Map<String, dynamic>> categories = [
    BasicoQuiz.category,
    IntermedioQuiz.category,
    AvanzadoQuiz.category,
    LightningQuiz.category,
  ];

  static final Map<String, List<Map<String, dynamic>>> questionsByCategory = {
    'basico': BasicoQuiz.category['questions'] ?? [],
    'intermedio': IntermedioQuiz.category['questions'] ?? [],
    'avanzado': AvanzadoQuiz.category['questions'] ?? [],
    'lightning': LightningQuiz.category['questions'] ?? [],
  };
}
