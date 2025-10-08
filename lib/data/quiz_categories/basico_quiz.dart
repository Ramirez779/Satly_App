// data/quiz_categories/basico_quiz.dart
import 'package:flutter/material.dart';

class BasicoQuiz {
  static final Map<String, dynamic> category = {
    'id': 'basico',
    'name': 'Básico',
    'color': Colors.blueAccent,
    'icon': Icons.school_rounded,
    'description': 'Conceptos fundamentales de Bitcoin',
    'reward': '20 SATS',
    'gradient': [Colors.blueAccent, Colors.lightBlueAccent],
    'difficulty': '★☆☆',
    'quizzes': [
      // ← LISTA DE QUIZZES DENTRO DE ESTA CATEGORÍA
      {
        'id': 'basico1',
        'name': 'Fundamentos Esenciales',
        'description': 'Conceptos básicos de Bitcoin',
        'questions': [
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
      },
      {
        'id': 'basico2',
        'name': 'Básico Vol. 2',
        'description': 'Más conceptos fundamentales',
        'questions': [
          {
            'question': '¿Qué es un bloque en Bitcoin?',
            'answers': [
              'Un conjunto de transacciones confirmadas',
              'Un obstáculo en la red',
              'Un tipo de wallet',
              'Una unidad de minería',
            ],
            'correct': 0,
            'explanation':
                'Un bloque es un grupo de transacciones que se confirman y añaden a la blockchain.',
          },
          {
            'question': '¿Qué es la confirmación de una transacción?',
            'answers': [
              'Cuando una transacción se incluye en un bloque',
              'Cuando recibes un email de confirmación',
              'Cuando el vendedor confirma el pago',
              'Cuando se verifica tu identidad',
            ],
            'correct': 0,
            'explanation':
                'Una transacción se considera confirmada cuando es incluida en un bloque minado.',
          },
          {
            'question': '¿Qué es la prueba de trabajo?',
            'answers': [
              'El mecanismo de consenso de Bitcoin',
              'Un sistema de verificación de identidad',
              'Un tipo de wallet seguro',
              'Un método para comprar Bitcoin',
            ],
            'correct': 0,
            'explanation':
                'Proof of Work es el algoritmo que los mineros resuelven para validar transacciones.',
          },
          {
            'question': '¿Qué es un satoshi?',
            'answers': [
              'La unidad más pequeña de Bitcoin',
              'El creador de Bitcoin',
              'Un tipo de minero',
              'Un algoritmo de seguridad',
            ],
            'correct': 0,
            'explanation':
                'Un satoshi es igual a 0.00000001 BTC, la unidad más pequeña de Bitcoin.',
          },
        ],
      },
    ],
  };
}
