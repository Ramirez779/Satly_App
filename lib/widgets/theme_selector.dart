// lib/widgets/theme_selector.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final mode = provider.themeMode;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tema',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Claro'),
              value: ThemeMode.light,
              groupValue: mode,
              onChanged: (v) => provider.setTheme(v ?? ThemeMode.light),
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Oscuro'),
              value: ThemeMode.dark,
              groupValue: mode,
              onChanged: (v) => provider.setTheme(v ?? ThemeMode.dark),
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Seguir sistema'),
              value: ThemeMode.system,
              groupValue: mode,
              onChanged: (v) => provider.setTheme(v ?? ThemeMode.system),
            ),
          ],
        ),
      ),
    );
  }
}
