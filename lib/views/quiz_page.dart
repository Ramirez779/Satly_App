// views/quiz_page.dart
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
      'color': Colors.blueAccent,
      'icon': Icons.school_rounded,
      'description': 'Conceptos fundamentales de Bitcoin',
      'reward': '10 SATS',
      'gradient': [Colors.blueAccent, Colors.lightBlueAccent],
      'difficulty': '★☆☆',
    },
    {
      'id': 'intermedio',
      'name': 'Intermedio',
      'color': Colors.orange,
      'icon': Icons.trending_up_rounded,
      'description': 'Temas más avanzados de Bitcoin',
      'reward': '20 SATS',
      'gradient': [Colors.orangeAccent, Colors.amberAccent],
      'difficulty': '★★☆',
    },
    {
      'id': 'avanzado',
      'name': 'Avanzado',
      'color': Colors.purple,
      'icon': Icons.auto_awesome_rounded,
      'description': 'Para expertos en Bitcoin',
      'reward': '30 SATS',
      'gradient': [Colors.purpleAccent, Colors.deepPurpleAccent],
      'difficulty': '★★★',
    },
    {
      'id': 'lightning',
      'name': 'Lightning Network',
      'color': Colors.green,
      'icon': Icons.bolt_rounded,
      'description': 'Pagos instantáneos y de bajo costo',
      'reward': '25 SATS',
      'gradient': [Colors.greenAccent, Colors.tealAccent],
      'difficulty': '★★☆',
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
      {
        'question': '¿Qué es un wallet de Bitcoin?',
        'answers': [
          'Una billetera digital para almacenar claves',
          'Un lugar físico para guardar bitcoins',
          'Un tipo de exchange',
          'Una tarjeta de débito',
        ],
        'correct': 0,
        'explanation':
            'Un wallet almacena las claves privadas que te permiten acceder a tus bitcoins.',
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
      {
        'question': '¿Qué es un nodo completo?',
        'answers': [
          'Un software que valida todas las reglas de Bitcoin',
          'Un minero especializado',
          'Un wallet con muchos bitcoins',
          'Un exchange grande',
        ],
        'correct': 0,
        'explanation':
            'Los nodos completos validan transacciones y bloques manteniendo la red descentralizada.',
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
      {
        'question': '¿Qué son las multisig?',
        'answers': [
          'Direcciones que requieren múltiples firmas',
          'Múltiples transacciones en un bloque',
          'Varios mineros trabajando juntos',
          'Múltiples wallets en un dispositivo',
        ],
        'correct': 0,
        'explanation':
            'Multisig requiere múltiples claves privadas para autorizar una transacción, mejorando seguridad.',
      },
    ],
    'lightning': [
      {
        'question': '¿Qué problema resuelve Lightning Network?',
        'answers': [
          'Escalabilidad y tarifas altas',
          'Seguridad de los wallets',
          'Volatilidad del precio',
          'Adopción masiva',
        ],
        'correct': 0,
        'explanation':
            'Lightning resuelve problemas de escalabilidad permitiendo transacciones fuera de la cadena principal.',
      },
      {
        'question': '¿Qué es un payment channel?',
        'answers': [
          'Conexión entre dos usuarios para pagos rápidos',
          'Canal de comunicación con mineros',
          'Método para comprar bitcoin',
          'Tipo de wallet específico',
        ],
        'correct': 0,
        'explanation':
            'Los payment channels permiten múltiples transacciones instantáneas con una sola comisión.',
      },
      {
        'question': '¿Qué son los satoshis en Lightning?',
        'answers': [
          'La unidad más pequeña de bitcoin',
          'Los nodos de la red',
          'Las comisiones de transacción',
          'Los canales de pago',
        ],
        'correct': 0,
        'explanation':
            'Los satoshis (0.00000001 BTC) son la unidad base para transacciones en Lightning.',
      },
      {
        'question': '¿Qué es un LNURL?',
        'answers': [
          'Estándar para URLs de Lightning',
          'URL para comprar bitcoin',
          'Dirección de un nodo Lightning',
          'Código QR de un wallet',
        ],
        'correct': 0,
        'explanation':
            'LNURL estandariza las interacciones con la red Lightning mediante URLs simples.',
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

  void _retryQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizCompleted = false;
      _selectedAnswer = null;
      _answerSubmitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;
          final bool isTablet =
              constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
          final bool isDesktop = constraints.maxWidth >= 1024;

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xFFE3F2FD)],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile
                      ? 16.0
                      : isTablet
                      ? 24.0
                      : 32.0,
                  vertical: isMobile
                      ? 8.0
                      : isTablet
                      ? 16.0
                      : 20.0,
                ),
                child: _buildContent(
                  isMobile,
                  isTablet,
                  isDesktop,
                  constraints.maxWidth,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(
    bool isMobile,
    bool isTablet,
    bool isDesktop,
    double maxWidth,
  ) {
    if (_selectedCategory == null) {
      return _buildCategorySelection(isMobile, isTablet, isDesktop, maxWidth);
    }

    if (_quizCompleted) {
      return _buildResults(isMobile, isTablet, isDesktop);
    }

    return _buildQuiz(isMobile, isTablet, isDesktop);
  }

  Widget _buildCategorySelection(
    bool isMobile,
    bool isTablet,
    bool isDesktop,
    double maxWidth,
  ) {
    final double titleSize = isMobile
        ? 32
        : isTablet
        ? 28
        : 36;
    final double subtitleSize = isMobile
        ? 16
        : isTablet
        ? 14
        : 18;
    final int crossAxisCount = isMobile ? 2 : (isTablet ? 3 : 4);
    final double aspectRatio = isMobile ? 0.9 : (isTablet ? 0.8 : 0.7);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: isMobile
              ? 20
              : isTablet
              ? 10
              : 20,
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: Text(
            'Elige tu Quiz',
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.5,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: isMobile
              ? 8
              : isTablet
              ? 4
              : 8,
        ),
        Text(
          'Completa quizzes y gana recompensas en SATS',
          style: TextStyle(
            fontSize: subtitleSize,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: isMobile
              ? 24
              : isTablet
              ? 16
              : 24,
        ),

        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: isMobile
                  ? 16
                  : isTablet
                  ? 20
                  : 24,
              mainAxisSpacing: isMobile
                  ? 16
                  : isTablet
                  ? 20
                  : 24,
              childAspectRatio: aspectRatio,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return _buildCategoryCard(
                category,
                isMobile,
                isTablet,
                isDesktop,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    Map<String, dynamic> category,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    final gradientColors = (category['gradient'] as List<Color>);
    final double padding = isMobile ? 16 : (isTablet ? 12 : 16);
    final double iconSize = isMobile ? 50 : (isTablet ? 40 : 60);
    final double titleSize = isMobile ? 18 : (isTablet ? 16 : 20);
    final double descSize = isMobile ? 12 : (isTablet ? 11 : 14);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _selectCategory(category['id']),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      color: const Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      size: iconSize * 0.6,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: isMobile
                        ? 12
                        : isTablet
                        ? 8
                        : 12,
                  ),
                  Text(
                    category['name'] as String,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 4 : 2),
                  Text(
                    category['difficulty'] as String,
                    style: TextStyle(
                      fontSize: descSize,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: isMobile
                        ? 8
                        : isTablet
                        ? 4
                        : 8,
                  ),
                  Text(
                    category['description'] as String,
                    style: TextStyle(
                      fontSize: descSize,
                      color: const Color(0xE6FFFFFF),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: isMobile
                        ? 8
                        : isTablet
                        ? 4
                        : 8,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      category['reward'] as String,
                      style: TextStyle(
                        fontSize: isMobile
                            ? 14
                            : isTablet
                            ? 12
                            : 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuiz(bool isMobile, bool isTablet, bool isDesktop) {
    final category = _currentCategory;
    final gradientColors = (category['gradient'] as List<Color>);
    final bool isSelected = _selectedAnswer != null;
    final bool isCorrect =
        isSelected && _selectedAnswer == _currentQuestion['correct'].toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header con progreso
        Container(
          padding: EdgeInsets.symmetric(
            vertical: isMobile
                ? 8
                : isTablet
                ? 4
                : 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: isMobile
                          ? 24
                          : isTablet
                          ? 20
                          : 28,
                    ),
                    onPressed: _restartQuiz,
                    color: Colors.blueAccent,
                  ),
                  Expanded(
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Text(
                        'Quiz ${category['name']}',
                        style: TextStyle(
                          fontSize: isMobile
                              ? 24
                              : isTablet
                              ? 20
                              : 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Color.alphaBlend(
                        const Color(0x1A000000),
                        gradientColors[0],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$_score/${_currentQuestions.length}',
                      style: TextStyle(
                        fontSize: isMobile
                            ? 14
                            : isTablet
                            ? 12
                            : 16,
                        fontWeight: FontWeight.w600,
                        color: gradientColors[0],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: isMobile
                    ? 12
                    : isTablet
                    ? 8
                    : 12,
              ),
              // Barra de progreso
              Container(
                height: isMobile
                    ? 8
                    : isTablet
                    ? 6
                    : 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xFFE0E0E0),
                ),
                child: AnimatedFractionallySizedBox(
                  duration: const Duration(milliseconds: 500),
                  alignment: Alignment.centerLeft,
                  widthFactor:
                      (_currentQuestionIndex + 1) / _currentQuestions.length,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(colors: gradientColors),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: isMobile
              ? 24
              : isTablet
              ? 16
              : 24,
        ),

        // Indicador de pregunta
        Text(
          'Pregunta ${_currentQuestionIndex + 1} de ${_currentQuestions.length}',
          style: TextStyle(
            fontSize: isMobile
                ? 16
                : isTablet
                ? 14
                : 18,
            color: const Color(0xFF757575),
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(
          height: isMobile
              ? 16
              : isTablet
              ? 12
              : 16,
        ),

        // Pregunta
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(
              isMobile
                  ? 20
                  : isTablet
                  ? 16
                  : 24,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 20,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _currentQuestion['question'] as String,
                  style: TextStyle(
                    fontSize: isMobile
                        ? 22
                        : isTablet
                        ? 18
                        : 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: isMobile
              ? 24
              : isTablet
              ? 16
              : 24,
        ),

        // Opciones de respuesta
        Expanded(
          flex: 3,
          child: ListView.separated(
            itemCount: (_currentQuestion['answers'] as List).length,
            separatorBuilder: (context, index) => SizedBox(
              height: isMobile
                  ? 12
                  : isTablet
                  ? 8
                  : 12,
            ),
            itemBuilder: (context, index) {
              final answer = (_currentQuestion['answers'] as List)[index];
              final answerIsCorrect = index == _currentQuestion['correct'];
              final answerIsSelected = _selectedAnswer == index.toString();

              return _buildAnswerOption(
                answer.toString(),
                index,
                answerIsSelected,
                answerIsCorrect,
                gradientColors,
                isMobile,
                isTablet,
                isDesktop,
              );
            },
          ),
        ),

        // Explicación y botón siguiente
        if (_answerSubmitted) ...[
          SizedBox(
            height: isMobile
                ? 16
                : isTablet
                ? 12
                : 16,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: EdgeInsets.all(
              isMobile
                  ? 16
                  : isTablet
                  ? 12
                  : 16,
            ),
            decoration: BoxDecoration(
              color: isCorrect
                  ? const Color(0x1A4CAF50)
                  : const Color(0x1AF44336),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isCorrect
                    ? const Color(0x4D4CAF50)
                    : const Color(0x4DF44336),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isCorrect
                          ? Icons.check_circle_rounded
                          : Icons.info_rounded,
                      color: isCorrect ? Colors.green : Colors.blueAccent,
                      size: isMobile
                          ? 20
                          : isTablet
                          ? 18
                          : 22,
                    ),
                    SizedBox(width: 8),
                    Text(
                      isCorrect ? '¡Correcto!' : 'Explicación:',
                      style: TextStyle(
                        fontSize: isMobile
                            ? 16
                            : isTablet
                            ? 14
                            : 18,
                        fontWeight: FontWeight.w600,
                        color: isCorrect ? Colors.green : Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  _currentQuestion['explanation'] as String,
                  style: TextStyle(
                    fontSize: isMobile
                        ? 14
                        : isTablet
                        ? 13
                        : 16,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: isMobile
                ? 16
                : isTablet
                ? 12
                : 16,
          ),
          CustomButton(
            text: _currentQuestionIndex < _currentQuestions.length - 1
                ? 'Siguiente Pregunta →'
                : 'Ver Resultados 🎯',
            onPressed: _nextQuestion,
            isPrimary: true,
            height: isMobile
                ? 56
                : isTablet
                ? 52
                : 60,
          ),
        ],
      ],
    );
  }

  Widget _buildAnswerOption(
    String answer,
    int index,
    bool answerIsSelected,
    bool answerIsCorrect,
    List<Color> gradientColors,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    Color getButtonColor() {
      if (!_answerSubmitted) return Colors.transparent;
      if (answerIsCorrect) return Colors.green;
      if (answerIsSelected && !answerIsCorrect) return Colors.red;
      return const Color(0xFFE0E0E0);
    }

    final double padding = isMobile ? 16 : (isTablet ? 12 : 20);
    final double iconSize = isMobile ? 32 : (isTablet ? 28 : 36);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Material(
        color: _answerSubmitted ? getButtonColor() : Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: _answerSubmitted ? 0 : 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _answerSubmitted ? null : () => _answerQuestion(index),
          child: Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _answerSubmitted
                    ? getButtonColor()
                    : const Color(0xFFE0E0E0),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    color: _answerSubmitted
                        ? getButtonColor()
                        : Color.alphaBlend(
                            const Color(0x1A000000),
                            gradientColors[0],
                          ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _answerSubmitted
                        ? (answerIsCorrect
                              ? Icons.check_rounded
                              : answerIsSelected
                              ? Icons.close_rounded
                              : Icons.circle_outlined)
                        : Icons.circle_outlined,
                    size: iconSize * 0.6,
                    color: _answerSubmitted ? Colors.white : gradientColors[0],
                  ),
                ),
                SizedBox(
                  width: isMobile
                      ? 16
                      : isTablet
                      ? 12
                      : 20,
                ),
                Expanded(
                  child: Text(
                    answer,
                    style: TextStyle(
                      fontSize: isMobile
                          ? 16
                          : isTablet
                          ? 14
                          : 18,
                      fontWeight: FontWeight.w500,
                      color:
                          _answerSubmitted &&
                              (answerIsCorrect || answerIsSelected)
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResults(bool isMobile, bool isTablet, bool isDesktop) {
    final percentage = (_score / _currentQuestions.length * 100).round();
    final category = _currentCategory;
    final gradientColors = (category['gradient'] as List<Color>);
    final hasPassed = percentage >= 70;

    final double iconSize = isMobile ? 120 : (isTablet ? 100 : 140);
    final double titleSize = isMobile ? 32 : (isTablet ? 28 : 36);
    final double scoreSize = isMobile ? 24 : (isTablet ? 20 : 28);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: isMobile
              ? 20
              : isTablet
              ? 10
              : 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColors),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color.alphaBlend(
                      const Color(0x4D000000),
                      gradientColors[0],
                    ),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                hasPassed ? Icons.celebration_rounded : Icons.school_rounded,
                size: iconSize * 0.5,
                color: Colors.white,
              ),
            ),

            SizedBox(
              height: isMobile
                  ? 32
                  : isTablet
                  ? 24
                  : 32,
            ),

            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: Text(
                hasPassed ? '¡Quiz Completado!' : 'Sigue Practicando',
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(
              height: isMobile
                  ? 16
                  : isTablet
                  ? 12
                  : 16,
            ),

            Container(
              padding: EdgeInsets.all(
                isMobile
                    ? 20
                    : isTablet
                    ? 16
                    : 24,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Categoría: ${category['name']}',
                    style: TextStyle(
                      fontSize: isMobile
                          ? 18
                          : isTablet
                          ? 16
                          : 20,
                      color: const Color(0xFF757575),
                    ),
                  ),
                  SizedBox(
                    height: isMobile
                        ? 12
                        : isTablet
                        ? 8
                        : 12,
                  ),
                  Text(
                    '$_score/${_currentQuestions.length} Preguntas',
                    style: TextStyle(
                      fontSize: scoreSize,
                      fontWeight: FontWeight.w700,
                      color: gradientColors[0],
                    ),
                  ),
                  SizedBox(
                    height: isMobile
                        ? 8
                        : isTablet
                        ? 4
                        : 8,
                  ),
                  Text(
                    '$percentage% de aciertos',
                    style: TextStyle(
                      fontSize: isMobile
                          ? 16
                          : isTablet
                          ? 14
                          : 18,
                      color: const Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: isMobile
                  ? 24
                  : isTablet
                  ? 16
                  : 24,
            ),

            if (hasPassed) ...[
              Container(
                padding: EdgeInsets.all(
                  isMobile
                      ? 16
                      : isTablet
                      ? 12
                      : 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x1A4CAF50),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0x4D4CAF50)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bolt_rounded,
                      color: Colors.green,
                      size: isMobile
                          ? 24
                          : isTablet
                          ? 20
                          : 28,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '¡Has ganado ${category['reward']}!',
                      style: TextStyle(
                        fontSize: isMobile
                            ? 18
                            : isTablet
                            ? 16
                            : 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[800]!,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: isMobile
                    ? 8
                    : isTablet
                    ? 4
                    : 8,
              ),
              Text(
                'Los SATS han sido añadidos a tu wallet',
                style: TextStyle(
                  fontSize: isMobile
                      ? 14
                      : isTablet
                      ? 12
                      : 16,
                  color: const Color(0xFF757575),
                ),
              ),
            ] else ...[
              Text(
                'Necesitas al menos 70% para ganar recompensas',
                style: TextStyle(
                  fontSize: isMobile
                      ? 14
                      : isTablet
                      ? 12
                      : 16,
                  color: const Color(0xFF757575),
                ),
                textAlign: TextAlign.center,
              ),
            ],

            SizedBox(
              height: isMobile
                  ? 32
                  : isTablet
                  ? 24
                  : 32,
            ),

            // Botones responsivos
            if (isMobile || isTablet)
              _buildVerticalButtons(isMobile, isTablet, hasPassed)
            else
              _buildHorizontalButtons(hasPassed),

            SizedBox(
              height: isMobile
                  ? 20
                  : isTablet
                  ? 16
                  : 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalButtons(bool isMobile, bool isTablet, bool hasPassed) {
    return Column(
      children: [
        if (!hasPassed) ...[
          CustomButton(
            text: 'Reintentar Quiz',
            onPressed: _retryQuiz,
            isPrimary: true,
            height: isMobile
                ? 56
                : isTablet
                ? 52
                : 60,
          ),
          SizedBox(
            height: isMobile
                ? 12
                : isTablet
                ? 10
                : 12,
          ),
        ],
        CustomButton(
          text: 'Nuevo Quiz',
          onPressed: _restartQuiz,
          isPrimary: !hasPassed,
          height: isMobile
              ? 56
              : isTablet
              ? 52
              : 60,
        ),
        SizedBox(
          height: isMobile
              ? 12
              : isTablet
              ? 10
              : 12,
        ),
        CustomButton(
          text: 'Volver al Home',
          onPressed: _goHome,
          isPrimary: false,
          height: isMobile
              ? 56
              : isTablet
              ? 52
              : 60,
        ),
      ],
    );
  }

  Widget _buildHorizontalButtons(bool hasPassed) {
    return Row(
      children: [
        if (!hasPassed) ...[
          Expanded(
            child: CustomButton(
              text: 'Reintentar Quiz',
              onPressed: _retryQuiz,
              isPrimary: true,
              height: 60,
            ),
          ),
          SizedBox(width: 16),
        ],
        Expanded(
          child: CustomButton(
            text: 'Nuevo Quiz',
            onPressed: _restartQuiz,
            isPrimary: !hasPassed,
            height: 60,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: CustomButton(
            text: 'Volver al Home',
            onPressed: _goHome,
            isPrimary: false,
            height: 60,
          ),
        ),
      ],
    );
  }
}
