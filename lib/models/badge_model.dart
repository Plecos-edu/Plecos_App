import 'package:flutter/material.dart';

enum BadgeType {
  courseCompletion,
  streak,
  quizMaster,
  earlyAdopter,
  socialLearner,
  speedLearner,
  perfectionist,
  explorer,
}

class Badge {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final BadgeType type;
  final Color color;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int progress; // 0-100 for progress towards unlocking
  final int requiredValue; // Value needed to unlock

  Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    required this.type,
    required this.color,
    this.isUnlocked = false,
    this.unlockedAt,
    this.progress = 0,
    required this.requiredValue,
  });

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iconPath: json['iconPath'],
      type: BadgeType.values.firstWhere(
        (e) => e.toString() == 'BadgeType.${json['type']}',
      ),
      color: Color(json['color']),
      isUnlocked: json['isUnlocked'] ?? false,
      unlockedAt: json['unlockedAt'] != null 
          ? DateTime.parse(json['unlockedAt']) 
          : null,
      progress: json['progress'] ?? 0,
      requiredValue: json['requiredValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconPath': iconPath,
      'type': type.toString().split('.').last,
      'color': color.value,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
      'progress': progress,
      'requiredValue': requiredValue,
    };
  }

  String get progressText {
    if (isUnlocked) {
      return 'Unlocked!';
    }
    return '$progress/$requiredValue';
  }

  double get progressPercentage {
    return progress / requiredValue;
  }

  IconData get icon {
    switch (type) {
      case BadgeType.courseCompletion:
        return Icons.school;
      case BadgeType.streak:
        return Icons.local_fire_department;
      case BadgeType.quizMaster:
        return Icons.quiz;
      case BadgeType.earlyAdopter:
        return Icons.rocket_launch;
      case BadgeType.socialLearner:
        return Icons.people;
      case BadgeType.speedLearner:
        return Icons.speed;
      case BadgeType.perfectionist:
        return Icons.star;
      case BadgeType.explorer:
        return Icons.explore;
    }
  }
} 