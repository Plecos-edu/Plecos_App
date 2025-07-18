import 'package:flutter/material.dart';

enum ActivityType {
  projectCreated,
  taskCompleted,
  teamMemberJoined,
  projectUpdated,
  meetingScheduled,
  commentAdded,
  fileUploaded,
}

class Activity {
  final String id;
  final String title;
  final String description;
  final ActivityType type;
  final DateTime timestamp;
  final String userId;
  final String userName;
  final Map<String, dynamic>? metadata;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.timestamp,
    required this.userId,
    required this.userName,
    this.metadata,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: ActivityType.values.firstWhere(
        (e) => e.toString() == 'ActivityType.${json['type']}',
      ),
      timestamp: DateTime.parse(json['timestamp']),
      userId: json['userId'],
      userName: json['userName'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'userId': userId,
      'userName': userName,
      'metadata': metadata,
    };
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  IconData get icon {
    switch (type) {
      case ActivityType.projectCreated:
        return Icons.folder_outlined;
      case ActivityType.taskCompleted:
        return Icons.check_circle_outline;
      case ActivityType.teamMemberJoined:
        return Icons.person_add_outlined;
      case ActivityType.projectUpdated:
        return Icons.update_outlined;
      case ActivityType.meetingScheduled:
        return Icons.event_outlined;
      case ActivityType.commentAdded:
        return Icons.comment_outlined;
      case ActivityType.fileUploaded:
        return Icons.file_upload_outlined;
    }
  }

  Color get color {
    switch (type) {
      case ActivityType.projectCreated:
        return const Color(0xFF3B82F6);
      case ActivityType.taskCompleted:
        return const Color(0xFF10B981);
      case ActivityType.teamMemberJoined:
        return const Color(0xFFF59E0B);
      case ActivityType.projectUpdated:
        return const Color(0xFF8B5CF6);
      case ActivityType.meetingScheduled:
        return const Color(0xFFEF4444);
      case ActivityType.commentAdded:
        return const Color(0xFF06B6D4);
      case ActivityType.fileUploaded:
        return const Color(0xFF84CC16);
    }
  }
} 