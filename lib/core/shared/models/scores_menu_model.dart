import 'package:flutter/material.dart';
import 'package:memory_game/core/utils/utils.dart';

class ScoreMenuModel {
  final int difficultyValue;
  final Color? backgroundColor;
  final String difficultyName;

  ScoreMenuModel({
    required this.difficultyValue,
    required this.difficultyName,
    this.backgroundColor = AppColors.text,
  });

  static List<ScoreMenuModel> scoreMenuList() {
    return [
      ScoreMenuModel(difficultyValue: 1, difficultyName: 'Easy Mode'),
      ScoreMenuModel(difficultyValue: 2, difficultyName: 'Medium Mode'),
      ScoreMenuModel(difficultyValue: 3, difficultyName: 'Hard Mode'),
    ];
  }
}
