import 'package:flutter/material.dart';

class CardEntity {
  final int value;
  final IconData icon;
  int? id;
  bool isFound = false;
  bool isSelected = false;

  CardEntity({
    required this.value,
    required this.icon,
    this.id,
  });

  void found() {
    isFound = true;
  }

  void forget() {
    isFound = false;
  }

  void select() {
    isSelected = true;
  }

  void deselect() {
    isSelected = false;
  }

  static final List<CardEntity> baseCardList = [
    CardEntity(value: 1, icon: Icons.home_sharp),
    CardEntity(value: 2, icon: Icons.pedal_bike_outlined),
    CardEntity(value: 3, icon: Icons.pets_outlined),
    CardEntity(value: 4, icon: Icons.ac_unit),
    CardEntity(value: 5, icon: Icons.access_alarm),
    CardEntity(value: 6, icon: Icons.accessibility_new_outlined),
    CardEntity(value: 1, icon: Icons.home_sharp),
    CardEntity(value: 2, icon: Icons.pedal_bike_outlined),
    CardEntity(value: 3, icon: Icons.pets_outlined),
    CardEntity(value: 4, icon: Icons.ac_unit),
    CardEntity(value: 5, icon: Icons.access_alarm),
    CardEntity(value: 6, icon: Icons.accessibility_new_outlined),
  ];
  static final List<CardEntity> mediumCardList = [
    CardEntity(value: 7, icon: Icons.card_giftcard_outlined),
    CardEntity(value: 8, icon: Icons.light_mode_outlined),
    CardEntity(value: 7, icon: Icons.card_giftcard_outlined),
    CardEntity(value: 8, icon: Icons.light_mode_outlined),
  ];
  static final List<CardEntity> hardCardList = [
    CardEntity(value: 9, icon: Icons.emoji_objects),
    CardEntity(value: 10, icon: Icons.emoji_people),
    CardEntity(value: 9, icon: Icons.emoji_objects),
    CardEntity(value: 10, icon: Icons.emoji_people),
  ];
}
