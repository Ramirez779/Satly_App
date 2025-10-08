// data/quiz_categories/avanzado_quiz.dart
import 'package:flutter/material.dart';

class AvanzadoQuiz {
  static final Map<String, dynamic> category = {
    'id': 'avanzado',
    'name': 'Avanzado',
    'color': Colors.purple,
    'icon': Icons.auto_awesome_rounded,
    'description': 'Para expertos en Bitcoin',
    'reward': '30 SATS',
    'gradient': [Colors.purpleAccent, Colors.deepPurpleAccent],
    'difficulty': '★★★',
    'quizzes': [
      // ← AQUÍ VAN LOS 2 QUIZZES
      // QUIZ 1 - EL QUE YA TENÍAS
      {
        'id': 'avanzado1',
        'name': 'Tecnologías Avanzadas',
        'description': 'Actualizaciones y tecnologías complejas de Bitcoin',
        'questions': [
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
      },
      // QUIZ 2 - NUEVO QUIZ QUE AGREGAS
      {
        'id': 'avanzado2',
        'name': 'Protocolos Avanzados',
        'description': 'Protocolos y funcionamiento interno de Bitcoin',
        'questions': [
          {
            'question': '¿Qué es el lenguaje de script de Bitcoin?',
            'answers': [
              'Un lenguaje de programación simple para transacciones',
              'Un código para minar más rápido',
              'Un protocolo de comunicación entre nodos',
              'Un lenguaje para crear wallets',
            ],
            'correct': 0,
            'explanation':
                'Bitcoin Script es un lenguaje simple que define las condiciones para gastar bitcoins.',
          },
          {
            'question': '¿Qué es un OP_CODE?',
            'answers': [
              'Una operación en el lenguaje de script de Bitcoin',
              'Un código de error en la red',
              'Un protocolo de optimización',
              'Un tipo de dirección Bitcoin',
            ],
            'correct': 0,
            'explanation':
                'Los OP_CODES son operaciones que definen la lógica de las transacciones Bitcoin.',
          },
          {
            'question': '¿Qué es el replace-by-fee (RBF)?',
            'answers': [
              'Permite reemplazar una transacción no confirmada',
              'Un método para reducir comisiones',
              'Un tipo de ataque a la red',
              'Un protocolo de minería',
            ],
            'correct': 0,
            'explanation':
                'RBF permite reemplazar una transacción no confirmada con una que paga mayor comisión.',
          },
          {
            'question': '¿Qué son las transacciones CoinJoin?',
            'answers': [
              'Transacciones que mezclan inputs de múltiples usuarios',
              'Transacciones entre exchanges',
              'Transacciones con comisiones muy bajas',
              'Transacciones de minería conjunta',
            ],
            'correct': 0,
            'explanation':
                'CoinJoin mejora la privacidad mezclando transacciones de múltiples usuarios.',
          },
        ],
      },
    ],
  };
}
