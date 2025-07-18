class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String thumbnailUrl;
  final String videoUrl;
  final Duration duration;
  final int viewCount;
  final double rating;
  final int ratingCount;
  final List<String> tags;
  final bool isEnrolled;
  final double progress; // 0.0 to 1.0
  final DateTime lastWatched;
  final bool isDownloaded;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.duration,
    required this.viewCount,
    required this.rating,
    required this.ratingCount,
    required this.tags,
    this.isEnrolled = false,
    this.progress = 0.0,
    required this.lastWatched,
    this.isDownloaded = false,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      instructor: json['instructor'],
      thumbnailUrl: json['thumbnailUrl'],
      videoUrl: json['videoUrl'],
      duration: Duration(minutes: json['durationMinutes']),
      viewCount: json['viewCount'],
      rating: json['rating'].toDouble(),
      ratingCount: json['ratingCount'],
      tags: List<String>.from(json['tags']),
      isEnrolled: json['isEnrolled'] ?? false,
      progress: json['progress']?.toDouble() ?? 0.0,
      lastWatched: DateTime.parse(json['lastWatched']),
      isDownloaded: json['isDownloaded'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'instructor': instructor,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'durationMinutes': duration.inMinutes,
      'viewCount': viewCount,
      'rating': rating,
      'ratingCount': ratingCount,
      'tags': tags,
      'isEnrolled': isEnrolled,
      'progress': progress,
      'lastWatched': lastWatched.toIso8601String(),
      'isDownloaded': isDownloaded,
    };
  }

  String get formattedDuration {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return '${hours}:${minutes.toString().padLeft(2, '0')}';
    }
    return '${minutes} min';
  }

  String get formattedViewCount {
    if (viewCount >= 1000000) {
      return '${(viewCount / 1000000).toStringAsFixed(1)}M views';
    } else if (viewCount >= 1000) {
      return '${(viewCount / 1000).toStringAsFixed(1)}K views';
    }
    return '$viewCount views';
  }

  String get formattedRating {
    return rating.toStringAsFixed(1);
  }
} 