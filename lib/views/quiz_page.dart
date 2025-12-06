// views/quiz_page.dart
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/typography.dart';
import '../utils/spacing.dart';
import '../widgets/custom_button.dart';
import '../data/quiz_categories_list.dart';

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
  String? _selectedQuizId;
  String? _selectedAnswer;
  bool _answerSubmitted = false;

  // Usar las categorías importadas
  final List<Map<String, dynamic>> _categories = QuizCategoriesList.categories;

  // Obtener los quizzes disponibles para la categoría seleccionada
  List<Map<String, dynamic>> get _availableQuizzes {
    if (_selectedCategory == null) return [];
    final category = _categories.firstWhere(
      (cat) => cat['id'] == _selectedCategory,
      orElse: () => {'quizzes': []},
    );
    return List<Map<String, dynamic>>.from(category['quizzes'] ?? []);
  }

  // Obtener las preguntas del quiz seleccionado
  List<Map<String, dynamic>> get _currentQuestions {
    if (_selectedQuizId == null) return [];
    final quiz = _availableQuizzes.firstWhere(
      (quiz) => quiz['id'] == _selectedQuizId,
      orElse: () => {'questions': []},
    );
    return List<Map<String, dynamic>>.from(quiz['questions'] ?? []);
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

  Map<String, dynamic> get _currentQuiz {
    return _availableQuizzes.firstWhere(
      (quiz) => quiz['id'] == _selectedQuizId,
      orElse: () => _availableQuizzes[0],
    );
  }

  void _selectCategory(String categoryId) {
    setState(() {
      _selectedCategory = categoryId;
      _selectedQuizId = null;
      _currentQuestionIndex = 0;
      _score = 0;
      _quizCompleted = false;
      _answerSubmitted = false;
    });
  }

  void _selectQuiz(String quizId) {
    setState(() {
      _selectedQuizId = quizId;
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
      _selectedQuizId = null;
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

  void _backToQuizSelection() {
    setState(() {
      _selectedQuizId = null;
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
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;
          final bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
          final bool isDesktop = constraints.maxWidth >= 1024;

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.background, AppColors.card],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? AppSpacing.md : isTablet ? AppSpacing.lg : AppSpacing.xl,
                  vertical: isMobile ? AppSpacing.sm : isTablet ? AppSpacing.md : AppSpacing.lg,
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

    if (_selectedQuizId == null) {
      return _buildQuizSelection(isMobile, isTablet, isDesktop);
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
    final double titleSize = isMobile ? 32 : isTablet ? 28 : 36;
    final int crossAxisCount = isMobile ? 2 : (isTablet ? 3 : 4);
    final double aspectRatio = isMobile ? 0.9 : (isTablet ? 0.8 : 0.7);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: isMobile ? 20 : isTablet ? 10 : 20),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: Text(
            'Elige tu Quiz',
            style: AppTextStyles.displayLarge.copyWith(
              fontSize: titleSize,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        Text(
          'Completa quizzes y gana recompensas en SATS',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: AppSpacing.lg),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
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

  Widget _buildQuizSelection(bool isMobile, bool isTablet, bool isDesktop) {
    final category = _currentCategory;
    final gradientColors = (category['gradient'] as List<Color>);
    final double titleSize = isMobile ? 24 : (isTablet ? 20 : 28);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                size: isMobile ? 24 : (isTablet ? 20 : 28),
              ),
              onPressed: _restartQuiz,
              color: AppColors.primary,
            ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: Text(
                'Elige un Quiz - ${category['name']}',
                style: AppTextStyles.titleLarge.copyWith(
                  fontSize: titleSize,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md),
        Text(
          'Selecciona uno de los quizzes disponibles:',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: AppSpacing.lg),

        // Lista de quizzes
        Expanded(
          child: ListView.separated(
            itemCount: _availableQuizzes.length,
            separatorBuilder: (context, index) => SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final quiz = _availableQuizzes[index];
              return _buildQuizCard(
                quiz,
                gradientColors,
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

  Widget _buildQuizCard(
    Map<String, dynamic> quiz,
    List<Color> gradientColors,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    final double padding = isMobile ? 20 : (isTablet ? 16 : 24);
    final double titleSize = isMobile ? 18 : (isTablet ? 16 : 20);
    final double descSize = isMobile ? 14 : (isTablet ? 13 : 16);

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _selectQuiz(quiz['id']),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                gradientColors[0].withOpacity(0.9),
                gradientColors[1].withOpacity(0.9),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quiz['name'] as String,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  quiz['description'] as String,
                  style: TextStyle(
                    fontSize: descSize,
                    color: Color(0xE6FFFFFF),
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${(quiz['questions'] as List).length} preguntas',
                        style: TextStyle(
                          fontSize: isMobile ? 12 : isTablet ? 11 : 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: isMobile ? 20 : (isTablet ? 18 : 24),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
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
                    color: Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    size: iconSize * 0.6,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  category['name'] as String,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  category['difficulty'] as String,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : (isTablet ? 11 : 14),
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.bolt_rounded,
                        size: isMobile ? 14 : (isTablet ? 12 : 16),
                        color: Colors.yellow[300],
                      ),
                      SizedBox(width: 4),
                      Text(
                        category['reward'] as String,
                        style: TextStyle(
                          fontSize: isMobile ? 14 : (isTablet ? 12 : 16),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuiz(bool isMobile, bool isTablet, bool isDesktop) {
    final category = _currentCategory;
    final quiz = _currentQuiz;
    final gradientColors = (category['gradient'] as List<Color>);
    final bool isSelected = _selectedAnswer != null;
    final bool isCorrect = isSelected && _selectedAnswer == _currentQuestion['correct'].toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header con progreso
        Container(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: isMobile ? 24 : (isTablet ? 20 : 28),
                    ),
                    onPressed: _backToQuizSelection,
                    color: AppColors.primary,
                  ),
                  Expanded(
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Text(
                        '${quiz['name']}',
                        style: AppTextStyles.titleLarge.copyWith(
                          fontSize: isMobile ? 20 : (isTablet ? 18 : 24),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: Color.alphaBlend(
                        Color(0x1A000000),
                        gradientColors[0],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$_score/${_currentQuestions.length}',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : (isTablet ? 12 : 16),
                        fontWeight: FontWeight.w600,
                        color: gradientColors[0],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.sm),
              // Barra de progreso
              Container(
                height: isMobile ? 8 : (isTablet ? 6 : 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0xFFE0E0E0),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (_currentQuestionIndex + 1) / _currentQuestions.length,
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

        SizedBox(height: AppSpacing.lg),

        // Indicador de pregunta
        Text(
          'Pregunta ${_currentQuestionIndex + 1} de ${_currentQuestions.length}',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),

        SizedBox(height: AppSpacing.md),

        // Pregunta
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 20 : (isTablet ? 16 : 24)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
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
                  style: AppTextStyles.titleLarge.copyWith(
                    fontSize: isMobile ? 22 : (isTablet ? 18 : 24),
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: AppSpacing.lg),

        // Opciones de respuesta
        Expanded(
          flex: 3,
          child: ListView.separated(
            itemCount: (_currentQuestion['answers'] as List).length,
            separatorBuilder: (context, index) => SizedBox(height: AppSpacing.sm),
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
          SizedBox(height: AppSpacing.md),
          Container(
            padding: EdgeInsets.all(isMobile ? 16 : (isTablet ? 12 : 16)),
            decoration: BoxDecoration(
              color: isCorrect ? Color(0x1A4CAF50) : Color(0x1AF44336),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isCorrect ? Color(0x4D4CAF50) : Color(0x4DF44336),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isCorrect ? Icons.check_circle_rounded : Icons.info_rounded,
                      color: isCorrect ? AppColors.success : AppColors.accent,
                      size: isMobile ? 20 : (isTablet ? 18 : 22),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Text(
                      isCorrect ? '¡Correcto!' : 'Explicación:',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: isCorrect ? AppColors.success : AppColors.accent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  _currentQuestion['explanation'] as String,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.md),
          CustomButton(
            text: _currentQuestionIndex < _currentQuestions.length - 1
                ? 'Siguiente Pregunta →'
                : 'Ver Resultados 🎯',
            onPressed: _nextQuestion,
            isPrimary: true,
            height: isMobile ? 56 : (isTablet ? 52 : 60),
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
      if (answerIsCorrect) return AppColors.success;
      if (answerIsSelected && !answerIsCorrect) return AppColors.error;
      return Color(0xFFE0E0E0);
    }

    final double padding = isMobile ? 16 : (isTablet ? 12 : 20);
    final double iconSize = isMobile ? 32 : (isTablet ? 28 : 36);

    return Material(
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
              color: _answerSubmitted ? getButtonColor() : Color(0xFFE0E0E0),
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
                      : Color.alphaBlend(Color(0x1A000000), gradientColors[0]),
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
              SizedBox(width: isMobile ? 16 : (isTablet ? 12 : 20)),
              Expanded(
                child: Text(
                  answer,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: _answerSubmitted && (answerIsCorrect || answerIsSelected)
                        ? Colors.white
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResults(bool isMobile, bool isTablet, bool isDesktop) {
    final percentage = (_score / _currentQuestions.length * 100).round();
    final category = _currentCategory;
    final quiz = _currentQuiz;
    final gradientColors = (category['gradient'] as List<Color>);
    final hasPassed = percentage >= 70;

    final double iconSize = isMobile ? 120 : (isTablet ? 100 : 140);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 20 : (isTablet ? 10 : 40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColors),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color.alphaBlend(Color(0x4D000000), gradientColors[0]),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                hasPassed ? Icons.celebration_rounded : Icons.school_rounded,
                size: iconSize * 0.5,
                color: Colors.white,
              ),
            ),
            SizedBox(height: AppSpacing.xl),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: Text(
                hasPassed ? '¡Quiz Completado!' : 'Sigue Practicando',
                style: AppTextStyles.displayLarge.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            Container(
              padding: EdgeInsets.all(isMobile ? 20 : (isTablet ? 16 : 24)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
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
                    '${quiz['name']}',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: gradientColors[0],
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    '$_score/${_currentQuestions.length} Preguntas',
                    style: AppTextStyles.displaySmall.copyWith(
                    color: gradientColors[0],
),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    '$percentage% de aciertos',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.lg),
            if (hasPassed) ...[
              Container(
                padding: EdgeInsets.all(isMobile ? 16 : (isTablet ? 12 : 16)),
                decoration: BoxDecoration(
                  color: Color(0x1A4CAF50),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0x4D4CAF50)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bolt_rounded,
                      color: AppColors.success,
                      size: isMobile ? 24 : (isTablet ? 20 : 28),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Text(
                      '¡Has ganado ${category['reward']}!',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Los SATS han sido añadidos a tu wallet',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ] else ...[
              Text(
                'Necesitas al menos 70% para ganar recompensas',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: AppSpacing.xl),
            // Botones responsivos
            if (isMobile || isTablet)
              _buildVerticalButtons(isMobile, isTablet, hasPassed)
            else
              _buildHorizontalButtons(hasPassed),
            SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  /// Botones en columna (mobile / tablet)
  Widget _buildVerticalButtons(bool isMobile, bool isTablet, bool hasPassed) {
    return Column(
      children: [
        // Si SÍ pasó el quiz, primero botón para ver la wallet
        if (hasPassed) ...[
          CustomButton(
            text: 'Ver mi Wallet',
            onPressed: () {
              Navigator.pushNamed(context, '/wallet');
            },
            isPrimary: true,
            height: isMobile ? 56 : (isTablet ? 52 : 60),
          ),
          SizedBox(height: AppSpacing.md),
        ],

        // Si NO pasó, mostrar botón de reintentar
        if (!hasPassed) ...[
          CustomButton(
            text: 'Reintentar Quiz',
            onPressed: _retryQuiz,
            isPrimary: true,
            height: isMobile ? 56 : (isTablet ? 52 : 60),
          ),
          SizedBox(height: AppSpacing.md),
        ],

        // Elegir otro quiz
        CustomButton(
          text: 'Elegir Otro Quiz',
          onPressed: _backToQuizSelection,
          isPrimary: !hasPassed,
          height: isMobile ? 56 : (isTablet ? 52 : 60),
        ),
        SizedBox(height: AppSpacing.md),

        // Volver al Home
        CustomButton(
          text: 'Volver al Home',
          onPressed: _goHome,
          isPrimary: false,
          height: isMobile ? 56 : (isTablet ? 52 : 60),
        ),
      ],
    );
  }

  /// Botones en fila (desktop)
  Widget _buildHorizontalButtons(bool hasPassed) {
    // Versión cuando NO ganó sats
    if (!hasPassed) {
      return Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Reintentar Quiz',
              onPressed: _retryQuiz,
              isPrimary: true,
              height: 60,
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: CustomButton(
              text: 'Elegir Otro Quiz',
              onPressed: _backToQuizSelection,
              isPrimary: false,
              height: 60,
            ),
          ),
          SizedBox(width: AppSpacing.md),
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

    // Versión cuando SÍ ganó sats: incluye "Ver mi Wallet"
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Elegir Otro Quiz',
            onPressed: _backToQuizSelection,
            isPrimary: false,
            height: 60,
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: CustomButton(
            text: 'Ver mi Wallet',
            onPressed: () {
              Navigator.pushNamed(context, '/wallet');
            },
            isPrimary: true,
            height: 60,
          ),
        ),
        SizedBox(width: AppSpacing.md),
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