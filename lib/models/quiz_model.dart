import 'package:flutter/material.dart';

enum QuizStatus {
  notStarted,
  inProgress,
  completed,
  passed,
  failed,
}

class Quiz {
  final String id;
  final String title;
  final String description;
  final String courseId;
  final int questionCount;
  final Duration timeLimit;
  final int passingScore;
  final QuizStatus status;
  final int? score;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime dueDate;
  final bool isRequired;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.courseId,
    required this.questionCount,
    required this.timeLimit,
    required this.passingScore,
    this.status = QuizStatus.notStarted,
    this.score,
    this.startedAt,
    this.completedAt,
    required this.dueDate,
    this.isRequired = false,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      courseId: json['courseId'],
      questionCount: json['questionCount'],
      timeLimit: Duration(minutes: json['timeLimitMinutes']),
      passingScore: json['passingScore'],
      status: QuizStatus.values.firstWhere(
        (e) => e.toString() == 'QuizStatus.${json['status']}',
      ),
      score: json['score'],
      startedAt: json['startedAt'] != null 
          ? DateTime.parse(json['startedAt']) 
          : null,
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt']) 
          : null,
      dueDate: DateTime.parse(json['dueDate']),
      isRequired: json['isRequired'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'courseId': courseId,
      'questionCount': questionCount,
      'timeLimitMinutes': timeLimit.inMinutes,
      'passingScore': passingScore,
      'status': status.toString().split('.').last,
      'score': score,
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'isRequired': isRequired,
    };
  }

  String get formattedTimeLimit {
    final hours = timeLimit.inHours;
    final minutes = timeLimit.inMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  String get statusText {
    switch (status) {
      case QuizStatus.notStarted:
        return 'Not Started';
      case QuizStatus.inProgress:
        return 'In Progress';
      case QuizStatus.completed:
        return 'Completed';
      case QuizStatus.passed:
        return 'Passed';
      case QuizStatus.failed:
        return 'Failed';
    }
  }

  Color get statusColor {
    switch (status) {
      case QuizStatus.notStarted:
        return Colors.grey;
      case QuizStatus.inProgress:
        return Colors.orange;
      case QuizStatus.completed:
        return Colors.blue;
      case QuizStatus.passed:
        return Colors.green;
      case QuizStatus.failed:
        return Colors.red;
    }
  }

  IconData get statusIcon {
    switch (status) {
      case QuizStatus.notStarted:
        return Icons.play_circle_outline;
      case QuizStatus.inProgress:
        return Icons.pause_circle_outline;
      case QuizStatus.completed:
        return Icons.check_circle_outline;
      case QuizStatus.passed:
        return Icons.check_circle;
      case QuizStatus.failed:
        return Icons.cancel;
    }
  }

  bool get isOverdue {
    return dueDate.isBefore(DateTime.now()) && status == QuizStatus.notStarted;
  }

  String get scoreText {
    if (score == null) return 'Not taken';
    return '$score%';
  }
} 