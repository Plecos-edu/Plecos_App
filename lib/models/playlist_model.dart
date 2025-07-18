class Playlist {
  final String id;
  final String title;
  final String description;
  final String creator;
  final String thumbnailUrl;
  final int courseCount;
  final Duration totalDuration;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final List<String> courseIds;

  Playlist({
    required this.id,
    required this.title,
    required this.description,
    required this.creator,
    required this.thumbnailUrl,
    required this.courseCount,
    required this.totalDuration,
    this.isPublic = true,
    required this.createdAt,
    required this.lastUpdated,
    required this.courseIds,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      creator: json['creator'],
      thumbnailUrl: json['thumbnailUrl'],
      courseCount: json['courseCount'],
      totalDuration: Duration(minutes: json['totalDurationMinutes']),
      isPublic: json['isPublic'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      lastUpdated: DateTime.parse(json['lastUpdated']),
      courseIds: List<String>.from(json['courseIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creator': creator,
      'thumbnailUrl': thumbnailUrl,
      'courseCount': courseCount,
      'totalDurationMinutes': totalDuration.inMinutes,
      'isPublic': isPublic,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'courseIds': courseIds,
    };
  }

  String get formattedDuration {
    final hours = totalDuration.inHours;
    final minutes = totalDuration.inMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  String get formattedCourseCount {
    return '$courseCount ${courseCount == 1 ? 'course' : 'courses'}';
  }
} 