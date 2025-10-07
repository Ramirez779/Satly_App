import 'package:flutter/material.dart';

class IntermedioQuiz {
  static final Map<String, dynamic> category = {
    'id': 'intermedio',
    'name': 'Intermedio',
    'color': Colors.orange,
    'icon': Icons.lightbulb_outline,
    'description': 'Conceptos técnicos de Bitcoin',
    'reward': '20 SATS',
    'gradient': [Colors.orangeAccent, Colors.deepOrange],
    'difficulty': '★★☆',
    'quizzes': [ // ← 2 QUIZZES DENTRO DE INTERMEDIO
      // QUIZ 1 - Tecnología Bitcoin
      {
        'id': 'intermedio1',
        'name': 'Tecnología Bitcoin',
        'description': 'Conceptos técnicos intermedios de Bitcoin',
        'questions': [
          {
            'question': '¿Qué es la dificultad de minería?',
            'answers': [
              'Qué tan difícil es encontrar un hash válido',
              'La complejidad de usar Bitcoin',
              'La dificultad para comprar Bitcoin',
              'El problema técnico de la red',
            ],
            'correct': 0,
            'explanation': 'La dificultad ajusta cada 2016 bloques para mantener el tiempo de bloque en 10 minutos.',
          },
          {
            'question': '¿Qué es un hash?',
            'answers': [
              'Una función criptográfica unidireccional',
              'Un tipo de transacción',
              'Una dirección Bitcoin',
              'Un código de seguridad',
            ],
            'correct': 0,
            'explanation': 'Un hash convierte datos de cualquier tamaño en una cadena fija de caracteres.',
          },
          {
            'question': '¿Qué es la prueba de trabajo (PoW)?',
            'answers': [
              'Un sistema que requiere poder computacional',
              'Un método para verificar identidad',
              'Un protocolo de seguridad para wallets',
              'Un tipo de contrato inteligente',
            ],
            'correct': 0,
            'explanation': 'PoW requiere que los mineros resuelvan problemas matemáticos para validar bloques.',
          },
          {
            'question': '¿Qué es la capitalización de mercado?',
            'answers': [
              'Precio actual × cantidad en circulación',
              'El valor total minado',
              'El precio más alto histórico',
              'La cantidad en exchanges',
            ],
            'correct': 0,
            'explanation': 'Se calcula multiplicando el precio actual por el total de bitcoins en circulación.',
          },
        ],
      },
      // QUIZ 2 - Seguridad y Billeteras
      {
        'id': 'intermedio2',
        'name': 'Seguridad y Billeteras',
        'description': 'Seguridad y tipos de billeteras Bitcoin',
        'questions': [
          {
            'question': '¿Qué es una semilla (seed phrase)?',
            'answers': [
              'Conjunto de palabras que genera claves privadas',
              'Un código de backup del wallet',
              'Una contraseña maestra',
              'Un tipo de dirección Bitcoin',
            ],
            'correct': 0,
            'explanation': 'La semilla permite recuperar todas las claves privadas de una billetera.',
          },
          {
            'question': '¿Qué es una billetera HD?',
            'answers': [
              'Hierarchical Deterministic - genera claves jerárquicamente',
              'High Definition - billetera con mejor interfaz',
              'Hardware Device - billetera física',
              'High Security - billetera más segura',
            ],
            'correct': 0,
            'explanation': 'Las billeteras HD pueden generar infinitas direcciones desde una sola semilla.',
          },
          {
            'question': '¿Qué es una billetera multisig?',
            'answers': [
              'Requiere múltiples firmas para transacciones',
              'Una billetera con múltiples criptomonedas',
              'Una billetera compartida entre varias personas',
              'Una billetera con alta seguridad',
            ],
            'correct': 0,
            'explanation': 'Multisig mejora la seguridad requiriendo múltiples aprobaciones.',
          },
          {
            'question': '¿Qué es un explorador de bloques?',
            'answers': [
              'Sitio web para ver transacciones en la blockchain',
              'Una herramienta para minar más rápido',
              'Un software para analizar precios',
              'Una aplicación para comprar Bitcoin',
            ],
            'correct': 0,
            'explanation': 'Permite ver todas las transacciones y bloques de la red Bitcoin.',
          },
        ],
      }
    ],
  };
}