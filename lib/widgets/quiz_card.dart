// lib/views/quiz_page.dart
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Quiz"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Pregunta 1 de 5",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text("¿Cuánto es 2 + 2?", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            CustomButton(text: "3", onPressed: () {}),
            CustomButton(text: "4", onPressed: () {}),
            CustomButton(text: "5", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
