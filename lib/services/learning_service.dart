import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../models/playlist_model.dart';
import '../models/badge_model.dart' as model;
import '../models/quiz_model.dart';

class LearningService {
  // Mock data for demonstration
  static final List<Course> _mockCourses = [
    Course(
      id: '1',
      title: 'Flutter Development for Beginners',
      description: 'Learn Flutter from scratch and build your first mobile app',
      instructor: 'John Doe',
      thumbnailUrl: 'https://picsum.photos/300/200?random=1',
      videoUrl: 'https://example.com/video1.mp4',
      duration: Duration(minutes: 45),
      viewCount: 12500,
      rating: 4.8,
      ratingCount: 342,
      tags: ['Flutter', 'Mobile', 'Dart'],
      isEnrolled: true,
      progress: 0.75,
      lastWatched: DateTime.now().subtract(Duration(hours: 2)),
      isDownloaded: false,
    ),
    Course(
      id: '2',
      title: 'Advanced React Native',
      description: 'Master React Native with advanced concepts and best practices',
      instructor: 'Jane Smith',
      thumbnailUrl: 'https://picsum.photos/300/200?random=2',
      videoUrl: 'https://example.com/video2.mp4',
      duration: Duration(minutes: 120),
      viewCount: 8900,
      rating: 4.9,
      ratingCount: 156,
      tags: ['React Native', 'JavaScript', 'Mobile'],
      isEnrolled: true,
      progress: 0.25,
      lastWatched: DateTime.now().subtract(Duration(days: 1)),
      isDownloaded: true,
    ),
    Course(
      id: '3',
      title: 'UI/UX Design Fundamentals',
      description: 'Learn the basics of user interface and user experience design',
      instructor: 'Mike Johnson',
      thumbnailUrl: 'https://picsum.photos/300/200?random=3',
      videoUrl: 'https://example.com/video3.mp4',
      duration: Duration(minutes: 90),
      viewCount: 15600,
      rating: 4.7,
      ratingCount: 289,
      tags: ['Design', 'UI/UX', 'Figma'],
      isEnrolled: false,
      progress: 0.0,
      lastWatched: DateTime.now().subtract(Duration(days: 3)),
      isDownloaded: false,
    ),
    Course(
      id: '4',
      title: 'Python for Data Science',
      description: 'Master Python programming for data analysis and machine learning',
      instructor: 'Sarah Wilson',
      thumbnailUrl: 'https://picsum.photos/300/200?random=4',
      videoUrl: 'https://example.com/video4.mp4',
      duration: Duration(minutes: 180),
      viewCount: 22000,
      rating: 4.6,
      ratingCount: 445,
      tags: ['Python', 'Data Science', 'Machine Learning'],
      isEnrolled: true,
      progress: 1.0,
      lastWatched: DateTime.now().subtract(Duration(days: 5)),
      isDownloaded: false,
    ),
  ];

  static final List<Playlist> _mockPlaylists = [
    Playlist(
      id: '1',
      title: 'Mobile Development Mastery',
      description: 'Complete guide to mobile app development',
      creator: 'John Doe',
      thumbnailUrl: 'https://picsum.photos/300/200?random=5',
      courseCount: 12,
      totalDuration: Duration(hours: 8, minutes: 30),
      createdAt: DateTime.now().subtract(Duration(days: 30)),
      lastUpdated: DateTime.now().subtract(Duration(days: 2)),
      courseIds: ['1', '2', '3'],
    ),
    Playlist(
      id: '2',
      title: 'Web Development Bootcamp',
      description: 'Learn full-stack web development',
      creator: 'Jane Smith',
      thumbnailUrl: 'https://picsum.photos/300/200?random=6',
      courseCount: 8,
      totalDuration: Duration(hours: 12, minutes: 45),
      createdAt: DateTime.now().subtract(Duration(days: 45)),
      lastUpdated: DateTime.now().subtract(Duration(days: 1)),
      courseIds: ['4', '5', '6'],
    ),
  ];

  static final List<model.Badge> _mockBadges = [
    model.Badge(
      id: '1',
      name: 'First Course',
      description: 'Complete your first course',
      iconPath: 'assets/badges/first_course.png',
      type: model.BadgeType.courseCompletion,
      color: Colors.blue,
      isUnlocked: true,
      unlockedAt: DateTime.now().subtract(Duration(days: 10)),
      progress: 100,
      requiredValue: 1,
    ),
    model.Badge(
      id: '2',
      name: '7-Day Streak',
      description: 'Learn for 7 consecutive days',
      iconPath: 'assets/badges/streak.png',
      type: model.BadgeType.streak,
      color: Colors.orange,
      isUnlocked: false,
      progress: 5,
      requiredValue: 7,
    ),
    model.Badge(
      id: '3',
      name: 'Quiz Master',
      description: 'Pass 10 quizzes with 90% or higher',
      iconPath: 'assets/badges/quiz_master.png',
      type: model.BadgeType.quizMaster,
      color: Colors.green,
      isUnlocked: false,
      progress: 3,
      requiredValue: 10,
    ),
  ];

