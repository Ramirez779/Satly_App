// data/quiz_categories/basico2_quiz.dart
import 'package:flutter/material.dart';

class Basico2Quiz {
  static final Map<String, dynamic> category = {
    'id': 'basico2',
    'name': 'Básico Vol. 2',
    'color': Colors.blueAccent,
    'icon': Icons.school_rounded,
    'description': 'Más conceptos fundamentales de Bitcoin',
    'reward': '10 SATS',
    'gradient': [Colors.blue, Colors.lightBlue],
    'difficulty': '★☆☆',
  };

  static final List<Map<String, dynamic>> questions = [
    {
      'question': '¿Qué es un bloque en Bitcoin?',
      'answers': [
        'Un conjunto de transacciones confirmadas',
        'Un obstáculo en la red',
        'Un tipo de wallet',
        'Una unidad de minería',
      ],
      'correct': 0,
      'explanation': 'Un bloque es un grupo de transacciones que se confirman y añaden a la blockchain aproximadamente cada 10 minutos.',
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
      'explanation': 'Una transacción se considera confirmada cuando es incluida en un bloque minado en la blockchain.',
    },
    {
      'question': '¿Qué es la prueba de trabajo (Proof of Work)?',
      'answers': [
        'El mecanismo de consenso de Bitcoin',
        'Un sistema de verificación de identidad',
        'Un tipo de wallet seguro',
        'Un método para comprar Bitcoin',
      ],
      'correct': 0,
      'explanation': 'Proof of Work es el algoritmo que los mineros resuelven para validar transacciones y crear nuevos bloques.',
    },
    {
      'question': '¿Qué es la dificultad de minería?',
      'answers': [
        'La medida de lo difícil que es minar un bloque',
        'La complejidad de usar un wallet',
        'El tiempo para confirmar una transacción',
        'El costo de comprar bitcoin',
      ],
      'correct': 0,
      'explanation': 'La dificultad minera se ajusta automáticamente para mantener el tiempo de bloque en aproximadamente 10 minutos.',
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
      'explanation': 'Un satoshi es igual a 0.00000001 BTC, la unidad más pequeña de Bitcoin.',
    },
    {
      'question': '¿Qué es la capitalización de mercado?',
      'answers': [
        'El valor total de todos los Bitcoins en circulación',
        'El precio de un solo Bitcoin',
        'La cantidad de mineros en la red',
        'El volumen de transacciones diarias',
      ],
      'correct': 0,
      'explanation': 'La capitalización de mercado se calcula multiplicando el precio actual por el total de Bitcoins en circulación.',
    },
    {
      'question': '¿Qué es un exchange?',
      'answers': [
        'Plataforma para comprar y vender Bitcoin',
        'Un tipo de wallet hardware',
        'Un protocolo de minería',
        'Una dirección Bitcoin',
      ],
      'correct': 0,
      'explanation': 'Un exchange es una plataforma que permite comprar, vender e intercambiar Bitcoin por otras monedas.',
    },
    {
      'question': '¿Qué significa que Bitcoin es descentralizado?',
      'answers': [
        'No está controlado por ninguna autoridad central',
        'Es anónimo completamente',
        'No tiene valor real',
        'Es ilegal en todos los países',
      ],
      'correct': 0,
      'explanation': 'Bitcoin es descentralizado porque funciona sin un banco central o administrador único, siendo una red peer-to-peer.',
    },
  ];
}