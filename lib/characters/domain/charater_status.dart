// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:rick_and_morty_wiki/core/theme/color_theme.dart';

enum CharacterStatus {
  Alive(label: 'Vivo', color: ColorTheme.tertiary),
  Dead(label: 'Morto', color: Colors.red),
  unknown(label: 'Status desconhecido', color: Colors.grey);

  final String label;
  final Color color;

  const CharacterStatus({required this.label, required this.color});
}