  static final List<Quiz> _mockQuizzes = [
    Quiz(
      id: '1',
      title: 'Flutter Basics Quiz',
      description: 'Test your knowledge of Flutter fundamentals',
      courseId: '1',
      questionCount: 20,
      timeLimit: Duration(minutes: 30),
      passingScore: 70,
      status: QuizStatus.passed,
      score: 85,
      startedAt: DateTime.now().subtract(Duration(days: 2)),
      completedAt: DateTime.now().subtract(Duration(days: 2, hours: 1)),
      dueDate: DateTime.now().add(Duration(days: 5)),
      isRequired: true,
    ),
    Quiz(
      id: '2',
      title: 'React Native Advanced',
      description: 'Advanced React Native concepts assessment',
      courseId: '2',
      questionCount: 25,
      timeLimit: Duration(minutes: 45),
      passingScore: 75,
      status: QuizStatus.notStarted,
      dueDate: DateTime.now().add(Duration(days: 10)),
      isRequired: true,
    ),
    Quiz(
      id: '3',
      title: 'UI/UX Design Quiz',
      description: 'Test your design knowledge',
      courseId: '3',
      questionCount: 15,
      timeLimit: Duration(minutes: 20),
      passingScore: 60,
      status: QuizStatus.failed,
      score: 55,
      startedAt: DateTime.now().subtract(Duration(days: 1)),
      completedAt: DateTime.now().subtract(Duration(days: 1, hours: 1)),
      dueDate: DateTime.now().subtract(Duration(days: 1)),
      isRequired: false,
    ),
  ];

  // Get enrolled courses
  Future<List<Course>> getEnrolledCourses() async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
    return _mockCourses.where((course) => course.isEnrolled).toList();
  }

  // Get watch later courses
  Future<List<Course>> getWatchLaterCourses() async {
    await Future.delayed(Duration(milliseconds: 300));
    return _mockCourses.where((course) => !course.isEnrolled).toList();
  }

  // Get playlists
  Future<List<Playlist>> getPlaylists() async {
    await Future.delayed(Duration(milliseconds: 400));
    return _mockPlaylists;
  }

  // Get downloaded courses
  Future<List<Course>> getDownloadedCourses() async {
    await Future.delayed(Duration(milliseconds: 200));
    return _mockCourses.where((course) => course.isDownloaded).toList();
  }

  // Get course history
  Future<List<Course>> getCourseHistory() async {
    await Future.delayed(Duration(milliseconds: 300));
    return _mockCourses.where((course) => course.progress > 0).toList();
  }

  // Get quizzes
  Future<List<Quiz>> getQuizzes() async {
    await Future.delayed(Duration(milliseconds: 400));
    return _mockQuizzes;
  }

  // Get badges
  Future<List<model.Badge>> getBadges() async {
    await Future.delayed(Duration(milliseconds: 300));
    return _mockBadges;
  }

  // Get progress statistics
  Future<Map<String, dynamic>> getProgressStats() async {
    await Future.delayed(Duration(milliseconds: 500));
    
    final enrolledCourses = _mockCourses.where((course) => course.isEnrolled);
    final totalCourses = enrolledCourses.length;
    final completedCourses = enrolledCourses.where((course) => course.progress >= 1.0).length;
    final inProgressCourses = enrolledCourses.where((course) => course.progress > 0 && course.progress < 1.0).length;
    final averageProgress = enrolledCourses.isEmpty ? 0.0 : enrolledCourses.map((c) => c.progress).reduce((a, b) => a + b) / totalCourses;
    
    final passedQuizzes = _mockQuizzes.where((quiz) => quiz.status == QuizStatus.passed).length;
    final totalQuizzes = _mockQuizzes.length;
    
    final unlockedBadges = _mockBadges.where((badge) => badge.isUnlocked).length;
    final totalBadges = _mockBadges.length;

    return {
      'totalCourses': totalCourses,
      'completedCourses': completedCourses,
      'inProgressCourses': inProgressCourses,
      'averageProgress': (averageProgress * 100).round(),
      'passedQuizzes': passedQuizzes,
      'totalQuizzes': totalQuizzes,
      'unlockedBadges': unlockedBadges,
      'totalBadges': totalBadges,
      'currentStreak': 5, // Mock streak data
      'totalWatchTime': Duration(hours: 24, minutes: 30), // Mock watch time
    };
  }

  // Add course to watch later
  Future<void> addToWatchLater(String courseId) async {
    await Future.delayed(Duration(milliseconds: 200));
    // In a real app, this would update the backend
    print('Added course $courseId to watch later');
  }

  // Download course
  Future<void> downloadCourse(String courseId) async {
    await Future.delayed(Duration(milliseconds: 1000));
    // In a real app, this would download the course content
    print('Downloaded course $courseId');
  }

  // Start quiz
  Future<void> startQuiz(String quizId) async {
    await Future.delayed(Duration(milliseconds: 300));
    // In a real app, this would update the quiz status
    print('Started quiz $quizId');
  }

  // Get notifications
  Future<List<Map<String, dynamic>>> getNotifications() async {
    await Future.delayed(Duration(milliseconds: 400));
    
    return [
      {
        'id': '1',
        'title': 'New course available',
        'message': 'Flutter Advanced Concepts is now available',
        'type': 'course',
        'timestamp': DateTime.now().subtract(Duration(hours: 2)),
        'isRead': false,
      },
      {
        'id': '2',
        'title': 'Quiz reminder',
        'message': 'Don\'t forget to complete the React Native quiz',
        'type': 'quiz',
        'timestamp': DateTime.now().subtract(Duration(days: 1)),
        'isRead': true,
      },
      {
        'id': '3',
        'title': 'Badge earned',
        'message': 'Congratulations! You earned the First Course badge',
        'type': 'badge',
        'timestamp': DateTime.now().subtract(Duration(days: 2)),
        'isRead': true,
      },
    ];
  }
} 