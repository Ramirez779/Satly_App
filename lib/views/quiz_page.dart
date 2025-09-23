import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;
  String? _selectedCategory;
  String? _selectedAnswer;
  bool _answerSubmitted = false;

  // Categorías de quizzes
  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'basico',
      'name': 'Básico',
      'color': Colors.green,
      'icon': Icons.school,
      'description': 'Conceptos fundamentales de Bitcoin',
      'reward': '10 SATS',
    },
    {
      'id': 'intermedio',
      'name': 'Intermedio',
      'color': Colors.orange,
      'icon': Icons.trending_up,
      'description': 'Temas más avanzados',
      'reward': '20 SATS',
    },
    {
      'id': 'avanzado',
      'name': 'Avanzado',
      'color': Colors.red,
      'icon': Icons.auto_awesome,
      'description': 'Para expertos en Bitcoin',
      'reward': '30 SATS',
    },
  ];

  // Preguntas por categoría
  final Map<String, List<Map<String, dynamic>>> _questionsByCategory = {
    'basico': [
      {
        'question': '¿Qué es Bitcoin?',
        'answers': [
          'Una criptomoneda descentralizada',
          'Una red social',
          'Un banco digital',
          'Un juego en línea',
        ],
        'correct': 0,
        'explanation':
            'Bitcoin es la primera criptomoneda descentralizada creada en 2009.',
      },
      {
        'question': '¿Quién creó Bitcoin?',
        'answers': [
          'Satoshi Nakamoto',
          'Vitalik Buterin',
          'Elon Musk',
          'Mark Zuckerberg',
        ],
        'correct': 0,
        'explanation':
            'Bitcoin fue creado por una persona o grupo bajo el pseudónimo Satoshi Nakamoto.',
      },
      {
        'question': '¿Qué es la blockchain?',
        'answers': [
          'Un libro de contabilidad distribuido',
          'Una cadena de tiendas',
          'Un tipo de contrato',
          'Un algoritmo de compresión',
        ],
        'correct': 0,
        'explanation':
            'Blockchain es un libro de contabilidad distribuido que registra todas las transacciones.',
      },
    ],
    'intermedio': [
      {
        'question': '¿Qué es la minería de Bitcoin?',
        'answers': [
          'El proceso de verificar transacciones',
          'Extraer bitcoins del suelo',
          'Comprar bitcoins en exchange',
          'Crear wallets digitales',
        ],
        'correct': 0,
        'explanation':
            'La minería implica verificar transacciones y agregarlas a la blockchain.',
      },
      {
        'question': '¿Qué es un halving?',
        'answers': [
          'Reducción a la mitad de la recompensa minera',
          'Dividir un bitcoin en partes',
          'Reducir las tarifas de transacción',
          'Duplicar el suministro de bitcoin',
        ],
        'correct': 0,
        'explanation':
            'El halving reduce la recompensa de los mineros a la mitad cada 4 años aproximadamente.',
      },
      {
        'question': '¿Qué es la dificultad minera?',
        'answers': [
          'La medida de lo difícil que es minar un bloque',
          'La complejidad de usar un wallet',
          'El tiempo para confirmar una transacción',
          'El costo de comprar bitcoin',
        ],
        'correct': 0,
        'explanation':
            'La dificultad minera se ajusta para mantener el tiempo de bloque en 10 minutos.',
      },
    ],
    'avanzado': [
      {
        'question': '¿Qué es SegWit?',
        'answers': [
          'Segregated Witness - mejora de escalabilidad',
          'Security Witness - protocolo de seguridad',
          'Segment Warning - alerta de red',
          'Secure Wallet - tipo de cartera',
        ],
        'correct': 0,
        'explanation':
            'SegWit separa la firma digital de los datos de transacción para aumentar capacidad.',
      },
      {
        'question': '¿Qué es Taproot?',
        'answers': [
          'Actualización que mejora privacidad y eficiencia',
          'Un tipo de nodo completo',
          'Algoritmo de minería',
          'Protocolo de exchange',
        ],
        'correct': 0,
        'explanation':
            'Taproot mejora la privacidad de las transacciones complejas como los Lightning Channels.',
      },
      {
        'question': '¿Qué es el Lightning Network?',
        'answers': [
          'Red de pagos instantáneos de segunda capa',
          'Red de minería acelerada',
          'Protocolo de seguridad mejorado',
          'Tipo de wallet hardware',
        ],
        'correct': 0,
        'explanation':
            'Lightning Network permite transacciones instantáneas y de bajo costo.',
      },
    ],
  };

  List<Map<String, dynamic>> get _currentQuestions {
    if (_selectedCategory == null) return [];
    return _questionsByCategory[_selectedCategory!] ?? [];
  }

  Map<String, dynamic> get _currentQuestion {
    return _currentQuestions[_currentQuestionIndex];
  }

  Map<String, dynamic> get _currentCategory {
    return _categories.firstWhere(
      (cat) => cat['id'] == _selectedCategory,
      orElse: () => _categories[0],
    );
  }

  void _selectCategory(String categoryId) {
    setState(() {
      _selectedCategory = categoryId;
      _currentQuestionIndex = 0;
      _score = 0;
      _quizCompleted = false;
      _answerSubmitted = false;
    });
  }

  void _answerQuestion(int answerIndex) {
    if (_answerSubmitted) return;

    setState(() {
      _selectedAnswer = answerIndex.toString();
      _answerSubmitted = true;

      if (answerIndex == _currentQuestion['correct']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _currentQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _answerSubmitted = false;
      });
    } else {
      setState(() {
        _quizCompleted = true;
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      _selectedCategory = null;
      _currentQuestionIndex = 0;
      _score = 0;
      _quizCompleted = false;
      _selectedAnswer = null;
      _answerSubmitted = false;
    });
  }

  void _goHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedCategory != null
              ? 'Quiz ${_currentCategory['name']}'
              : 'Selecciona una Categoría',
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          if (_selectedCategory != null && !_quizCompleted)
            TextButton(
              onPressed: _restartQuiz,
              child: const Text(
                'Reiniciar',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_selectedCategory == null) {
      return _buildCategorySelection();
    }

    if (_quizCompleted) {
      return _buildResults();
    }

    return _buildQuiz();
  }

  Widget _buildCategorySelection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecciona una Categoría',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Completa quizzes y gana recompensas según tu nivel',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Icon(category['icon'], color: category['color']),
                    title: Text(category['name']),
                    subtitle: Text(category['description']),
                    trailing: Chip(
                      label: Text(category['reward']),
                      backgroundColor: category['color'].withOpacity(0.1),
                    ),
                    onTap: () => _selectCategory(category['id']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuiz() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _currentQuestions.length,
            backgroundColor: Colors.grey[300],
            color: _currentCategory['color'],
          ),
          const SizedBox(height: 16),

          // Question counter
          Text(
            'Pregunta ${_currentQuestionIndex + 1} de ${_currentQuestions.length}',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),

          // Question
          Text(
            _currentQuestion['question'] as String,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // Answers
          Expanded(
            child: ListView.separated(
              itemCount: (_currentQuestion['answers'] as List).length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final answer = (_currentQuestion['answers'] as List)[index];
                final isCorrect = index == _currentQuestion['correct'];
                final isSelected = _selectedAnswer == index.toString();

                Color getButtonColor() {
                  if (!_answerSubmitted) return Colors.blueAccent;
                  if (isCorrect) return Colors.green;
                  if (isSelected && !isCorrect) return Colors.red;
                  return Colors.grey;
                }

                return CustomButton(
                  text: answer.toString(),
                  onPressed: _answerSubmitted
                      ? null
                      : () => _answerQuestion(index),
                  backgroundColor: getButtonColor(),
                );
              },
            ),
          ),

          // Explanation and Next button
          if (_answerSubmitted) ...[
            const SizedBox(height: 16),
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Explicación:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(_currentQuestion['explanation'] as String),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: _currentQuestionIndex < _currentQuestions.length - 1
                  ? 'Siguiente Pregunta'
                  : 'Ver Resultados',
              onPressed: _nextQuestion,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResults() {
    final percentage = (_score / _currentQuestions.length * 100).round();
    final category = _currentCategory;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            percentage >= 70 ? Icons.celebration : Icons.school,
            size: 80,
            color: category['color'],
          ),
          const SizedBox(height: 24),
          Text(
            '¡Quiz Completado!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: category['color'],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Categoría: ${category['name']}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Puntuación: $_score/${_currentQuestions.length} ($percentage%)',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (percentage >= 70) ...[
            const Text(
              '¡Felicidades! Has ganado:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(
                category['reward'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: category['color'].withOpacity(0.2),
            ),
          ] else ...[
            const Text(
              'Sigue practicando para ganar recompensas',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _restartQuiz,
                  child: const Text('Elegir Otro Quiz'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(text: 'Volver al Home', onPressed: _goHome),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
