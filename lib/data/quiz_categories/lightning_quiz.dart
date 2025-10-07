// data/quiz_categories/lightning_quiz.dart
import 'package:flutter/material.dart';

class LightningQuiz {
  static final Map<String, dynamic> category = {
    'id': 'lightning',
    'name': 'Lightning Network',
    'color': Colors.green,
    'icon': Icons.bolt_rounded,
    'description': 'Pagos instantáneos y de bajo costo',
    'reward': '25 SATS',
    'gradient': [Colors.greenAccent, Colors.tealAccent],
    'difficulty': '★★☆',
    'quizzes': [
      // ← AQUÍ VAN LOS 2 QUIZZES
      // QUIZ 1 - EL QUE YA TENÍAS
      {
        'id': 'lightning1',
        'name': 'Fundamentos Lightning',
        'description': 'Conceptos básicos de Lightning Network',
        'questions': [
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
      },
      // QUIZ 2 - NUEVO QUIZ QUE AGREGAS
      {
        'id': 'lightning2',
        'name': 'Lightning Avanzado',
        'description': 'Conceptos avanzados y operación de la red',
        'questions': [
          {
            'question': '¿Qué es un HTLC (Hashed Timelock Contract)?',
            'answers': [
              'Contrato que permite pagos a través de múltiples nodos',
              'Un tipo de wallet Lightning',
              'Un protocolo de seguridad',
              'Un método de backup',
            ],
            'correct': 0,
            'explanation':
                'HTLC permite pagos a través de múltiples canales usando hashes y timelocks.',
          },
          {
            'question': '¿Qué es la capacidad de un canal?',
            'answers': [
              'La cantidad total de satoshis en el canal',
              'La velocidad de transacción',
              'El número de transacciones posibles',
              'El tamaño del archivo del canal',
            ],
            'correct': 0,
            'explanation':
                'La capacidad es el total de satoshis bloqueados en el canal entre dos partes.',
          },
          {
            'question': '¿Qué es routing en Lightning?',
            'answers': [
              'Encontrar una ruta entre nodos para un pago',
              'La dirección de un nodo',
              'Un protocolo de minería',
              'Un método para abrir canales',
            ],
            'correct': 0,
            'explanation':
                'El routing encuentra la mejor ruta a través de la red para entregar un pago.',
          },
          {
            'question': '¿Qué es una invoice de Lightning?',
            'answers': [
              'Una factura con los detalles de un pago',
              'Un recibo de transacción',
              'Un contrato de canal',
              'Un código de error',
            ],
            'correct': 0,
            'explanation':
                'Una invoice contiene toda la información necesaria para realizar un pago Lightning.',
          },
        ],
      },
    ],
  };
}
